# For rollouts, try argo cd...
# A service is created for each deployment, so there is something to point to per test!

current_color=kubectl get svc nginx -o json | jq '.spec.selector.color'

if [[ "$current_color" = "green" ]]; then
  color_to_update="blue"
else
  color_to_update="green"
fi

kubectl set image deployment.v1.apps/nginx-green nginx=nginx:1.23

while ! kubectl rollout status deployment/nginx-green; do
  echo "still rolling out"
  sleep 1
done

while true; do
  kubectl port-forward svc/nginx-green 10001:80 &
  pf_pid=$!
  if http get http://localhost:10001; then
    kill $pf_pid
    break
  fi
  echo "green is not yet ready"
  sleep 1
  kill $pf_pid
done

echo "switching the service"
kubectl patch service nginx -p "{\"spec\": {\"selector\": {\"color\": ${color_to_update}}}}"

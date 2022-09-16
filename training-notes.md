[A Kubernetes quick start for people who know just enough about Docker to get by](https://blog.sourcerer.io/a-kubernetes-quick-start-for-people-who-know-just-enough-about-docker-to-get-by-71c5933b4633)

To deploy smt, we need 2 things
-> Name of the type of thing
-> Which api the thing lives

pod has it's own nic, to allow mgmt of

pod can't have the same port, on the same NIC, on the same port

Types of services
===

- clustIP
- nodeport
- loadbalacner

iptables giant lookup table -> helps translates service to...

kubeproxy is a small pod runs on every node.

Service does not write process, jsut writes configuration?...
address resolution protocol request -> ask ...

Distribution happens during iptables..

Rolling out
===

Teams don't always rollout, they can just revert to commit, and apply instead!

Blue-green deployments
===

2 environments, switch + test live env, before switching!
This decouples the release from deployment, i.e. unlike rollouts

canary deployments
-> bash script to wait until ready -> and then move to blue deployment

===

10% of users to new version
-> downside: no stickiness i.e. a user can use the new model, and then next time use the old model. Weird.

===

Exercise..

write some job based tests, if infra works as expected.

Use a job to run the Airflow database initialisation and user creation command line tools
=> Continue from the assignment of last week.

airflow db init
airflow users create -e airflow@airflow.com -f airflow -l airflow -p airflow -r Admin -u airflow

kubectl logs...

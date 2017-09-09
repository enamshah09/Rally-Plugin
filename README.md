# Introduction

[Rally](http://rally.readthedocs.io/en/latest/plugins/index.html) is benchmarking tool to test your openstack environment. Rally provides an opportunity to create and use a custom task scenario, runner, SLA, deployment or context as a plugin. This plugin will install Rally and run the Live Migration test to evacuate a host.

## **Steps**

Assuming you have [multi-node devstack install](https://docs.openstack.org/devstack/latest/guides/multinode-lab.html). After you clone the repo remember to change the IP of the controller in `adminCredentials.json`, `demoCredentials.json` and in `vars.rc` file to chnage the source and destination host.

1. Clone the repo and change the directory to `cd /opt`
```
git clone https://github.com/enamshah09/RallyPlugin.git /opt/ownPlugin
```
2. Move the setup and variables file to `/opt` directory
```
mv /opt/ownPlugin/setupLvmEnv.sh /opt
mv /opt/ownPlugin/vars.rc /opt
```
3. The following command will install Rally and run the Live Migration Plugin to Evacuate Host
```
./setupLvmEnv.sh
```

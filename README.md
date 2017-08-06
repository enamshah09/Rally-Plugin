# Rally Plugin

This Plugin will install Rally and run the Live Migration Plugin. 

## **Steps**

Assuming you have [multi-node devstack install](https://docs.openstack.org/devstack/latest/guides/multinode-lab.html). After you clone the repo remember to change the IP of the controller in `credentials.json`

```
git clone https://github.com/enamshah09/RallyPlugin.git /opt/ownPlugin
cd /opt/ownPlugin
mv setupLvmEnv.sh /opt
mv vars.rc /opt
cd /opt
./setupLvmEnv.sh
```

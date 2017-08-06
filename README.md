# Rally Plugin

This Plugin will install Rally and run the Live Migration Plugin. 

## **Steps**

Assuming you have [multi-node devstack install](https://docs.openstack.org/devstack/latest/guides/multinode-lab.html). After you clone the repo remember to change the IP of the controller in `credentials.json`

1. Clone the repo and change the directory to `cd /opt/ownPlugin`
```
git clone https://github.com/enamshah09/RallyPlugin.git /opt/ownPlugin
```
2. Move the setup and variables file to `/opt` directory
```
mv setupLvmEnv.sh /opt
mv vars.rc /opt
```
3. Run the following file that will install Rally and run the Plugin to Evacuate Host
```
./setupLvmEnv.sh
```

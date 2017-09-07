source vars.rc

cd /opt/stack/devstack
source openrc admin admin

cd /opt

# create the environment 
if [ `openstack flavor list | grep m1 -c` -eq 0 ]; then
  #nova flavor-create {flavor-name} {flavor-id} {Memory_MB} {Disk-GB} {VCPUs}
  nova flavor-create m1.tiny 1 512 1 1;
  nova flavor-create m1.small 2 2048 20 1;
  nova flavor-create m1.medium 3 4096 40 2;
  nova flavor-create m1.large 4 8192 80 4;
  nova flavor-create m1.xlarge 5 16384 160 8;
fi

if [ `openstack keypair list | grep $key_name -c` -eq 0 ]; then
 # openstack keypair delete $key_name
  openstack keypair create $key_name > /root/$key_name.pem
  chmod 400 /root/$key_name.pem
fi

# add a Ubuntu16.04 image
if [ `glance image-list | grep $image_name -c ` -eq 0 ]; then
  wget https://cloud-images.ubuntu.com/xenial/current/xenial-server-cloudimg-amd64-disk1.img
  glance image-create --name $image_name \
                    --container-format bare \
                    --disk-format qcow2 \
                    --visibility public \
                    --progress \
                    --file xenial-server-cloudimg-amd64-disk1.img
  rm xenial-server-cloudimg-amd64-disk1.img
fi

# setup rally and lvm rally tool
apt-get update
apt-get install python
apt-get install python-pip libffi-dev libpq-dev libssl-dev libxml2-dev libxslt1-dev
git clone https://github.com/openstack/rally.git /opt/rally -b stable/0.9
cd /opt/rally/
./install_rally.sh


rm -r /opt/ownPlugin
git clone https://github.com/enamshah09/RallyPlugin.git /opt/ownPlugin
cd /opt/ownPlugin
rm -r /usr/local/lib/python2.7/dist-packages/rally/task/validation.py
rm -r /usr/local/lib/python2.7/dist-packages/rally/task/scenario.py
cp validation.py /usr/local/lib/python2.7/dist-packages/rally/task/
cp scenario.py /usr/local/lib/python2.7/dist-packages/rally/task/
chown root:staff /usr/local/lib/python2.7/dist-packages/rally/task/validation.py
chown root:staff /usr/local/lib/python2.7/dist-packages/rally/task/scenario.py

#For the host Evacuation it is always the admin who has permissions to migrate
#Depending on which user you want to use

#demo User
rally deployment destroy demoEvacuate
rally deployment create --file=demoCredentials.json --name=demoEvacuate
rally deployment use demoEvacuate

#admin User
rally deployment destroy adminEvacuate
rally deployment create --file=adminCredentials.json --name=adminEvacuate
rally deployment use adminEvacuate

#Evacuate host
rally --debug --plugin-paths nova_live_migration.py task start task.json --task-args '{"image_name": "Ubuntu16.04", "flavor_name": "m1.medium", "block_migration": false, "host_to_evacuate": "computecos2", "destination_host": "computecos3"}'



# the role should run the default recipe (for apt-get update and other universally required tasks)

# Need to set up volumes (assuming running on OpenStack).... maybe worth grabbing the OpenStack cookbook from Moodle Stuff

# We have the volumes mounted with a FS, so now we need to create an array of paths that will be used as nodes for elasticsearch
#this needs to be done dynamically, but this will get us off the ground for now
volumes = ["/elasticsearch/volume_1"]
node.set[:elasticsearch][:paths][:data] = volumes unless volumes.empty?




include_recipe "java"
include_recipe "elasticsearch"
include_recipe "elasticsearch::proxy"
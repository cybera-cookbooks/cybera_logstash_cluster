name "logstash_server"
description "This will set up an Elastic Search node"
run_list(
  "recipe[cybera_logstash_cluster]"
)

default_attributes()
override_attributes()

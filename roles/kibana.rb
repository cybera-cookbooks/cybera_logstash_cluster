name "kibana"
description "This will set up Kibana"
run_list(
  "recipe[cybera_logstash_cluster]"
)

default_attributes()
override_attributes()

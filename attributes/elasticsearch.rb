return unless node[:roles].include?("elasticsearch")

elastic_search_config_path = "/etc/elasticsearch"

default.elasticsearch.path[:conf] = "/etc/elasticsearch"
default.elasticsearch.path[:logs] = "/var/log/elasticsearch"
# This should be an array if there is more than one node to be hosted on a machine
# likely this would be overridden in the elasticsearch wrapper recipe
default.elasticsearch.path[:data] = ["/elasticsearch/volume_1"]

default.elasticsearch.nginx[:allow_cluster_api] = true
default.elasticsearch.nginx[:passwords_file] = "#{default.elasticsearch.path.conf}/passwords"

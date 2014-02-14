return unless node[:roles].include?("kibana")
default[:kibana][:ssl][:enabled] = node[:ssl][:enabled]
default[:kibana][:webserver_port] = (node[:kibana][:ssl][:enabled] ? 443 : 80)

elasticsearch_nodes = partial_search(:node, 'role:elasticsearch', 
  keys: {
    "ipaddress" => ["ipaddress"]
  }
)
override[:kibana][:es_server] =  (elasticsearch_nodes.empty? ? "localhost" : elasticsearch_nodes.first["ipaddress"])
default[:kibana][:es_port] = 9200

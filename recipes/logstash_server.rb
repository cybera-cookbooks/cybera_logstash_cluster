# get elastic search host
elasticsearch_nodes = partial_search(:node, "chef_environment:#{node.environment} AND role:elasticsearch",
  :keys => {
    'fqdn'     => [ 'fqdn' ],
    'ipaddress' => [ 'ipaddress' ]
    }
  )

node.set[:logstash][:config][:outputs][:elasticsearch][:variables][:host] = elasticsearch_nodes.first['ipaddress']

broker_node = partial_search(:node, "chef_environment:#{node.environment} AND role:broker", 
  keys: {
    "ipaddress"   => ["ipaddress"],
    "user"        => ["rabbitmq", "default_user"],
    "password"    => ["rabbitmq", "default_pass"],
    "ssl_enabled" => ["rabbitmq", "ssl"]
  }
).first
if node[:logstash][:broker][:type] == "rabbitmq" and broker_node
  node.set[:logstash][:config][:inputs][:rabbitmq][:variables][:host] = broker_node["ipaddress"]
  node.set[:logstash][:config][:inputs][:rabbitmq][:variables][:port] = node[:logstash][:broker][:port]
  node.set[:logstash][:config][:inputs][:rabbitmq][:variables][:user] = broker_node["user"]
  node.set[:logstash][:config][:inputs][:rabbitmq][:variables][:password] = broker_node["password"]
  node.set[:logstash][:config][:inputs][:rabbitmq][:variables][:ssl_enabled] = broker_node["ssl_enabled"]
end


include_recipe "java"
include_recipe "cybera_logstash"
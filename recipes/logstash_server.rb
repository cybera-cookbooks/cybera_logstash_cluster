if node[:logstash][:broker]
  include_recipe "rabbitmq"
  rabbitmq_user node[:rabbitmq][:default_user] do
    password node[:rabbitmq][:default_pass]
    action :add
  end
  rabbitmq_user node[:rabbitmq][:default_user] do
    permissions ".* .* .*"
    action :set_permissions
  end
end

# get elastic search host
elasticsearch_nodes = partial_search(:node, "role:elasticsearch",
  :keys => {
    'fqdn'     => [ 'fqdn' ],
    'ipaddress' => [ 'ipaddress' ]
    }
  )

node.set[:logstash][:config][:outputs][:elasticsearch][:variables][:host] = elasticsearch_nodes.first['ipaddress']


include_recipe "java"
include_recipe "cybera_logstash"
return unless node[:roles].include?("broker")

if node[:logstash][:broker][:type] == "rabbitmq"
  # RabbitMQ attributes (only needed if using RabbitMQ as the broker)
  default[:rabbitmq][:default_user] = "logstashuser"
  default[:rabbitmq][:default_pass] = "logstashSuP3Rs3creT"
  default[:rabbitmq][:enabled_users] =
    [
      {
        :name => node[:rabbitmq][:default_user],
        :password => node[:rabbitmq][:default_pass],
        :rights => [{:vhost => nil , :conf => ".*", :write => ".*", :read => ".*"}]
      }
    ]
  default[:rabbitmq][:ssl_port]   = node[:logstash][:broker][:port]
  default[:rabbitmq][:ssl]        = node[:ssl][:enabled]
  default[:rabbitmq][:ssl_cacert] = "#{node[:ssl][:path]}/#{node[:ssl][:cacert_name]}"
  default[:rabbitmq][:ssl_cert]   = "#{node[:ssl][:path]}/#{node[:ssl][:cert_name]}"
  default[:rabbitmq][:ssl_key]    = "#{node[:ssl][:path]}/#{node[:ssl][:key_name]}"
  default[:rabbitmq][:ssl_verify] = "verify_none"
end
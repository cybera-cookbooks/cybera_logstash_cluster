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
include_recipe "recipe[java]"
include_recipe "recipe[cybera_logstash]"
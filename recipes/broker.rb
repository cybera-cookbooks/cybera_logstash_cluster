if node[:logstash][:broker]
  include_recipe "lmc_sensu"
  include_recipe "rabbitmq"
  rabbitmq_user node[:rabbitmq][:default_user] do
    password node[:rabbitmq][:default_pass]
    action :add
  end
  rabbitmq_user node[:rabbitmq][:default_user] do
    permissions ".* .* .*"
    action :set_permissions
  end
  execute "Enable rabbitmq_management" do
    command "rabbitmq-plugins enable rabbitmq_management"
    user 0
    action :run
    not_if "rabbitmq-plugins list -e | grep ' rabbitmq_management '"
    notifies :restart, "service[rabbitmq-server]"
  end

  sensu_gem "carrot-top" do
    action :install
  end
  lmc_sensu_check "logstash_rabbitmq_queue_is_not_too_long" do
    command     "check-rabbitmq-queue.rb"
    args        "--queue logstash_queue -c 10000000 -w 3000000"
    handlers    ["lmc_alerting"]
    interval    60
  end
end

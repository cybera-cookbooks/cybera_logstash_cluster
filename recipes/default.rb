include_recipe "apt"

class Chef::Recipe
  include Logstash::Keychain
end

# drop off certs
if node[:ssl][:enabled] and (node[:roles].include? "kibana" or node[:roles].include? "logstash_broker")
  install_dir = node[:ssl][:path]
  directory install_dir do
    owner "root"
    group "root"
    mode 0755
    action :create
    recursive true
  end
  if Chef::Config[:solo]
    # if we're running in Chef solo then we'll expect a data-bag
    cert = data_bag_item("logstash-ssl", "certs")
    key_content = cert['key']
    cert_content = cert['cert']
    cacert_content = cert['cacert']
  else
    # if we're using a Chef server then we use a keychain
    key_content = keychain_key_by_name("logstash-ssl-key")
    cert_content = keychain_key_by_name("logstash-ssl-cert")
    cacert_content = keychain_key_by_name("logstash-ssl-cacert")
  end

  file "#{install_dir}/#{node[:ssl][:key_name]}" do
    content key_content
    owner "root"
    group "root"
    mode "0666"
    action :create
  end
  file "#{install_dir}/#{node[:ssl][:cert_name]}" do
    content cert_content
    owner "root"
    group "root"
    mode "0666"
    action :create
  end
  file "#{install_dir}/#{node[:ssl][:cacert_name]}" do
    content cacert_content
    owner "root"
    group "root"
    mode "0666"
    action :create
  end
end

include_recipe "cybera_logstash_cluster::logstash_server" if node[:roles].include? "logstash_server"
include_recipe "cybera_logstash_cluster::broker"          if node[:roles].include? "logstash_broker"

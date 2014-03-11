# Java 7 is currently recomended for Elastic Search
default.java[:jdk_version] = '7'

# SSL
default[:ssl][:enabled]     = false
default[:ssl][:path]        = "/etc/ssl/myssl"
default[:ssl][:cert_name]   = "cert.crt"
default[:ssl][:cacert_name] = "cacert.crt"
default[:ssl][:key_name]    = "key.key"

# Logstash globally needed attributes
default[:logstash][:broker][:type] = "rabbitmq"
default[:logstash][:broker][:port] = 5671

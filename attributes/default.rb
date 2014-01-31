# Java 7 is currently recomended for Elastic Search
default.java[:jdk_version] = '7'

# SSL
default[:ssl][:enabled]     = false
default[:ssl][:path]        = "/etc/ssl/myssl"
default[:ssl][:cert_name]   = "mycert.crt"
default[:ssl][:cacert_name] = "mycacert.crt"
default[:ssl][:key_name]    = "mykey.key"
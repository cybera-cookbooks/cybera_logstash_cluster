maintainer       'Cybera'
maintainer_email 'devops@cybera.ca'
license          'All rights reserved'
name             'cybera_logstash_cluster'
description      'Installs/Configures Logstash, Elastic Search, and Kibana for Cybera'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.1.0'

recipe "default",         ""
recipe "elasticsearch",   ""
recipe "kibana",          ""
recipe "logstash_server", ""

depends "apt"
depends "cybera_logstash"
depends "elasticsearch"
depends "java"
depends "kibana"
depends "partial_search"
depends "rabbitmq"
maintainer       'Cybera'
maintainer_email 'devops@cybera.ca'
license          'All rights reserved'
name             'cybera_logstash_cluster'
description      'Installs/Configures Logstash, Elastic Search, and Kibana for Cybera'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.4.0' # 2015/05 Sprint

recipe "default",         ""
recipe "kibana",          ""
recipe "logstash_server", ""

depends "apt"
depends "cybera_logstash"
depends "lmc_sensu"
depends "partial_search"
depends "rabbitmq"
depends "sensu"

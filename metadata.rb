name 'supermarket'
version '2.15.0'
maintainer 'Chef Software, Inc.'
maintainer_email 'cookbooks@getchef.com'
license 'Apache v2.0'
description 'Stands up the Supermarket application stack'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))

%w(yum apt build-essential python nodejs postgresql redisio git nginx runit rubies).each do |dep|
  depends dep
end

supports 'ubuntu'
supports 'centos'

recipe 'supermarket::default',
       'Installs Supermarket and all dependencies for production'

recipe 'supermarket::vagrant',
       'Installs Supermarket and all dependencies for development'

provides 'service[nginx]'
provides 'service[postgres]'
provides 'service[redis-server]'
provides 'service[unicorn]'

grouping 'postgres', :title => 'PostgreSQL options'

attribute 'postgres/user',
          :display_name => 'PostgreSQL username',
          :type         => 'string',
          :default      => 'supermarket'

attribute 'postgres/database',
          :display_name => 'PostgreSQL database name',
          :type         => 'string',
          :default      => 'supermarket_production'

attribute 'postgres/auth_method',
          :display_name => 'PostgreSQL authentication method',
          :type         => 'string',
          :default      => 'peer'

grouping 'redis', :title => 'Redis server options'

attribute 'redis/maxmemory',
          :display_name => 'Maximum memory used by redis server',
          :type         => 'string',
          :default      => '64mb'

grouping 'supermarket', :title => 'Supermarket options'

attribute 'supermarket/home',
          :display_name => 'Directory to deploy Supermarket application',
          :type         => 'string',
          :default      => '/srv/supermarket'

attribute 'supermarket/host',
          :display_name => 'Hostname of Supermarket application',
          :type         => 'string',
          :default      => 'supermarket.getchef.com'

attribute 'supermarket/sidekiq/concurrency',
          :display_name => 'Number of concurrent jobs executed by sidekiq',
          :type         => 'string',
          :default      => '25'

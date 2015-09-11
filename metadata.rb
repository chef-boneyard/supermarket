name 'supermarket'
version '3.3.1'
maintainer 'Chef Software, Inc.'
maintainer_email 'cookbooks@chef.io'
license 'Apache v2.0'
description 'Stands up the Supermarket application stack'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))

%w(yum apt build-essential chef-vault python nodejs postgresql redisio git nginx runit rubies packagecloud).each do |dep|
  depends dep
end

supports 'ubuntu'
supports 'centos'

recipe 'supermarket::default',
       'Installs Supermarket and all dependencies for production'

recipe 'supermarket::vagrant',
       'Installs Supermarket and all dependencies for development'

provides 'service[nginx]'
provides 'service[postgresql]'
provides 'service[redis-server]'
provides 'service[unicorn]'

grouping 'postgres', title: 'PostgreSQL options'

source_url 'https://github.com/chef-cookbooks/supermarket' if respond_to?(:source_url)
issues_url 'https://github.com/chef-cookbooks/supermarket/issues' if respond_to?(:issues_url)

attribute 'postgres/user',
          display_name: 'PostgreSQL username',
          type: 'string',
          default: 'supermarket'

attribute 'postgres/database',
          display_name: 'PostgreSQL database name',
          type: 'string',
          default: 'supermarket_production'

attribute 'postgresql/version',
          display_name: 'PostgreSQL server version',
          type: 'string',
          default: '9.3'

grouping 'redis', title: 'Redis server options'

attribute 'redis/maxmemory',
          display_name: 'Maximum memory used by redis server',
          type: 'string',
          default: '64mb'

grouping 'supermarket', title: 'Supermarket options'

attribute 'supermarket/home',
          display_name: 'Directory to deploy Supermarket application',
          type: 'string',
          default: '/srv/supermarket'

attribute 'supermarket/host',
          display_name: 'Hostname of Supermarket application',
          type: 'string',
          default: 'supermarket.chef.io'

attribute 'supermarket/sidekiq/concurrency',
          display_name: 'Number of concurrent jobs executed by sidekiq',
          type: 'string',
          default: '25'

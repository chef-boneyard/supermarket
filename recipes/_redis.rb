# Redis is required for Sidekiq

#node.default['redis']['config']['logfile'] = '/var/log/redis/redis-server.log'
#
#include_recipe 'redis::server'
#
#if node["platform"] == 'ubuntu' && node["platform_version"].to_f >= 14.04
#  template '/etc/redis/redis.conf' do
#    source 'redis.conf.erb'
#    owner  'root'
#    group  'root'
#    mode   '0644'
#    notifies :restart, 'service[redis]'
#  end
#end
include_recipe 'redisio'
include_recipe 'redisio::enable'

# Redis is required for Sidekiq

node.default['redis']['config']['logfile'] = '/var/log/redis/redis-server.log'

include_recipe 'redis::server'

template '/etc/redis/redis.conf' do
  source 'redis.conf.erb'
  owner  'root'
  group  'root'
  mode   '0644'
  notifies :restart, 'service[redis]'
end

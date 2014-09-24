#
# Author:: Brian Cobb (<brian@gofullstack.com>)
# Author:: Brett Chalupa (<brett@gofullstack.com>)
# Recipe:: redis
#
# Copyright 2014 Chef Software, Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

# Redis is required for Sidekiq

include_recipe 'redis::server'

# package 'redis-server'

# directory '/var/lib/redis' do
#   owner 'redis'
#   group 'redis'
#   mode '0750'
#   recursive true
# end

# template '/etc/redis/redis.conf' do
#   source 'redis.conf.erb'
#   owner  'root'
#   group  'root'
#   mode   '0644'
#   notifies :restart, 'service[redis-server]'
# end

# service 'redis-server' do
#   supports restart: true
#   action [:enable, :start]
# end

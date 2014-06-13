#
# Author:: Seth Vargo (<sethvargo@gmail.com>)
# Recipe:: postgres
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

include_recipe 'postgresql::contrib'

app = data_bag_item(:apps, node['supermarket']['data_bag'])

execute 'postgres[user]' do
  user 'postgres'
  command "echo 'CREATE ROLE #{app['database']['user'] || node['supermarket']['database']['user']} WITH LOGIN;' | psql"
  not_if %Q[echo "SELECT 1 FROM pg_roles WHERE rolname = '#{app['database']['user'] || node['supermarket']['database']['user']}';" | psql | grep -q 1], :user => 'postgres'
end

execute 'postgres[database]' do
  user 'postgres'
  command "echo 'CREATE DATABASE #{app['database']['name'] || node['supermarket']['database']['name']};' | psql"
  not_if %Q[echo "SELECT 1 FROM pg_database WHERE datname = '#{app['database']['name'] || node['supermarket']['database']['name']}';" | psql | grep -q 1], :user => 'postgres'
  notifies :run, 'execute[postgres[privileges]]', :immediately
end

execute 'postgres[privileges]' do
  user 'postgres'
  command "echo 'GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA #{app['database']['name'] || node['supermarket']['database']['name']} TO #{app['database']['user'] || node['supermarket']['database']['user']};' | psql"
  action :nothing
end

service 'postgresql' do
  action [:enable, :start]
end

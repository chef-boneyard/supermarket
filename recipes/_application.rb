#
# Author:: Tristan O'Neil (<tristanoneil@gmail.com>)
# Recipe:: application
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

include_recipe 'supermarket::_apt'
include_recipe 'supermarket::_ruby'

directory "#{node['supermarket']['home']}/shared" do
  user 'supermarket'
  group 'supermarket'
  mode 0755
end

directory "#{node['supermarket']['home']}/shared/bundle" do
  user 'supermarket'
  group 'supermarket'
  mode 0755
  recursive true
end

if node['supermarket']['chef_vault']
  chef_gem 'chef-vault'
  require 'chef-vault'
  app = ChefVault::Item.load(:apps, node['supermarket']['data_bag'])
else
  app = data_bag_item(:apps, node['supermarket']['data_bag'])
end

template "#{node['supermarket']['home']}/shared/.env.production" do
  variables(app: app)

  user 'supermarket'
  group 'supermarket'

  notifies :restart, 'service[unicorn]'
  notifies :restart, 'service[sidekiq]'
end

template "#{node['supermarket']['home']}/shared/unicorn.rb" do
  variables(app: app)
  notifies :restart, 'service[unicorn]'
end

deploy_revision node['supermarket']['home'] do
  repo app['repository']
  revision app['revision']
  user 'supermarket'
  group 'supermarket'
  migrate true
  migration_command 'bundle exec rake db:migrate'
  environment 'RAILS_ENV' => 'production'
  action app['deploy_action'] || 'deploy'

  symlink_before_migrate({
    '.env.production' => '.env',
    'unicorn.rb' => 'config/unicorn/production.rb'
  })

  before_migrate do
    %w(pids log system public).each do |dir|
      directory "#{node['supermarket']['home']}/shared/#{dir}" do
        mode 0755
        recursive true
      end
    end

    template "#{release_path}/config/database.yml" do
      variables(app: app)
    end

    execute 'bundle install' do
      cwd release_path
      command "bundle install --without test development --path=#{node['supermarket']['home']}/shared/bundle"
    end
  end

  before_restart do
    execute 'asset:precompile' do
      environment 'RAILS_ENV' => 'production'
      cwd release_path
      command 'bundle exec rake assets:precompile'
    end
  end

  after_restart do
    execute 'sitemap:refresh:no_ping' do
      user 'supermarket'
      group 'supermarket'
      environment 'RAILS_ENV' => 'production'
      cwd release_path
      command 'bundle exec rake sitemap:refresh:no_ping'
      not_if { ::File.exists?('public/sitemap.xml.gz') }
    end

    execute 'db:seed' do
      user 'supermarket'
      group 'supermarket'
      environment 'RAILS_ENV' => 'production'
      cwd release_path
      command 'bundle exec rake db:seed'
    end
  end

  notifies :restart, 'service[unicorn]'
  notifies :restart, 'service[sidekiq]'
end

template "/etc/logrotate.d/supermarket" do
  source "logrotate-supermarket.erb"
  owner "root"
  group "root"
  mode "0644"
end

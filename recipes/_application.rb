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

directory node['supermarket']['home'] do
  user 'supermarket'
  group 'supermarket'
  mode 0755
end

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

file "#{node['supermarket']['home']}/shared/.env.production" do
  content Supermarket::Config.environment_variables_from(
    app['env'].merge({
      'db_username' => node['postgres']['user'],
      'host' => node['supermarket']['host'],
      'port' => node['supermarket']['port'],
      'protocol' => node['supermarket']['protocol']
    })
  )

  user 'supermarket'
  group 'supermarket'

  notifies :usr2, 'runit_service[unicorn]'
  notifies :restart, 'runit_service[sidekiq]'
end

template "#{node['supermarket']['home']}/shared/unicorn.rb" do
  variables(app: app)
  notifies :usr2, 'runit_service[unicorn]'
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

  symlink_before_migrate(
    '.env.production' => '.env',
    'unicorn.rb' => 'config/unicorn/production.rb'
  )

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
      user 'supermarket'
      group 'supermarket'
      command "bundle install --without test development --path=#{node['supermarket']['home']}/shared/bundle"
    end
  end

  before_restart do
    execute 'asset:precompile' do
      user 'supermarket'
      group 'supermarket'
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
      not_if { ::File.exist?('public/sitemap.xml.gz') }
    end

    execute 'db:seed' do
      user 'supermarket'
      group 'supermarket'
      environment 'RAILS_ENV' => 'production'
      cwd release_path
      command 'bundle exec rake db:seed'
    end

    execute 'chown-release_path-assets' do
      command "chown -R supermarket:supermarket #{release_path}/public/assets"
      user 'root'
      action :run
    end
  end

  notifies :usr2, 'runit_service[unicorn]'
  notifies :restart, 'runit_service[sidekiq]'
end

template '/etc/logrotate.d/supermarket' do
  source 'logrotate-supermarket.erb'
  owner 'root'
  group 'root'
  mode '0644'
end

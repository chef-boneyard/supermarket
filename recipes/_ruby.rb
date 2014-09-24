#
# Author:: Seth Vargo (<sethvargo@gmail.com>)
# Recipe:: ruby
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


# execute "source_etc_profile" do
#   command "source /etc/profile"
#   action :nothing
# end

# file "/etc/profile.d/chef_ruby.sh" do 
#  content <<-EOD
#    export PATH=/opt/chef/embedded/bin/:$PATH
#  EOD
#  notifies :run, "execute[source_etc_profile]"
# end

node.default[:chruby_install][:default_ruby] = true
node.default[:rubies][:list] = [ 'ruby 2.0.0-p576' ]
node.default[:rubies][:bundler][:install] = false

include_recipe 'rubies'

%w{erb gem irb rake rdoc ri ruby testrb bundle bundler }.each do |rb|
  link "/usr/bin/#{rb}" do
    to "/opt/rubies/ruby-2.0.0-p576/bin/#{rb}"
  end
end

node['supermarket']['gem']['dep_packages'].each do |pkg|
  package pkg
end

gem_package 'bundler' do
  gem_binary("/opt/rubies/ruby-2.0.0-p576/bin/gem")
  version '>= 1.7.3'
end

%w{ bundle bundler }.each do |rb|
  link "/usr/bin/#{rb}" do
    to "/opt/rubies/ruby-2.0.0-p576/bin/#{rb}"
  end
end

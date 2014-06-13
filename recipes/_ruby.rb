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

include_recipe 'ruby_install'

ruby_install_ruby "ruby #{node['supermarket']['ruby_version']}"

%w{erb gem irb rake rdoc ri ruby testrb}.each do |rb|
  link "/usr/bin/#{rb}" do
    to "#{node['ruby_install']['default_ruby_base_path']}/ruby-#{node['supermarket']['ruby_version']}/bin/#{rb}"
  end
end

gem_package 'bundler'

link "/usr/bin/bundle" do
  to "#{node['ruby_install']['default_ruby_base_path']}/ruby-#{node['supermarket']['ruby_version']}/bin/bundle"
end

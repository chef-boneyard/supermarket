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

node.default[:rubies][:list] = [ 'ruby 2.0.0-p576' ]
node.default[:rubies][:install_bundler] = true

include_recipe 'rubies'


%w{ libxml2 libxml2-devel libxslt libxslt-devel sqlite-devel postgresql-libs }.each do |pkg|
  package pkg
end


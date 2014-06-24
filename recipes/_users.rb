#
# Author:: Tristan O'Neil (<tristanoneil@gmail.com>)
# Recipe:: users
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

group 'supermarket' do
  system true
end

user 'supermarket' do
  gid 'supermarket'
  system true
  home node['supermarket']['home']
  comment 'Supermarket'
  shell '/bin/false'
end

directory node['supermarket']['home'] do
  owner "supermarket"
  group "supermarket"
  mode 0755
  recursive true
end

file ::File.join(node['supermarket']['home'], '.gemrc') do
  content 'gem: --no-ri --no-rdoc'
end

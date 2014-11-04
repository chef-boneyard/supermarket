#
# Author:: Tristan O'Neil (<tristanoneil@gmail.com>)
# Attributes:: supermarket
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

default['postgres']['user'] = 'supermarket'
default['postgres']['database'] = 'supermarket_production'
default['postgres']['auth_method'] = 'peer'
default['postgres']['version'] = '9.1'

default['redis']['maxmemory'] = '64mb'

default['supermarket']['home'] = '/srv/supermarket'
default['supermarket']['host'] = 'supermarket.getchef.com'
default['supermarket']['protocol'] = 'https'
default['supermarket']['sidekiq']['concurrency'] = '25'
default['supermarket']['database']['pool'] = 25
default['supermarket']['chef_vault'] = false
default['supermarket']['data_bag'] = 'supermarket'

# used primarily by CHEF operations to handle legacy tools and
# configuration pointing at the HTTP (non-SSL) only
# `cookbooks.opscode.com` and `api.berkshelf.com`, this must be set as
# an Array of domains that shouldn't be redirected to HTTPS by nginx.
default['supermarket']['allow_http_domains'] = nil

# make a knob for the number of workers for unicorn. This is named
# web_concurrency for parity with the ENV variable in the app's
# unicorn config:
# https://github.com/opscode/supermarket/blob/master/config/unicorn/production.rb
default['supermarket']['web_concurrency'] = node['cpu']['total'].to_i * 2

# To use AWS ELB in front of Supermarket, set force_ssl to true, but
# don't set the ssl_crt_path or ssl_key_path. To use SSL directly on
# the nginx proxy in front of the app, set force_ssl to true and set
# the path attributes below.
default['supermarket']['force_ssl']  = false

# To use custom SSL certificate/key, name the files, and in a separate
# cookbook, manage them with your favorite method (chef-vault items,
# regular data bags, etc).
default['supermarket']['ssl_crt_path'] = nil
default['supermarket']['ssl_key_path'] = nil

case node['platform']
when 'redhat', 'centos', 'scientific', 'fedora', 'amazon', 'oracle'
  default['supermarket']['gem']['dep_packages'] = %w(libxml2 libxml2-devel libxslt libxslt-devel sqlite-devel postgresql-libs)
else
  default['supermarket']['gem']['dep_packages'] = %w(libxslt-dev libxml2-dev libsqlite3-dev libpq-dev)
end

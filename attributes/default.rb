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

default['supermarket']['data_bag']     = 'supermarket'
default['supermarket']['ruby_version'] = '2.0.0-p481'

default['supermarket']['cla_signature_notification_email'] = 'notifications@example.com'
default['supermarket']['from_email']                       = 'donotreply@example.com'
default['supermarket']['home']                             = '/srv/supermarket'
default['supermarket']['host']                             = 'supermarket.getchef.com'
default['supermarket']['port']                             = 80
default['supermarket']['sidekiq']['concurrency']           = 25

default['supermarket']['database']['user']        = 'supermarket'
default['supermarket']['database']['name']        = 'supermarket_production'
default['supermarket']['database']['auth_method'] = 'peer'
default['supermarket']['database']['pool']        = 25

# Override attributes of cookbooks we rely on
# nginx
default['nginx']['install_method']       = 'source'
default['nginx']['default_site_enabled'] = false

# postgresql
#
# The needed version (9.3) needs to go in a Chef role or environment:
# "postgresql": {
#   "version": "9.3"
# }
#
default['postgresql']['enable_pgdg_apt']       = platform_family?('debian')
default['postgresql']['enable_pgdg_yum']       = platform_family?('rhel')
default['postgresql']['contrib']['extensions'] = ['plpgsql', 'pg_trgm']

# redisio
default['redisio']['default_settings']['maxmemory'] = '64mb'

# runit
if platform_family?('rhel')
  default['runit']['start']  = 'start runsvdir'
  default['runit']['stop']   = 'stop runsvdir'
  default['runit']['reload'] = 'restart runsvdir'
end

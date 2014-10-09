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

include_recipe 'supermarket::_apt'

package 'ruby2.1'
package 'ruby2.1-dev'

%w{erb gem irb rake rdoc ri ruby testrb}.each do |rb|
  link "/usr/bin/#{rb}" do
    to "/usr/bin/#{rb}2.1"
  end
end

# the bundle contains gems that need to compile C extensions
package 'build-essential'

# Nokogiri requires XML
package 'libxslt-dev'
package 'libxml2-dev'

# SQLite3 requires development headers
package 'libsqlite3-dev'

# `pg` requires development headers; this allows the application to deploy (bundle)
# when postgresql isn't running on the same node.
package 'libpq-dev'

gem_package 'bundler' do
  version '>= 1.7.2'
end

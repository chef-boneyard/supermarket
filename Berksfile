source 'http://supermarket.getchef.com'

metadata

cookbook 'redis', git: 'https://github.com/meanbee/chef-redis.git'
cookbook 'bluepill', git: 'https://github.com/opscode-cookbooks/bluepill.git'
cookbook 'rsyslog', git: 'https://github.com/opscode-cookbooks/rsyslog.git'
cookbook 'ohai', git: 'https://github.com/opscode-cookbooks/ohai.git'
cookbook 'nginx', git: 'https://github.com/miketheman/nginx.git'
cookbook 'ruby_install', git: 'https://github.com/rosstimson/chef-ruby_install.git'
cookbook 'chruby_install', git: 'https://github.com/ichilton/chef_chruby_install.git'
cookbook 'rubies', git: 'https://github.com/stephenlauck/chef_rubies.git', ref: 'add_version_attr_for_bundler'

group :integration do
  cookbook 'emacs'
end
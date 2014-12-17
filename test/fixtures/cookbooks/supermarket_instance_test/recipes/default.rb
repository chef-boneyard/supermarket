opts = { 'fqdn' => 'localhost' }
supermarket_instance 'default' do
  action :create
  chef_server_url 'https://an_server'
  chef_oauth2_app_id 'an_id'
  chef_oauth2_secret 'an_secret'
  options opts
end

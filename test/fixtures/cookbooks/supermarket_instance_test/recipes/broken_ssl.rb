supermarket_instance 'default' do
  action :create
  ssl_key dummy_ssl_key
  chef_server_url 'https://an_server'
  chef_oauth2_app_id 'an_id'
  chef_oauth2_secret 'an_secret'
end

opts = { 'chef_server_url' => 'http://another_url' }

supermarket_instance 'default' do
  action :create
  chef_server_url 'http://an_url'
  options opts
end

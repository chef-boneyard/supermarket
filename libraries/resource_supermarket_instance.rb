require 'chef/resource/lwrp_base'

class Chef
  class Resource
    class SupermarketInstance < Chef::Resource::LWRPBase
      self.resource_name = :supermarket_instance
      actions :create, :reconfigure, :restart
      default_action :create

      attribute :chef_server_url, :kind_of => String, :default => nil
      attribute :chef_oauth2_app_id, :kind_of => String, :default => nil
      attribute :chef_oauth2_secret, :kind_of => String, :default => nil
      attribute :ssl_cert, :kind_of => String, :default => nil
      attribute :ssl_key, :kind_of => String, :default => nil
      attribute :options, :default => {}
    end
  end
end

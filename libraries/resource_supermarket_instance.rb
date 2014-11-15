require 'chef/resource/lwrp_base'

class Chef
  class Resource
    class SupermarketInstance < Chef::Resource::LWRPBase
      self.resource_name = :supermarket_instance
      actions :create, :delete
      default_action :create
    end
  end
end

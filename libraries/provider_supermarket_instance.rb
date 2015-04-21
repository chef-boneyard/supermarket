class Chef
  class Provider
    class SupermarketInstance < Chef::Provider::LWRPBase
      use_inline_resources if defined?(use_inline_resources)

      def whyrun_supported?
        true
      end

      action :create do

        config = {}
        config['chef_server_url'] = new_resource.chef_server_url
        config['chef_oauth2_app_id'] = new_resource.chef_oauth2_app_id
        config['chef_oauth2_secret'] = new_resource.chef_oauth2_secret

        if new_resource.ssl_cert || new_resource.ssl_key
          unless new_resource.ssl_cert && new_resource.ssl_key
            raise 'You must specify ssl_cert and ssl_key or none at all.'
          end
          config['ssl'] = {}
          config['ssl']['certificate'] = '/etc/supermarket/ssl/ssl.crt'
          config['ssl']['certificate_key'] = '/etc/supermarket/ssl/ssl.key'
        end

        config.keys.each do |attrs|
          new_resource.options.keys.each do |opts|
            if opts == attrs
              raise "You cannot set #{opts} when it is already set as an attribute"
            end
          end
        end

        config.merge!(new_resource.options)

        ['chef_server_url', 'chef_oauth2_app_id', 'chef_oauth2_secret'].each do |required|
          unless config[required]
            raise "#{required} is a required attribute"
          end
        end

        case node['platform_family']
        when 'debian'
          packagecloud_repo 'chef/stable' do
            type 'deb'
          end
        when 'rhel'
          packagecloud_repo 'chef/stable' do
            type 'rpm'
          end
        else
          raise "I don't know how to install supermarket for platform family: #{node['platform_family']}"
        end

        package 'supermarket'

        directory '/etc/supermarket'

        # Handle SSL
        if new_resource.ssl_cert
          directory '/etc/supermarket/ssl'

          file '/etc/supermarket/ssl/ssl.key' do
            owner 'root'
            group 'root'
            mode '0600'
            content new_resource.ssl_key
          end

          file '/etc/supermarket/ssl/ssl.crt' do
            owner 'root'
            group 'root'
            mode '0600'
            content new_resource.ssl_cert
          end

        end

        file '/etc/supermarket/supermarket.json' do
          content config.to_json
          notifies :run, 'execute[reconfigure supermarket]'
        end

        execute 'reconfigure supermarket' do
          command '/opt/supermarket/bin/supermarket-ctl reconfigure'
          action :nothing
        end

      end
    end
  end
end

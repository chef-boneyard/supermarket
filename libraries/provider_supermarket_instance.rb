class Chef
  class Provider
    class SupermarketInstance < Chef::Provider::LWRPBase
      use_inline_resources if defined?(use_inline_resources)

      def whyrun_supported?
        false
      end

      action :create do
        case node['platform_family']
        when 'debian'

          package "apt-transport-https"

          apt_repository 'chef-stable' do
            uri "https://packagecloud.io/chef/stable/ubuntu/"
            key 'https://packagecloud.io/gpg.key'
            distribution node['lsb']['codename']
            deb_src true
            trusted true
            components %w( main )
          end

          # Performs an apt-get update
          run_context.include_recipe 'apt::default'

        when 'rhel'

          major_version = node['platform_version'].split('.').first

          yum_repository 'chef-stable' do
            description 'Chef Stable Repo'
            baseurl "https://packagecloud.io/chef/stable/el/#{major_version}/$basearch"
            gpgkey 'https://downloads.getchef.com/chef.gpg.key'
            sslverify true
            sslcacert '/etc/pki/tls/certs/ca-bundle.crt'
            gpgcheck true
            action :create
          end

        else
          # TODO: probably don't actually want to fail out?  Say, on any platform where
          # this would have to be done manually.
          raise "I don't know how to install supermarket for platform family: #{node['platform_family']}"
        end

        package 'supermarket'
      end

      action :delete do
      end

    end
  end
end

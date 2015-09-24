require 'spec_helper'

describe 'supermarket_instance_test::working_ssl' do
  let(:chef_run) do
    ChefSpec::SoloRunner.new(
      step_into: 'supermarket_instance',
      platform: 'ubuntu',
      version: '14.04',
      log_level: :error
    ) do |_node|
    end.converge(described_recipe)
  end

  context 'inside of supermarket_instance' do
    it 'creates an ssl directory' do
      expect(chef_run).to create_directory('/etc/supermarket/ssl')
    end

    it 'installs the ssl key' do
      expect(chef_run).to render_file('/etc/supermarket/ssl/ssl.key') \
        .with_content('-----BEGIN RSA PRIVATE KEY-----')
    end

    it 'installs the ssl cert' do
      expect(chef_run).to render_file('/etc/supermarket/ssl/ssl.crt') \
        .with_content('-----BEGIN CERTIFICATE-----')
    end
  end
end

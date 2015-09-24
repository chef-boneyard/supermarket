require 'spec_helper'

describe 'supermarket_instance_test::default' do
  let(:chef_run) do
    ChefSpec::SoloRunner.new(
      step_into: 'supermarket_instance',
      platform: 'ubuntu',
      version: '14.04',
      log_level: :error
    ) do |_node|
    end.converge(described_recipe)
  end

  it 'creates default supermarket_instance' do
    expect(chef_run).to create_supermarket_instance('default')
  end

  context 'inside of the supermarket_instance' do
    it 'installs supermarket package' do
      expect(chef_run).to install_package('supermarket')
    end

    it 'creates /etc/supermarket' do
      expect(chef_run).to create_directory('/etc/supermarket')
    end

    it 'creates /etc/supermarket/supermarket.json' do
      expect(chef_run).to render_file('/etc/supermarket/supermarket.json')
    end

    it 'executes supermarket-ctl reconfigure' do
      expect(chef_run).to_not run_execute('reconfigure supermarket')
    end

    it 'notifies supermarket to reconfigure' do
      resource = chef_run.file('/etc/supermarket/supermarket.json')
      expect(resource).to notify('execute[reconfigure supermarket]').to(:run)
    end

    context 'on ubuntu 14.04' do
      it 'sets up an apt repo' do
        expect(chef_run).to create_packagecloud_repo('chef/stable') \
          .with_type('deb')
      end
    end

    context 'on CentOS 6.5' do
      let(:chef_run) do
        ChefSpec::SoloRunner.new(
          step_into: 'supermarket_instance',
          platform: 'centos',
          version: '6.5',
          log_level: :error
        ) do |_node|
        end.converge(described_recipe)
      end

      it 'sets up a yum repo' do
        expect(chef_run).to create_packagecloud_repo('chef/stable') \
          .with_type('rpm')
      end
    end
  end
end

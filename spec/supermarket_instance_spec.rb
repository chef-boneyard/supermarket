require 'spec_helper'

describe 'supermarket_instance_test::default' do

  let(:chef_run) do
    ChefSpec::SoloRunner.new(
      :step_into => 'supermarket_instance',
      :platform => 'ubuntu',
      :version => '14.04',
      :log_level => :info
    ) do |node|
    end.converge(described_recipe)
  end

  context 'when using default parameters' do

    it 'Installs apt-transport-https' do
      expect(chef_run).to install_package('apt-transport-https')
    end

  end
end

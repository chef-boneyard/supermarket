require 'spec_helper'

describe 'supermarket_instance_test::duplicate_attrs' do
  let(:chef_run) do
    ChefSpec::SoloRunner.new(
      step_into: 'supermarket_instance',
      platform: 'ubuntu',
      version: '14.04',
      log_level: :warn
    ) do |_node|
    end.converge(described_recipe)
  end

  it 'raises an error' do
    expect { chef_run }.to raise_error(RuntimeError)
  end
end

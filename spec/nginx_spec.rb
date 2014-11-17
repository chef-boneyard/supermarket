require_relative 'spec_helper'

describe 'supermarket::_nginx' do
  before do
    stub_command('test -f /etc/apt/sources.list.d/brightbox-ruby-ng-experimental-precise.list -o -f /etc/apt/sources.list.d/brightbox-ruby-ng-experimental-trusty.list').and_return(false)
    stub_command('which nginx').and_return(false)
  end

  let(:chef_run) do
    configure_chef
    ChefSpec::SoloRunner.new do |node|
      node.automatic['cpu']['total'] = 1
    end.converge(described_recipe)
  end

  it 'reloads the service when the default sites-available conf changes' do
    resource = chef_run.template('/etc/nginx/sites-available/default')

    expect(resource).to notify('service[nginx]').to(:reload)
  end
end

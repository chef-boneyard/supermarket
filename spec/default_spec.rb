require 'tempfile'

require_relative 'spec_helper'

describe 'supermarket::default' do
  before do
    configure_chef
    upload_databag('apps', 'supermarket')

    stub_command('test -f /etc/apt/sources.list.d/chris-lea-node_js-precise.list').and_return(false)
    stub_command("echo 'SELECT 1 FROM pg_roles WHERE rolname = 'supermarket';' | psql | grep -q 1").and_return(false)
    stub_command("echo 'SELECT 1 FROM pg_database WHERE datname = 'supermarket_production';' | psql | grep -q 1").and_return(false)
    stub_command('test -f /etc/apt/sources.list.d/chris-lea-redis-server-precise.list').and_return(false)
    stub_command('test -f /etc/apt/sources.list.d/brightbox-ruby-ng-experimental-precise.list').and_return(false)
    stub_command('ruby -v | grep 2.0.0').and_return(false)
    stub_command("echo 'dx' | psql supermarket_production | grep plpgsql").and_return(false)
    stub_command("echo 'dx' | psql supermarket_production | grep pg_trgm").and_return(false)
  end

  let(:chef_run) do
    ChefSpec::Runner.new.converge(described_recipe)
  end

  it 'compiles' do
    expect(chef_run).not_to be_nil
  end

  context 'should be able to use an alternate databag' do

    let(:chef_run) do
      ChefSpec::Runner.new do |node|
        node.set['supermarket']['data_bag'] = 'supermarket_prod'
      end.converge(described_recipe)
    end

    before do
      upload_databag('apps', 'supermarket_prod')
    end

    it 'compiles' do
      expect(chef_run).not_to be_nil
    end

  end

  context 'the .env.production template' do

    it 'notifies unicorn to restart' do
      resource = chef_run.template('/srv/supermarket/shared/.env.production')

      expect(resource).to notify('service[unicorn]').to(:restart)
    end

    it 'notifies sidekiq to restart' do
      resource = chef_run.template('/srv/supermarket/shared/.env.production')

      expect(resource).to notify('service[sidekiq]').to(:restart)
    end

    it 'contains SEGMENT_IO_WRITE_KEY when such an entry is in the data bag' do
      ChefSpec::Server.create_data_bag('apps', {
        'supermarket' => {
          'segment_io_write_key' => 'hello'
        }
      })

      expect(chef_run)
        .to render_file('/srv/supermarket/shared/.env.production')
        .with_content('SEGMENT_IO_WRITE_KEY=hello')
    end

  end

end

require 'chefspec'
require 'chefspec/berkshelf'

require 'json'

at_exit { ChefSpec::Coverage.report! }

RSpec.configure do |c|
  c.filter_run :focus => true
  c.run_all_when_everything_filtered = true
end

def configure_chef
  RSpec.configure do |config|
    config.platform = 'ubuntu'
    config.version = '14.04'
    config.log_level = :error
  end
end

def get_databag_item(name, item)
  filename = File.join('.', 'data_bags', name, "#{item}.json")
  { item => JSON.parse(IO.read(filename)) }
end

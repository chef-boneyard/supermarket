# rubocop:disable Style/PerlBackrefs
require_relative 'spec_helper'

describe 'supermarket' do
  it 'should have unicorn listening' do
    expect(port(13000)).to be_listening
  end

  it 'serve Chef Supermarket index web page' do
    cmd = command 'curl -k -L https://localhost 2> /dev/null'
    expect(cmd.stdout).to match '<!DOCTYPE html>'
  end

  it 'writes feature flags to .env.production from the apps databag' do
    cmd = command 'cat /var/opt/supermarket/etc/env'
    expect(cmd.stdout).to match 'FEATURES="tools"'
  end

  it 'has > 0 ICLAs' do
    cmd = command %q{echo 'SELECT count("iclas".*) FROM "iclas";' | /opt/supermarket/embedded/bin/psql -U supermarket -h 127.0.0.1 -p 15432 supermarket | grep '^(. row.*)'}
    cmd.stdout.match(/\((\d).*/)
    res = $1.to_i
    expect(res).to be > 0
  end

  it 'has > 0 CCLAs' do
    cmd = command %q{echo 'SELECT count("cclas".*) FROM "cclas";' | /opt/supermarket/embedded/bin/psql -U supermarket -h 127.0.0.1 -p 15432 supermarket | grep '^(. row.*)'}
    cmd.stdout.match(/\((\d).*/)
    res = $1.to_i
    expect(res).to be > 0
  end

end

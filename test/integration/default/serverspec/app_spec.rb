# Disable rubocop in this file, because we do some perfectly
# reasonable things that it doesn't like.
#
# rubocop:disable all
require_relative 'spec_helper'

describe 'supermarket' do
  it 'create a unicorn socket' do
    expect(file '/tmp/.supermarket.sock.0').to be_socket
  end

  it 'serve Chef Supermarket index web page' do
    cmd = command 'wget -O - http://localhost 2> /dev/null'
    expect(cmd.stdout).to match '<!DOCTYPE html>'
  end

  it 'still serves Chef Supermarket when Unicorn is restarted' do
    restart = command 'sv 2 unicorn'
    cmd = command 'wget -O - http://localhost 2> /dev/null'
    expect(cmd.stdout).to match '<!DOCTYPE html>'
  end

  it 'has > 0 ICLAs' do
    cmd = command %Q{echo 'SELECT count("iclas".*) FROM "iclas";' | sudo -u postgres psql supermarket_production | grep '^(. row.*)'}
    cmd.stdout.match(/\((\d).*/)
    res = $1.to_i
    expect(res).to be > 0
  end

  it 'has > 0 CCLAs' do
    cmd = command %Q{echo 'SELECT count("cclas".*) FROM "cclas";' | sudo -u postgres psql supermarket_production | grep '^(. row.*)'}
    cmd.stdout.match(/\((\d).*/)
    res = $1.to_i
    expect(res).to be > 0
  end

  describe file('/srv/supermarket/current/.env') do
    let(:cmd) { command 'cat /srv/supermarket/shared/.env.production' }

    it { should be_linked_to '/srv/supermarket/shared/.env.production' }

    it 'should contain an ENV var for every entry in the env data bag hash' do
      actual_keys = cmd.stdout.strip.split("\n").sort.map { |x| x.split('=').first }
      expected_keys = %w(
        CDN_URL
        CHEF_BLOG_URL
        CHEF_DOCS_URL
        CHEF_DOMAIN
        CHEF_DOWNLOADS_URL
        CHEF_IDENTITY_URL
        CHEF_MANAGE_URL
        CHEF_OAUTH2_APP_ID
        CHEF_OAUTH2_SECRET
        CHEF_OAUTH2_URL
        CHEF_OAUTH2_VERIFY_SSL
        CHEF_PROFILE_URL
        CHEF_SERVER_URL
        CHEF_SIGN_UP_URL
        CHEF_WWW_URL
        CLA_REPORT_EMAIL
        CLA_SIGNATURE_NOTIFICATION_EMAIL
        CURRY_CLA_LOCATION
        CURRY_SUCCESS_LABEL
        DB_USERNAME
        DEVISE_SECRET_KEY
        FEATURES
        FIERI_KEY
        FIERI_URL
        FROM_EMAIL
        GITHUB_ACCESS_TOKEN
        GITHUB_KEY
        GITHUB_SECRET
        GOOGLE_ANALYTICS_ID
        HOST
        LEARN_CHEF_URL
        NEW_RELIC_APP_NAME
        NEW_RELIC_LICENSE_KEY
        PROTOCOL
        PUBSUBHUBBUB_SECRET
        REDIS_URL
        S3_ACCESS_KEY_ID
        S3_BUCKET
        S3_SECRET_ACCESS_KEY
        SECRET_KEY_BASE
        SENTRY_URL
        SMTP_ADDRESS
        SMTP_PASSWORD
        SMTP_PORT
        SMTP_USER_NAME
        STATSD_PORT
        STATSD_URL
      )

      expect(actual_keys).to eql(expected_keys)
    end

    it 'writes feature flags to .env.production from the apps databag' do
      expect(cmd.stdout).to match 'FEATURES=tools,join_ccla'
    end
  end

  describe file('/srv/supermarket/current/config/unicorn/production.rb') do
    it { should be_linked_to '/srv/supermarket/shared/unicorn.rb' }
  end
end

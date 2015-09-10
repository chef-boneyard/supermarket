require_relative 'spec_helper'

describe 'nodejs', if: os[:family] == 'ubuntu' do
  it '0.10 branch is installed' do
    cmd = command 'nodejs -v'
    expect(cmd.stdout).to match 'v0.10.'
  end
end

describe 'node', if: os[:family] == 'redhat' do
  it '0.10 branch is installed' do
    cmd = command 'node -v'
    expect(cmd.stdout).to match 'v0.10.'
  end
end

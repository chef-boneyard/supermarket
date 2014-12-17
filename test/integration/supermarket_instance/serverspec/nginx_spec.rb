require_relative 'spec_helper'

describe 'nginx' do
  it 'is running' do
    expect(process 'nginx').to be_running
  end

  it 'listens on port 80' do
    expect(port 80).to be_listening
  end

  it 'listens on port 443' do
    expect(port 443).to be_listening
  end

end

require_relative 'spec_helper'

describe 'supermarket' do

  it 'serve Chef Supermarket index web page' do
    cmd = command 'wget -O - http://localhost 2> /dev/null'
    expect(cmd.stdout).to match '<!DOCTYPE html>'
  end

end

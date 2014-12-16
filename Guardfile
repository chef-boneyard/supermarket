guard :rspec, cmd: 'rspec 2>/dev/null' do
  watch(%r{^spec/.+_spec\.rb$})
  watch(%r{^libraries/(.+)\.rb$})
  watch('spec/spec_helper.rb')  { "spec" }
end

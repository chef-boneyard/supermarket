source 'https://supermarket.getchef.com'

metadata

# Depend on version of packagecloud cookbook with matchers
cookbook 'packagecloud', git: 'https://github.com/computology/packagecloud-cookbook.git'

# Depend on the postgresql cookbook version without derived attributes
cookbook 'postgresql', git: 'https://github.com/hw-cookbooks/postgresql', tag: 'v3.4.16'

group :integration do
  cookbook 'supermarket_instance_test', path: 'test/fixtures/cookbooks/supermarket_instance_test'
end

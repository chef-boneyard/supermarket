source 'https://supermarket.getchef.com'

metadata

# Depend on version of packagecloud cookbook with matchers
cookbook 'packagecloud', git: 'https://github.com/computology/packagecloud-cookbook.git'

group :integration do
  cookbook 'supermarket_instance_test', path: 'test/fixtures/cookbooks/supermarket_instance_test'
end

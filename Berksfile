source 'https://supermarket.getchef.com'

metadata

# Depend on version of packagecloud cookbook with matchers
cookbook 'packagecloud', github: 'computology/packagecloud-cookbook'

group :integration do
  cookbook 'supermarket_instance_test', path: 'test/fixtures/cookbooks/supermarket_instance_test'
end

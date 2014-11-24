if defined?(ChefSpec)

  def create_supermarket_instance(resource_name)
    ChefSpec::Matchers::ResourceMatcher.new(:supermarket_instance, :create, resource_name)
  end

end

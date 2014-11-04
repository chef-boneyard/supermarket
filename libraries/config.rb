module Supermarket
  module Config
    #
    # Take a hash of data from a data bag/vault and create a list of variables
    # from it.
    #
    # Given this:
    # {
    #   "key": "value",
    #   "wut": 4
    # }
    #
    # The output will be:
    #
    # KEY=value
    # WUT=4
    #
    def self.environment_variables_from(data)
      data.reduce([]) do |result, (k,v)|
        if v.is_a?(String) || v.is_a?(Numeric) || v == true || v == false
          result << "#{k.upcase}=#{v}"
        end

        result
      end.join("\n")
    end
  end
end

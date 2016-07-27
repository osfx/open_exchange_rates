require "json"

module OpenExchangeRates
  # Mapping for OpenExchangeRates object
  module Mapping
    # :nodoc:
    class Latest
      JSON.mapping(
        disclaimer: String,
        license: String,
        timestamp: Int32,
        base: String,
        rates: Hash(String, Float64)
      )
    end
  end
end

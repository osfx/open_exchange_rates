require "json"

module OpenExchangeRates
  # :nodoc:
  module Mapping
    # :nodoc:
    class Convert
      # :nodoc:
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

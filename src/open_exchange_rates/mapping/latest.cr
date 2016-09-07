require "json"
require "json/mapping"

module OpenExchangeRates
  module Mapping
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

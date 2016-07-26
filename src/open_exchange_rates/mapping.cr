require "json"

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


    class Historical
      JSON.mapping(
        rates: Hash(String, Float64)
      )
    end

  end
end

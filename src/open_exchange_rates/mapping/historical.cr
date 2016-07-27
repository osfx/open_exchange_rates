require "json"

module OpenExchangeRates
  module Mapping

    class Historical
      JSON.mapping(
        rates: Hash(String, Float64)
      )
    end

  end
end

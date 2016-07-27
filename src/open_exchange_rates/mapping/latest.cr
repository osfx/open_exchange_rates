require "json"

module OpenExchangeRates
  # Mapping for OpenExchangeRates object
  module Mapping
    # OpenExchangeRates::Mapping::Latest object
    # ```
    #
    # { disclaimer: String,
    #   license:    String,
    #   timestamp:  Int32,
    #   base:       String,
    #   rates:      Hash(String, Float64)
    # }
    #```
    # ```
    # oxr = OpenExchangeRates::API.new(API_KEY)
    # latest = oxr.lates     #=> Return mapped object
    # puts latest.disclaimer #=> Exchange rates provided for...
    # puts latest.license    #=> Data sourced from various provider...
    # puts latest.timestamp  #=> 1451667600
    # puts latest.base       #=> "USD"
    # puts latast.rates      #=> {"AED" => 3.672754, "AFN" => 68.45,....}
    # ```
    class Latest
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

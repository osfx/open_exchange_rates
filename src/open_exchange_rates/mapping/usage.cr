require "json"

module OpenExchangeRates
  # :nodoc:
  module Mapping
    # OpenExchangeRates::Mapping::DataUsage object
    # ```
    #
    # {
    #  requests:           Int32,
    #  requests_quota:     Int32,
    #  requests_remaining: Int32,
    #  days_elapsed:       Int32,
    #  days_remaining:     Int32,
    #  daily_average:      Int32,
    # }
    #```
    # :nodoc:
    class DataUsage
      # :nodoc:
      JSON.mapping(
        requests:           Int32,
        requests_quota:     Int32,
        requests_remaining: Int32,
        days_elapsed:       Int32,
        days_remaining:     Int32,
        daily_average:      Int32,
      )
    end
    # OpenExchangeRates::Mapping::Plan object
    #
    # ```
    # {
    #   name:             String,
    #   quota:            String,
    #   update_frequency: String,
    #   features:         Hash(String, Bool),
    # }
    # ```
    # :nodoc:
    class Plan
      # :nodoc:
      JSON.mapping(
        name:             String,
        quota:            String,
        update_frequency: String,
        features:         Hash(String, Bool),
      )
    end
    # OpenExchangeRates::Mapping::DataHash object
    # Return object ( see  `Mapping::Plan` & `Mapping::DataUsage`)
    # ```
    # { app_id: String,
    #   status: String,
    #   plan:   {type: Plan},
    #   usage:  {type: DataUsage},
    # }
    # ```
    # :nodoc:
    class DataHash
      # :nodoc:
      JSON.mapping(
        app_id: String,
        status: String,
        plan:   {type: Plan},
        usage:  {type: DataUsage},
      )
    end
    # OpenExchangeRates::Mapping::Usage object
    # Return status and `Mapping::DataHash` object
    # ```
    #
    # { status:  Int32,
    #   data:    DataHash,
    # }
    #```
    # :nodoc:
    class Usage
      # :nodoc:
      JSON.mapping(
        status: Int32,
        data:   {type: DataHash},
      )
    end
  end
end

require "json"

module OpenExchangeRates
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
    class DataUsage
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
    class Plan
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
    class DataHash
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
    class Usage
      JSON.mapping(
        status: Int32,
        data:   {type: DataHash},
      )
    end
  end
end

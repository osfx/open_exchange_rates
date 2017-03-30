require "json"

module OpenExchangeRates
  module Mapping

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

    class Plan
      JSON.mapping(
        name:             String,
        quota:            String,
        update_frequency: String,
        features:         Hash(String, Bool),
      )
    end

    class DataHash
      JSON.mapping(
        app_id: String,
        status: String,
        plan:   {type: Plan},
        usage:  {type: DataUsage},
      )
    end

    class Usage
      JSON.mapping(
        status: String,
        data:   {type: DataHash},
      )
    end
  end
end

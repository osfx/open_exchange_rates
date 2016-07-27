module OpenExchangeRates
  # API class is a **OpenExchangeRates**(see the `OpenExchangeRates` module) that has been
  # described since antiquity as a beast with a large, spiraling horn projecting
  # from its forehead.
  class API
    # :nodoc:
    getter key
    # :nodoc:
    getter uri
    # :nodoc:
    getter client
    #
    def initialize(key : String)
      @key = key
      @uri = URI.parse("https://openexchangerates.org")
      @client = HTTP::Client.new(@uri)
    end

    # Return mapped object (see `Mapping::Latest` module)
    #
    # **Examples:**
    #
    # ```
    # oxr = OpenExchangeRates::API.new("your_awesome_app_id")
    # puts oxr.latest       #=> return mapped object
    # puts oxr.latest.rates #=> {"AED" => 3.672852, "AFN" => 67.842051, "ALL" => 121.8915, "AMD" => 476.242503...
    # puts oxr.latest["EUR"]#=> 0.8942
    # ```
    def latest
      response = client.get("/api/latest.json?&app_id=#{@key}")
      OpenExchangeRates::Mapping::Latest.from_json(response.body)
    end

    # Get historical exchange rates for any date available from the Open Exchange Rates API.
    # Return mapped object ( see `Mapping::Historical` module)
    #
    # **Examples:**
    #
    # ```
    # oxr = OpenExchangeRates::API.new("your_awesome_app_id")
    # puts oxr.historical("2016-01-01") #=> {"AED" => 3.672754, "AFN" => 68.45, "ALL" => 125.9742, "AMD" => 483.75, "ANG" => 1.78875, "AOA" => 135.256669, "ARS" => 12.96635, "AUD" => 1.37393, "AWG" => 1.790083, "AZN" => 1.562017, "BAM" => 1.797331...}
    # ```
    def historical(data : String)
      response = client.get("/api/historical/#{data}.json?app_id=#{@key}")
      result = JSON.parse(response.body)["rates"]
    end

    # Get a JSON list of all currency symbols available from the Open Exchange Rates API
    #
    # **Examples:**
    #
    # ```
    # oxr = OpenExchangeRates::API.new("your_awesome_app_id")
    # puts oxr.currencies #=> "{"AED" => "United Arab Emirates Dirham", "AFN" => "Afghan Afghani", "ALL" => "Albanian Lek", "AMD" => "Armenian Dram", "ANG" => "Netherlands Antillean Guilder", "AOA" => "Angolan Kwanza", "ARS" => "Argentine Peso"...}
    # ```
    def currencies(prettyprint = 0, show_experimental = 0)
      response = client.get("/api/currencies.json?prettyprint=#{prettyprint}&show_experimental=#{show_experimental}")
      result = JSON.parse(response.body)
    end

    # Get historical exchange rates for a given time period, where available.
    #
    # [Open Exchange Rates time-series original docs](https://docs.openexchangerates.org/docs/time-series-json)
    #
    # **Examples:**
    #
    # ```
    # oxr = OpenExchangeRates::API.new("your_awesome_app_id")
    # puts oxr.time_series("2016-01-01", "2016-01-31", "EUR,BTC") #=> {"2016-01-01" => {"BTC" => 0.0023245218, "EUR" => 0.920961}, "2016-01-02" => {"BTC" => 0.00230479, "EUR" => 0.920862}, "2016-01-03" => {"BTC" => 0.0023312414, "EUR" => 0.920289}, "2016-01-04" => {"BTC" => 0.0022988242, "EUR" => 0.923285}, "2016-01-05" => {"BTC" => 0.0023133529, "EUR" => 0.930028}, "2016-01-06" => {"BTC" => 0.002318432, "EUR" => 0.92771}, "2016-01-07" => {"BTC" => 0.0021923574, "EUR" => 0.915366}}
    # ```
    def time_series(from : String, to : String, symbols : String, base = "USD")
      response = client.get("/api/time-series.json?app_id=#{@key}&start=#{from}&end=#{to}&base=#{base}&symbols=#{symbols}&prettyprint=0")
      JSON.parse(response.body)["rates"]
    end

    # Convert any money value from one currency to another at the latest API rates.
    # [**Open Exchange Rates convert docs**](https://docs.openexchangerates.org/docs/convert)
    #
    # **Examples:**
    #
    # ```
    # oxr = OpenExchangeRates.new("your_awesome_app_id")
    # result = oxr.convert(value: 800.23, from: "USD", to: "BTC")
    # puts result["meta"] #=> "{"timestamp" => 1470957306, "rate" => 0.001700835604}"
    # ```
    def convert(value : Int32|Float64, from : String, to : String)
      response = client.get("/api/convert/#{value}/#{from}/#{to}?app_id=#{@key}")
      JSON.parse(response.body)
    end

    # Show usage information,
    # return mapped object (see `Mapping::Usage`)
    #
    # **Examples:**
    #
    # ```
    # oxr = OpenExchangeRates::API.new("your_awesome_app_id")
    # usage = oxr.usage
    # puts usage.to_json                  #=> {"app_id":"your_awesome_app_id","status":"active","plan":{"name":"Unlimited","quota":"Unlimited requests/month","update_frequency":"300s","features":{"base":true,"symbols":true,"experimental":true,"time-series":true,"convert":true}},"usage":{"requests":275,"requests_quota":-1,"requests_remaining":-1,"days_elapsed":14,"days_remaining":17,"daily_average":19}}
    # puts usage.status                   #=> "active"
    # puts usage.plan.to_json             #=> {"name":"Unlimited","quota":"Unlimited requests/month","update_frequency":"300s","features":{"base":true,"symbols":true,"experimental":true,"time-series":true,"convert":true}}
    # puts usage.plan.name                #=> "Unlimited"
    # puts usage.plan.quota               #=> "Unlimited requests/month"
    # puts usage.plan.update_frequency    #=> "300s"
    # puts usage.plan.features            #=> {"base" => true, "symbols" => true, "experimental" => true, "time-series" => true, "convert" => true}
    # ```
    def usage
      response = client.get("/api/usage.json?app_id=#{@key}")
      OpenExchangeRates::Mapping::Usage.from_json(response.body).data
    end
  end
end

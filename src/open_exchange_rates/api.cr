module OpenExchangeRates
  # Api class is a **OpenExchangeRates**(see the `OpenExchangeRates` module) that has been
  # described since antiquity as a beast with a large, spiraling horn projecting
  # from its forehead.
  class API
    getter key
    getter uri
    getter client

    def initialize(key : String)
      @key = key
      @uri = URI.parse("https://openexchangerates.org")
      @client = HTTP::Client.new(@uri)
    end

    # Return latast rates
    #
    # ```
    # oxr = OpenExchangeRates::API.new("API_KEY")
    # puts oxr.latest #= {"AED" => 3.672852, "AFN" => 67.842051, "ALL" => 121.8915, "AMD" => 476.242503...
    # puts oxr.latest.rates #=> Hash
    # puts oxr.latest["EUR"]
    # ```
    def latest
      response = client.get("/api/latest.json?&app_id=#{@key}")
      # JSON.parse(response.body)["rates"]
      result = build(response.body)
      # Formatters::JSON.new(result, @output)
    end
    # Get historical exchange rates for any date available from the Open Exchange Rates API.
    #
    #
    # ```
    # oxr = OpenExchangeRates::API.new("API_KEY")
    # puts oxr.historical("2016-01-01") #=>
    # ```
    def historical(data : String)
      response = client.get("/api/historical/#{data}.json?app_id=#{@key}")
      result = JSON.parse(response.body)
    end

    # Get a JSON list of all currency symbols available from the Open Exchange Rates API
    #
    # ```
    # oxr = OpenExchangeRates::API.new("API_KEY")
    # puts oxr.currencies #=> ""
    # ```
    def currencies(prettyprint = 0, show_experimental = 0)
      response = client.get("/api/currencies.json?prettyprint=#{prettyprint}&show_experimental=#{show_experimental}")
      result = JSON.parse(response.body)
    end

    # Get historical exchange rates for a given time period, where available.
    #
    # [Open Exchange Rates time-series docs](https://docs.openexchangerates.org/docs/time-series-json)
    # ```
    # oxr = OpenExchangeRates::API.new("API_KEY")
    # puts oxr.currencies #=> ""
    # ```
    def time_series(from : String, to : String, symbols : String, base = "USD")
      response = client.get("/api/time-series.json?app_id=#{@key}&start=#{from}&end=#{to}&base=#{base}&symbols=#{symbols}&prettyprint=0")
      JSON.parse(response.body)
    end

    # Convert any money value from one currency to another at the latest API rates.
    # [**Open Exchange Rates convert docs**](https://docs.openexchangerates.org/docs/convert)
    #
    # ```
    # oxr = OpenExchangeRates.new("API_KEY")
    # result = oxr.convert(value: 800.23, from: "USD", to: "BTC")
    # puts result["meta"] #=> "{"timestamp" => 1470957306, "rate" => 0.001700835604}"
    # ```
    def convert(value : Int32|Float64, from : String, to : String)
      response = client.get("/api/convert/#{value}/#{from}/#{to}?app_id=#{@key}")
      JSON.parse(response.body)
    end

    # Show usage information
    # ```
    # oxr = OpenExchangeRates::API.new("API_KEY")
    # puts oxr.usage #=> ""
    # ```
    def usage
      response = client.get("/api/usage.json?app_id=#{@key}")
      result = JSON.parse(response.body)
      r = result["data"]
      OpenExchangeRates::Mapping::Usage.from_json(response.body)

    end

    def build(result)
      OpenExchangeRates::Mapping::Latest.from_json(result)
    end

  end
end

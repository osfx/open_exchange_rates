require "./spec_helper"

describe OpenExchangeRates do

  subject =  OpenExchangeRates::API.new("api-key")

  describe "API" do
    it ".new read api-key" do
      subject.key.should eq("api-key")
    end

    it ".latest response with code 200" do
      WebMock.stub(:get, "https://openexchangerates.org/api/latest.json?&app_id=api-key").
      to_return(body: %({"disclaimer": "val", "license": "new", "timestamp": 123, "base": "base", "rates": {"string": 1.09}}))

      subject.latest.to_json.should eq String

    end

    it ".historical response will return JSON::Any" do
      WebMock.stub(:get, "https://openexchangerates.org/api/historical/2016-01-01.json?app_id=api-key").
      to_return(body: %({"rates": {"AED": 3.672852,"AFN": 67.842051, "ALL": 121.8915}}))

      subject.historical("2016-01-01").class.should eq(JSON::Any)
    end

    it ".currencies show all available and return as JSON::Any" do
      WebMock.stub(:get, "https://openexchangerates.org/api/currencies.json?prettyprint=0&show_experimental=0").
         to_return(body: %({"currencies": {"key": "val"}}))

      subject.currencies.class.should eq(JSON::Any)
    end


    it ".time_series will return JSON::Any" do
      WebMock.stub(:get, "https://openexchangerates.org/api/time-series.json?app_id=api-key&start=2016-01-01&end=2016-01-31&base=USD&symbols=EUR,BTC&prettyprint=0").
         to_return(body: %({"rates": {"timestamp": 1470957306, "rate": 0.001700835604}}))

      subject.time_series("2016-01-01", "2016-01-31", "EUR,BTC").class.should eq(JSON::Any)
    end

    it ".convert show exchange rate" do
      WebMock.stub(:get, "https://openexchangerates.org/api/convert/800.23/USD/BTC?app_id=api-key").
         to_return(body: %({"timestamp": 1470957306, "rate": 0.001700835604}))
      subject.convert(value: 800.23, from: "USD", to: "BTC").class.should eq(JSON::Any)
    end

    it ".usage" do
      response = %({"status": "active", "data": {"app_id": "your_app_id","status":"active","plan":{"name":"Unlimited","quota":"Unlimited requests/month","update_frequency":"300s","features":{"base":true,"symbols":true,"experimental":true,"time-series":true,"convert":true}},"usage":{"requests":275,"requests_quota":-1,"requests_remaining":-1,"days_elapsed":14,"days_remaining":17,"daily_average":19}}})
      WebMock.stub(:get, "https://openexchangerates.org/api/usage.json?app_id=api-key").
         to_return(body: response)

      subject.usage.to_json.class.should eq String
    end

  end
end

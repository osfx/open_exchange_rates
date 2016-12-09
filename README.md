# OpenExchangeRates
Crystal library for [Open Exchange Rates Service](https://openexchangerates.org)

## Docs
[![docrystal.org](http://docrystal.org/badge.svg)](http://docrystal.org/github.com/osfx/open_exchange_rates)

## Installation


Add this to your application's `shard.yml`:

```yaml
dependencies:
  open_exchange_rates:
    github: osfx/open_exchange_rates
```


## Usage
```crystal
require "open_exchange_rates"
```
### Latest:
Get the latest exchange rates available from the Open Exchange Rates API.

**Exapmple:**
```crystal
oxr = OpenExchangeRates::API.new("your_awesome_app_id")
puts oxr.latest       #=> return mapped object
puts oxr.latest.rates #=> {"AED" => 3.672852, "AFN" => 67.842051, "ALL" => 121.8915, "AMD" => 476.242503...
puts oxr.latest["EUR"]#=> 0.8942

```

### Historical:
Get historical exchange rates for any date available from the Open Exchange Rates API.

**Exapmple:**
```crystal
oxr = OpenExchangeRates::API.new("your_awesome_app_id")
puts oxr.historical("2016-01-01") #=> {"AED" => 3.672754, "AFN" => 68.45, "ALL" => 125.9742, "AMD" => 483.75, "ANG" => 1.78875, "AOA" => 135.256669, "ARS" => 12.96635, "AUD" => 1.37393, "AWG" => 1.790083, "AZN" => 1.562017, "BAM" => 1.797331...}

```

### Currencies:
Get a JSON list of all currency symbols available from the Open Exchange Rates API

**Exapmple:**
```crystal

oxr = OpenExchangeRates::API.new("your_awesome_app_id")
puts oxr.currencies #=> "{"AED" => "United Arab Emirates Dirham", "AFN" => "Afghan Afghani", "ALL" => "Albanian Lek", "AMD" => "Armenian Dram", "ANG" => "Netherlands Antillean Guilder", "AOA" => "Angolan Kwanza", "ARS" => "Argentine Peso"...}

```

### Time-Series:
Get historical exchange rates for a given time period, where available.

[**Open Exchange Rates time-series original docs**](https://docs.openexchangerates.org/docs/time-series-json)

**Exapmple:**
```crystal

oxr = OpenExchangeRates::API.new("your_awesome_app_id")
puts oxr.time_series("2016-01-01", "2016-01-31", "EUR,BTC")
#=> {"2016-01-01" => {"BTC" => 0.0023245218, "EUR" => 0.920961}, "2016-01-02" => {"BTC" => 0.00230479, "EUR" => 0.920862}, "2016-01-03" => {"BTC" => 0.0023312414, "EUR" => 0.920289}, "2016-01-04" => {"BTC" => 0.0022988242, "EUR" => 0.923285}, "2016-01-05" => {"BTC" => 0.0023133529, "EUR" => 0.930028}, "2016-01-06" => {"BTC" => 0.002318432, "EUR" => 0.92771}, "2016-01-07" => {"BTC" => 0.0021923574, "EUR" => 0.915366}}
```

### Convert:
Convert any money value from one currency to another at the latest API rates.
[**Open Exchange Rates convert docs**](https://docs.openexchangerates.org/docs/convert)

**Exapmple:**
```crystal

oxr = OpenExchangeRates::API.new("your_awesome_app_id")
result = oxr.convert(value: 800.23, from: "USD", to: "BTC")
puts result["meta"] #=> "{"timestamp" => 1470957306, "rate" => 0.001700835604}"

```

### Usage:
Show usage information

**Exapmple:**
```crystal

oxr = OpenExchangeRates::API.new("your_awesome_app_id")

oxr = OpenExchangeRates::API.new("your_awesome_app_id")
usage = oxr.usage
puts usage.to_json                  #=> {"app_id":"your_awesome_app_id","status":"active","plan":{"name":"Unlimited","quota":"Unlimited requests/month","update_frequency":"300s","features":{"base":true,"symbols":true,"experimental":true,"time-series":true,"convert":true}},"usage":{"requests":275,"requests_quota":-1,"requests_remaining":-1,"days_elapsed":14,"days_remaining":17,"daily_average":19}}
puts usage.status                   #=> "active"
puts usage.plan.to_json             #=> {"name":"Unlimited","quota":"Unlimited requests/month","update_frequency":"300s","features":{"base":true,"symbols":true,"experimental":true,"time-series":true,"convert":true}}
puts usage.plan.name                #=> "Unlimited"
puts usage.plan.quota               #=> "Unlimited requests/month"
puts usage.plan.update_frequency    #=> "300s"
puts usage.plan.features            #=> {"base" => true, "symbols" => true, "experimental" => true, "time-series" => true, "convert" => true}
```



## Contributing

1. Fork it ( https://github.com/osfx/open_exchange_rates/fork )
2. Create your feature branch (git checkout -b my-new-feature)
3. Commit your changes (git commit -am 'Add some feature')
4. Push to the branch (git push origin my-new-feature)
5. Create a new Pull Request

## Contributors

- [ Peter Boriskin](https://github.com/osfx) - creator, maintainer

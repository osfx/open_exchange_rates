require "./open_exchange_rates/**"
require "http/client"
require "json"



oxr = OpenExchangeRates::API.new("7aee7f9365e94e669a4aa24b1f3dfc2b")
p oxr.latest

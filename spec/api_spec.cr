require "./spec_helper"

describe OpenExchangeRates::API do
  # include Spec2::GlobalDSL

  # let(server) { "https://openexchangerates.org" }
  it "work" do
    @api = OpenExchangeRates::API.new
    WebMock.stub(:any, "https://openexchangerates.org" )

    response = HTTP::Client.get("https://openexchangerates.org" )
    response.body.should eq ""        #=> ""
    # response.status_code
  end
end

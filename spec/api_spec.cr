# dadasd

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

  context "client" do
    it "#latest show" do
      oxr = OpenExchangeRates::API.new("your_awesome_app_id")
      # oxr.latest.should eq ""
      true.should eq true
    end

    it ".historical" do

    end

    it ".currencies" do

    end

    it ".time_series" do

    end

    it ".convert" do

    end

    it ".convert" do

    end
  end
end

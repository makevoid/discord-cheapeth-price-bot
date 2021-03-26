require_relative "spec_helper"


describe "Centex" do

  before do
    Centex.send :remove_const, :STAMP
    bitstamp = Bitstamp.new
    allow(bitstamp).to receive(:ethusd_get) {
      {"high" => "2000.00", "last" => "2000.00", "timestamp" => "1616735804", "bid" => "1000.00", "vwap" => "...", "volume" => "63298.53412520", "low" => "1000.00", "ask" => "2000.00", "open" => "1000.00"}.to_json
    }
    Centex::STAMP = bitstamp
  end

  let (:centex) { Centex.new }

  before do
    allow(centex).to receive(:tickers_get) {
      [{"ticker_id":"CTH-ETH","base_currency":"CTH","target_currency":"ETH","last_price":"0.00004000","base_volume":"93.00000000","target_volume":"0.00314600","bid":"0.00002000","ask":"0.00004000","high":"0.00004000","low":"0.00002000"},{"ticker_id":"REA-BTC","base_currency":"REA","target_currency":"BTC","last_price":"0.00000005","base_volume":"0.00000000","target_volume":"0.00000000","bid":"0.00000001","ask":"0.00000005","high":"0.000000","low":"0.00000000"}].to_json
    }
  end

  specify "gets ticker price (mid price)" do
    mid_price = 0.00003
    mid_price_usd = 0.045
    price = centex.ticker symbol: :CTH
    price.fetch(:price).should == mid_price
    price.fetch(:price_usd).should == mid_price_usd
  end

end

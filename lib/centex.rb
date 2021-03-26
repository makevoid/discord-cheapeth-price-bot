# usage:
#
#   c = Centex.new
#   c.ticker symbol: :CTH #=> "0.0123"
#   # returns the current mid price from centex tickers API
#

class Centex

  API_HOST = "https://api.centex.io"
  TICKERS_URL = "#{API_HOST}/v1/public/tickers"

  ALT_PAIRS = {
    CNTX: "CNTX-BTC",
    SFD:  "SFD-BTC",
    BULL: "BULL-BTC",
    DNO:  "DNO-BTC",
    BTCI: "BTCI-USDT",
    CTH:  "CTH-ETH",
    REA:  "REA-BTC",
    ATC2: "ATC2-BTC",
    DTH:  "DTH-ETH",
  }

  def ticker(symbol:)
    tickers = tickers_get
    tickers = JSON.parse tickers
    pair = ALT_PAIRS.fetch symbol
    ticker = tickers.find &FindTicker.(pair)
    mid_price ticker
  end

  def self.ticker(symbol:)
    new.ticker symbol: symbol
  end

  def tickers_get
    resp = Excon.get TICKERS_URL
    resp.body
  end

  FindTicker = -> (pair) {
    -> (tick) {
      ticker_id = tick.fetch "ticker_id"
      ticker_id == pair
    }
  }

  def mid_price(ticker)
    ask_price = BigDecimal ticker.fetch("ask")
    bid_price = BigDecimal ticker.fetch("bid")
    (ask_price + bid_price) / 2
  end

end

if __FILE__ == $0
  require 'bundler'
  Bundler.require :default
  c = Centex.new
  c.ticker symbol: :CTH
end

# usage:
#
#   require_relative 'lib/mid_price'
#   require_relative 'lib/bitstamp'
#   require_relative 'lib/centex'
#
#   c = Centex.new
#   c.ticker symbol: :CTH #=> { price: "0.0123", price_usd: "0.1" } # (sample prices)
#   # returns the current mid price from centex tickers API in both ETH and USD
#

class Centex

  STAMP = Bitstamp.new # fetch ETHUSD from bitstamp

  include MidPrice

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
    price = mid_price ticker
    price_ethusd = price_ethusd_get
    price_usd = price * price_ethusd
    {
      price:      price,
      price_usd:  price_usd,
    }
  end

  def self.ticker(symbol:)
    new.ticker symbol: symbol
  end

  def tickers_get
    resp = Excon.get TICKERS_URL
    resp.body
  end

  def price_ethusd_get
    STAMP.ticker_ethusd
  end

  FindTicker = -> (pair) {
    -> (tick) {
      ticker_id = tick.fetch "ticker_id"
      ticker_id == pair
    }
  }

end

class Bitstamp

  include MidPrice

  API_HOST = "https://www.bitstamp.net"
  TICKER_URL = "#{API_HOST}/api/v2/ticker/ethusd"

  def ethusd_get
    resp = Excon.get TICKER_URL
    resp.body
  end

  def ticker_ethusd
    ticker = ethusd_get
    ticker = JSON.parse ticker
    mid_price ticker
  end

  def self.ticker_ethusd
    new.ticker_ethusd
  end

end

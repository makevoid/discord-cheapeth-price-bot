require_relative 'env'

BOT.command :ping do |evt|
  evt.respond 'Pong!'
end

CTX = Centex.new

# TODO: move these modules out

module CmdLib

  def cmd_price
    CTX.ticker symbol: :CTH
  end

end

module FmtLib

  # format timestamp
  def f_timestamp(timestamp)
    timestamp = hex_to_int timestamp
    Time.at(timestamp).strftime "%H:%M:%S"
  end

  # utils - hex string to integer
  def hex_to_int(value)
    validate_timestamp_hash value
    value.to_i 16
  end

  # utils - hex validations - timestamp
  def validate_timestamp_hash(hash)
    raise "HexTimestampValueFormatError" if !hash.is_a?(String) || hash[0..1] != "0x" || hash.size != 10
  end

end

include CmdLib
include FmtLib

# bot high level commmands

Help = -> (evt) {
  evt.respond "```
!price - prints ETH-cTH price from centex
!block - prints the latest block info
```"
}

Block = -> (evt) {
  block = ETH.block_latest
  id    = block.fetch :id
  num   = block.fetch :num
  time  = f_timestamp block.fetch :time
  evt.respond "```#{id} (##{num} @ #{time.strftime "%H:%M:%S"})```"
}

Price = -> (evt) {
  puts "> price()"
  prices = cmd_price
  price = prices.fetch :price
  price_usd = prices.fetch :price_usd
  mid_price = price.to_f.round 7
  mid_price_usd = price_usd.to_f.round 3
  evt.respond "```1 cTH = $#{("%0.3f" % mid_price_usd).remove_trailing_zeroes} (#{("%0.7f" % mid_price).remove_trailing_zeroes} ETH)```"
}

# bot chat commands

BOT.command :"help" do |evt|
  Help.(evt)
end

BOT.command :"block" do |evt|
  Block.(evt)
end

BOT.command :"price" do |evt|
  Price.(evt)
end

# sample commands
#
# BOT.command :"who", min_args: 1, max_args: 1 do |evt, char_name|
#   Who.(evt, char_name)
# end
#
# BOT.command :user do |evt|
#   evt.user.name
# end


# main

Thread.abort_on_exception = true

FormatNum = -> (number) {
  number.to_s.reverse.gsub(/(\d{3})(?=\d)/, '\\1,').reverse
}

ChanAlertsMainLoop = -> {
  loop do
    # TODO: whale alert
    sleep 60
  end
}

Thread.new do
  ChanAlertsMainLoop.()
end

BOT.run

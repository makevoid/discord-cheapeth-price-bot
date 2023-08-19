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
  evt.respond "```#{id} (##{num} @ #{time})```"
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


# Talk to gpt3 BOT
BOT.command :"bot1", min_args: 1, max_args: 20 do |evt, *prompt|
  prompt = prompt.join " "
  evt.respond GPT3Demo.(prompt, bot_id: 1)
end

BOT.command :"bot2", min_args: 1, max_args: 20 do |evt, *prompt|
  prompt = prompt.join " "
  evt.respond GPT3Demo.(prompt, bot_id: 2)
end

BOT.command :"bot3", min_args: 1, max_args: 20 do |evt, *prompt|
  prompt = prompt.join " "
  evt.respond GPT3Demo.(prompt, bot_id: 3)
end

BOT.command :"bot4", min_args: 1, max_args: 20 do |evt, *prompt|
  user_id = 936929561302675456
  resp = "/imagine prompt:test"
  # evt.respond resp
  user_obj = BOT.user user_id 
  pm = user_obj.pm resp
  p pm 
  # evt.user.pm resp
end

user_id = 936929561302675456

# BOT.message(content: "used") do |event|
#   event.respond 'ok'
# end

def download_image(image_url:, download_path:)
  image_name = File.basename image_url
  download_path = "#{download_path}/#{image_name}"
  File.open(download_path, 'wb') do |file|
    response = Excon.get(image_url, response_block: ->(chunk, remaining_bytes, total_bytes) {
      file.write chunk
    })

    if response.status == 200
      puts "image downloaded"
    else
      puts "Error: #{response.status}"
    end
  end
end

# Example usage:

BOT.message do |event|
  latest_message = event.channel.history 1
  latest_message = latest_message.first

  next unless latest_message.attachments.any?
  next unless latest_message.content =~ /(fast)/
  next if latest_message.content =~ /upscaling/ # TODO: remove this if ENV["IGNORE_UPSCALE"] == "false"
  attachment = latest_message.attachments.first
  next unless attachment.image?

  image_url = attachment.url

  puts "midjourney message detected"
  puts "URL: #{attachment.url}\n\n"

  download_image image_url: image_url, download_path: "./output_images"
end

# sample commands
#
# BOT.command :"who", min_args: 1, max_args: 20 do |evt, char_name|
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

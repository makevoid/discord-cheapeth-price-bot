require_relative 'env'

BOT.command :ping do |evt|
  evt.respond 'Pong!'
end

module CmdLib
  def cmd_price
    Centex.last_price
  end
end

include CmdLib

# bot high level commmands

Help = -> (evt) {
  evt.respond "```
!price - prints ETH-cTH price from centex
```"
}

Price = -> (evt) {
  puts "> price()"
  evt.respond "```#{cmd_price}...```"
}

# bot chat commands

BOT.command :"help" do |evt|
  Help.(evt)
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

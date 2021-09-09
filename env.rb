require 'json'
require 'bigdecimal'
require 'bundler'

APP_ENV = ENV["APP_ENV"] || ENV["RACK_ENV"] || "development"

Bundler.require :default, APP_ENV

path = File.expand_path '../', __FILE__
PATH = path

require_relative 'env_secret' # NOTE: see readme, you need to configure the secrets to be able to start the app
require_relative 'lib/monkeypatches'
require_relative 'lib/mid_price'
require_relative 'lib/bitstamp'
require_relative 'lib/centex'
require_relative 'lib/gpt3_bot_config'
require_relative 'lib/gpt3'

raise "No secret `CLIENT_SECRET`" unless defined? CLIENT_SECRET
raise "No secret `BOT_TOKEN`" unless defined? BOT_TOKEN

# DISCORD
CLIENT_KEY = "558267878462324736"

CHANNEL_ID = "263875120555098112" # makevoiders - general

# BOT = Discordrb::Bot.new token: BOT_TOKEN
BOT = Discordrb::Commands::CommandBot.new token: BOT_TOKEN, prefix: '!'

# use this url to authorize (replace client id with your `client_id`):
# https://discordapp.com/oauth2/authorize?&client_id=558267878462324736&scope=bot&permissions=8

ETH_RPC_PATH = "/rpc"
require_relative 'lib/web3-monkeypatches'

WEB3 = Web3::Eth::Rpc.new host: 'node.cheapeth.org',
                          port: 443,
                          connect_options: { use_ssl: true }

require_relative 'lib/eth'

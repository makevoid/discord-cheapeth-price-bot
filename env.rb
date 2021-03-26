require 'json'
require 'bigdecimal'
require 'bundler'

APP_ENV = ENV["APP_ENV"] || ENV["RACK_ENV"] || "development"

Bundler.require :default, APP_ENV

path = File.expand_path '../', __FILE__
PATH = path

require_relative 'env_secret' # NOTE: see readme, you need to configure the secrets to be able to start the app
require_relative 'lib/centex'

raise "No secret `CLIENT_SECRET`" unless defined? CLIENT_SECRET
raise "No secret `BOT_TOKEN`" unless defined? BOT_TOKEN

# DISCORD
CLIENT_KEY = "558267878462324736"

CHANNEL_ID = ""

# BOT = Discordrb::Bot.new token: BOT_TOKEN
BOT = Discordrb::Commands::CommandBot.new token: BOT_TOKEN, prefix: '!'

# use this url to authorize (replace client id with your `client_id`):
# https://discordapp.com/oauth2/authorize?&client_id=558267878462324736&scope=bot&permissions=8

# discord-cheapeth-price-bot

Discord bot that fetches the latest cheapETH (cTH) price from the exchange(s) 

The only command available at the moment is `!price` (gets cTH median price and prints it into the channel)

#### Bot Usage

- Write `!price` in a channel where the bot is installed
- profit! 

### Configure Env / Secrets

Rename `env_secret.default.rb` to `env_secret.rb` and fill the credentials for at least Discord (CLIENT_SECRET and BOT_TOKEN).

Edit `env.rb` and replace `CLIENT_KEY` and `CHANNEL_ID` with your Discord bot credentials.

#### Requirements

Latest ruby stable installed (should work with any ruby version from v2.1 onwards)

#### Setup

    bundle

#### Run

    rake

----

@makevoid


based on https://github.com/makevoid/discord-daoc-phoenix-bot

# discord-cheapeth-price-bot

Discord bot that adds a `!price` command to the server /channel


#### Bot Usage

Write `!price` in a channel where the bot is installed

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

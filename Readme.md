# discord-cheapeth-price-bot

Discord price bot - prints cheapeth price in $ into a discord channel

The only command available at the moment is `!price` (gets cTH median price and prints it into the channel)

#### Try the bot

Join this discord server if you want to try the bot:

####  https://discord.gg/uJApvZky

(makevoiders Discord server - #general channel - the bot is there, have fun with it!)

#### Bot Usage

- Write `!block` in a channel where the bot is installed
- Write `!price` to get the latest price
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

based on https://github.com/makevoid/discord-daoc-phoenix-bot

---

@makevoid

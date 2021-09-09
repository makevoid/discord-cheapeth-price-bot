# install app dependencies (rubygems)

set -xe

HOST=bot.cth.mkv.run

ssh root@$HOST  "cd /root/discord-cheapeth-price-bot && bundle"

set -xe

HOST=bot.cth.mkv.run

ssh root@$HOST  "cd /root/discord-cheapeth-price-bot && git stash && git pull origin master && git stash apply && pm2 restart all"

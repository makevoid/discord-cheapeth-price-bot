set -xe

HOST=bot.cth.mkv.run

ssh root@$HOST "cd /root/discord-rp-bot && pm2 logs"

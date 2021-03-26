set -xe

HOST=

ssh root@$HOST "cd /root/discord-rp-bot && pm2 logs"

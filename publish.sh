set -xe

HOST=

ssh root@$HOST  "cd /root/discord-rp-bot && git stash && git pull origin master && git stash apply && pm2 restart all"

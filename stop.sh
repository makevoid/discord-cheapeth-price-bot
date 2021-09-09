# install app dependencies (rubygems)

set -xe

HOST=bot.cth.mkv.run

ssh root@$HOST "pm2 stop all"

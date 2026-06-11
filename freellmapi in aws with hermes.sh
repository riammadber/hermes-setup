#for clone and run freellmapi in aws
git clone https://github.com/tashfeenahmed/freellmapi.git
cd freellmapi
npm install
cp .env.example .env
ENCRYPTION_KEY="$(node -e 'console.log(require("crypto").randomBytes(32).toString("hex"))')"
printf "ENCRYPTION_KEY=%s\nPORT=3001\n" "$ENCRYPTION_KEY" > .env
npm run dev

# for run freellmapi aws always 
cd ~/freellmapi
npm install -g pm2
#check where npm installs global packages
npm config get prefix
#then
$(npm config get prefix)/bin/pm2 start server/dist/index.js --name freellmapi
$(npm config get prefix)/bin/pm2 save
$(npm config get prefix)/bin/pm2 startup


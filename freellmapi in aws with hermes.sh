# for run freellmapi aws always 
cd ~/freellmapi
npm install -g pm2
#check where npm installs global packages
npm config get prefix
#then
$(npm config get prefix)/bin/pm2 start server/dist/index.js --name freellmapi
$(npm config get prefix)/bin/pm2 save
$(npm config get prefix)/bin/pm2 startup


#1. SSH into your EC2 instance

bashssh -i your-key.pem ubuntu@your-ec2-ip

#2. Navigate to your Hermes directory

bashcd ~/hermes-agent  # or wherever you cloned it

#3. Pull the latest code from GitHub

bashgit pull origin main  # or whichever branch has the new version

#4. Install any new dependencies

bashpip install -r requirements.txt --break-system-packages
# or if you use a venv:
source venv/bin/activate && pip install -r requirements.txt

#5. Apply any new environment variables
If the new version added new config keys, update your .env file:
bashnano .env

#6. Restart Hermes
#Since you're using screen or nohup for persistence:
#bash# If using screen:
screen -r hermes        # attach to existing session
# Ctrl+C to stop, then restart:
python main.py

# If using nohup, kill the old process first:
pkill -f "python main.py"
nohup python main.py > hermes.log 2>&1 &
#7. Verify it's running
bashtail -f hermes.log   # watch logs
# or
screen -ls           # check screen sessions

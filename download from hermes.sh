# Download as zip
sudo apt install zip -y  # install sudo 
# go the project directory  
cd /home/ubuntu/Hermes-project #examples 
zip -r linkdrip.zip LinkDrip --exclude "LinkDrip/node_modules/*"

#  SCP to your local machine (run this on your local PC)
scp -i your-key.pem ubuntu@your-ec2-ip:/home/ubuntu/Hermes-project/LinkDrip.zip ./

# for backup create a Fine-grained personal access tokens with content read and write permission 
hermes config set GITHUB_BACKUP_TOKEN= your token

# go folder directory 
cd /home/ubuntu/Hermes-project/LinkDrip
git init
git add .
git commit -m "LinkDrip project"
git remote add origin https://github.com/yourusername/linkdrip.git
git push -u origin main

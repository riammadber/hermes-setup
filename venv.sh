# finds every venv by its config file. For a cleaner output with just the venv directories
find / -name "pyvenv.cfg" 2>/dev/null | xargs -I{} dirname {}
#delete broken venv
#The pattern is:rm -rf /path/to/project/{folder_to_delete}
rm -rf /home/ubuntu/.hermes/hermes-agent/{venv name}
# Create fresh venv
python3 -m venv /home/ubuntu/.hermes/hermes-agent/{venv_name}

# Install hermes into it
/home/ubuntu/.hermes/hermes-agent/{venv_name}/bin/pip install -e /home/ubuntu/.hermes/hermes-agent/
# if you setup script uses uv
#This will create the venv correctly with uv
cd /home/ubuntu/.hermes/hermes-agent/
rm -rf venv
./setup-hermes.sh

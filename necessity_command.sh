# finds every venv by its config file. For a cleaner output with just the venv directories
find / -name "pyvenv.cfg" 2>/dev/null | xargs -I{} dirname {}
# check Disk space
df -h

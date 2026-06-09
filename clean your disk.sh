
# check Disk space
df -h
# Find what's eating space:
du -sh /home/ubuntu/* 2>/dev/null | sort -rh | head -20
#hidden folders .
du -sh /home/ubuntu/.*  2>/dev/null | sort -rh | head -20
#cache — created automatically by pip when you install packages. It stores downloaded packages so reinstalls are faster. Not needed — safe to delete.
#.npm — created by npm when you install Node packages. Same idea — speeds up reinstalls. Not needed — safe to delete.
#.hermes — this is YOUR project. Contains Hermes Agent code + venv. Needed — but 3.7G is too big, something inside is bloated. Need to check what's inside.
rm -rf /home/ubuntu/.cache  #delete cache 
rm -rf /home/ubuntu/.npm    #delete npm
#if .hermes looks too big, something inside is bloated. Need to check what's inside
du -sh /home/ubuntu/.hermes/* 2>/dev/null | sort -rh
# find the unnecessary items
rm -rf /home/ubuntu/.hermes/{item name}

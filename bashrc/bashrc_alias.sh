
alias tmux-help="cat $HELPS_DIR/tmux-help"

# SCAD aliases

alias ls_scad_libraries="ls ~/.local/share/OpenSCAD/libraries"

# general one-liners

alias chk_disk_use="du -x -d 1"
alias chk_disk_use_home="du -x -d 1 ~/ | sort -n -r | tee ~/disk_use_home.txt"
alias chk_disk_use_root="du -x -d 1 / | sort -n -r | tee ~/disk_use_root.txt"

alias chk_cache_1year="find ~/.cache/ -depth -type f -atime +365"
alias chk_cache_100days="find ~/.cache/ -depth -type f -atime +100"

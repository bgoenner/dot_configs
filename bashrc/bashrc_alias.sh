
# tmux aliases

alias tmux-ls="tmux list-sessions"
alias tmux-code="tmux new-session -t code"
alias tmux-base="tmux new-session -t base"
alias tmux-help="cat $HELPS_DIR/tmux-help"

# kitty aliases

alias icat="kitten icat"
alias kitdiff="kitten diff"
alias kssh="echo 'kitten ssh'; kitten ssh"
alias katssh="echo 'kitten ssh'; kitten ssh"
alias kittransfer="kitten transfer"
alias katdownload="kitten transfer"
alias katupload="kitten transfer --direction=upload"

# SCAD aliases

alias ls_scad_libraries="ls ~/.local/share/OpenSCAD/libraries"

# flake8
alias ln-flake8="ln -s ~/.dot_configs/flake8 .flake8"

# general one-liners

alias chk_disk_use="du -x -d 1"
alias chk_disk_use_home="du -x -d 1 ~/ | sort -n -r | tee ~/disk_use_home.txt"
alias chk_disk_use_root="du -x -d 1 / | sort -n -r | tee ~/disk_use_root.txt"

alias chk_cache_1year="find ~/.cache/ -depth -type f -atime +365"
alias chk_cache_100days="find ~/.cache/ -depth -type f -atime +100"

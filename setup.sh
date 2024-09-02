
# arguments
# $1 file loc 
# $2 ln loc

create_sym_link () {
  FILE=$1
  if [ ! -f "$FILE" ]; then
    echo "$FILE does not exist."
    ln -s "$(pwd)/$1" "$2/$1"
  elif [ -d "$FILE" ]; then
    # if $2 exists +1
    # else add bkup and mv
    if [ $3 -eq 0 ]; then
      NUM = 1
    else
      NUM = $3 + 1
    fi
    if [ -d "$FILE.$NUM.bkup" ]; then

    else
      create_sym_link($1, $2, $3)
    fi
    echo "$FILE is a directory."
  elif [ -h -f "$FILE" ]; then
    echo "$FILE as symbolic link exists. No action performed."
  fi
}



# files to create

#CONFIG_DIR="~/.config"
CONFIG_DIR="~/config_test"

create_sym_link("tmux", $CONFIG_DIR)
create_sym_link("sway", $CONFIG_DIR)
create_sym_link("nvim", $CONFIG_DIR)
create_sym_link("kitty", $CONFIG_DIR)

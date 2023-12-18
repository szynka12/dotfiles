# This was taken from the SpaceVim install script
Color_off='\033[0m'       # Text Reset

Black='\033[0;30m'        # Black
Red='\033[0;31m'          # Red
Green='\033[0;32m'        # Green
Yellow='\033[0;33m'       # Yellow
Blue='\033[0;34m'         # Blue
Purple='\033[0;35m'       # Purple
Cyan='\033[0;36m'         # Cyan
White='\033[0;37m'        # White

# Console output functions
msg()     { printf '%b\n' "$1" >&2; }
success() { msg "${Green}[✔]${Color_off} ${1}${2}"; }
info()    { msg "${Blue}[➭]${Color_off} ${1}${2}"; }
error()   { msg "${Red}[✘]${Color_off} ${1}${2}"; exit 1; }
warn ()   { msg "${Yellow}[⚠]${Color_off} ${1}${2}"; }

# Create output file and overwrites it if neccesary (warns)
#   $1 - path to the 
create_tmp() {
  if test -f "${1}"; then
    warn "Overwriting existing tmp file in: " ${1}
    rm ${1}
  fi
  touch ${1}
}

# Deletes the tmp file 
#   $1 - path to file
clean_tmp() { info "Cleaning ..."; rm ${1}; }

create_folder_or_file()
{
  case "$1" in
    */)
      mkdir -p $1 ;;
    *)
      touch $1 ;;
  esac
}

# Check if folder or file exists and ask if the script should continue
#   $1 - path
check_and_ask () {
  case "$1" in
    /*)

      if [ -f "$1" ] || [ -d "$1" ]; then
        info "Located " $1
      else
        warn "$1" " does not exist!"

        read -p "    Do you want to create it (y/n) [n]: " new_file
        new_file=${new_file:-n}
        case "$new_file" in
          y)
            create_folder_or_file ${1}
            ;;
          n)
            read -p "    Do you want to provide other path (y/n) [y]: " new_path
            new_path=${new_path:-y}
            case "$new_path" in 
              y)
                read -p "  New path (add '/' for a folder): " actual_path
                check_and_ask $actual_path
                ;;
              n)
                info "Alright, exiting."
                exit 0
                ;;
              *)
                error "No such option, exiting"
                exit 0
                ;;
            esac
            ;;
          *)
            error "No such option, exiting"
            exit 0
            ;;
        esac
      fi

      ;;
    *)
      error "Not a valid file path."
      ;;
  esac
}

# Output to the i3 config file
to_file() { printf '%s\n' "${2}" >> ${1}; }
to_i3()   { to_file $TMP_OUT "${1}"; }
comment() { to_file $TMP_OUT "# ${1}"; }

# Set variable
#   $1 - variable name
#   $2 - value
i3set() { to_i3 "set \$${1} ${2}"; }

bindsym() { to_i3 "bindsym $1 $2"; }

# Set workspace
#   $1 - workspace name
#   $2 - workspace name
#   $3 - [Modifier] move focused container to workspace
#   $4 - [Modifier] move to workspace with focused container
workspace() {
  info "Adding workspace $1" 
  comment "Workspace ${1}"
  
  if test -z "${2}"; then
    i3set "ws${1}" "${1}"
  else
    i3set "ws${1}" "${1}|${2}"
  fi

  # switch to workspace
  to_i3 "bindsym \$mod+$1       workspace number \$ws$1"
  # move to workspace
  to_i3 "bindsym \$mod+$3+$1  move container to workspace \$ws$1"
  # move with the container
  to_i3 "bindsym \$mod+$4+$1 move container to workspace \$ws$1; workspace \$ws$1"
  
  to_i3 ""
}

# Bindsym moving containers and changing focus
#   $1 - left key
#   $2 - down key
#   $3 - up key
#   $4 - right key
movement() {
  bindsym "\$mod+$1" "focus left"
  bindsym "\$mod+$2" "focus down"
  bindsym "\$mod+$3" "focus up"
  bindsym "\$mod+$4" "focus right"
  
  bindsym "\$mod+Shift+$1" "move left"
  bindsym "\$mod+Shift+$2" "move down"
  bindsym "\$mod+Shift+$3" "move up"
  bindsym "\$mod+Shift+$4" "move right"
}

# exec --no-startup-id
e_noid () { to_i3 "exec -no-startup-id $1"; }

# Include another file
include () { 
  if [ -f ${1} ]; then
    to_i3 ""
    info "Including $1" 
    cat $1 >> $TMP_OUT
    to_i3 ""
  else
    error "File $1 not found!"
  fi
}

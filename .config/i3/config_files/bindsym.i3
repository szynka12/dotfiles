# Binds: applications **********************************************************

bindsym $mod+Return     exec $term                # start a terminal

bindsym $mod+m          exec $term -e 'alsamixer' # alsamixer in floating window
bindsym $mod+F2         exec google-chrome-stable # google-chrome
bindsym $mod+F3         exec $term -e 'ranger'    # ranger
bindsym $mod+F5         exec $spotify             # spotify
bindsym $mod+Shift+F5   exec $term -e 'mocp'      # mocp
bindsym $mod+F8         exec evolution            # evolution
bindsym Print           exec --no-startup-id flameshot gui -p ~/Pictures/capture

# Binds: movement **************************************************************

# Use Mouse+$mod to drag floating windows to their wanted position
floating_modifier $mod

# change borders
bindsym $mod+u border none
bindsym $mod+y border pixel 1
bindsym $mod+n border normal

# kill focused window
bindsym $mod+Shift+q kill

# split in horizontal orientation
bindsym $mod+h split h

# split in vertical orientation
bindsym $mod+v split v

# enter fullscreen mode for the focused container
bindsym $mod+f fullscreen toggle

# change container layout (stacked, tabbed, toggle split)
bindsym $mod+s layout stacking
bindsym $mod+w layout tabbed
bindsym $mod+e layout toggle split

# toggle tiling / floating
bindsym $mod+Shift+space floating toggle

# change focus between tiling / floating windows
bindsym $mod+space focus mode_toggle

# focus the parent container
bindsym $mod+a focus parent

# focus the child container
#bindsym $mod+d focus child

# reload the configuration file
bindsym $mod+Shift+c reload

# restart i3 inplace (preserves your layout/session, can be used to upgrade i3)
bindsym $mod+Shift+r restart

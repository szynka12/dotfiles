# Bar **************************************************************************

bar {
	i3bar_command   i3bar
	status_command  i3status
	position bottom

  
  
## please set your primary output first. Example: 'xrandr --output eDP1 --primary'
tray_output primary
# tray_output DP-0

	bindsym button4 nop
	bindsym button5 nop
	strip_workspace_numbers no
  
  # Dracula
  
    colors {
      background #282A36
        statusline #F8F8F2
        separator  #44475A

        focused_workspace  #44475A #44475A #F8F8F2
        active_workspace   #282A36 #44475A #F8F8F2
        inactive_workspace #282A36 #282A36 #BFBFBF
        urgent_workspace   #FF5555 #FF5555 #F8F8F2
        binding_mode       #FF5555 #FF5555 #F8F8F2
    }

  ## Original theme
  #colors {
    ##background #222D31
    #background $term_background
    #statusline #F9FAF9
    #separator  #454947

    ##                  border  backgr. text
    #focused_workspace  #F9FAF9 #16a085 #292F34
    #active_workspace   #595B5B #353836 #FDF6E3
    #inactive_workspace #595B5B #222D31 #EEE8D5
    #binding_mode       #16a085 #2C2C2C #F9FAF9
    #urgent_workspace   #16a085 #FDF6E3 #E5201D
  #}
}

# hide/unhide i3status bar
bindsym $mod+Ctrl+m bar mode toggle

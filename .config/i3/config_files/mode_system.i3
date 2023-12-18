
# Set shut down, restart and locking features
bindsym $mod+0 mode "$mode_system"
set $mode_system (l)ock, (e)xit, switch_(u)ser, (s)uspend, (h)ibernate, (r)eboot, (Shift+s)hutdown
mode "$mode_system" {
    bindsym l       exec --no-startup-id  bash $lock lock         mode "default"
    bindsym s       exec --no-startup-id  bash $lock suspend,     mode "default"
    bindsym u       exec --no-startup-id  bash $lock switch_user, mode "default"
    bindsym e       exec --no-startup-id  bash $lock logout,      mode "default"
    bindsym h       exec --no-startup-id  bash $lock hibernate,   mode "default"
    bindsym r       exec --no-startup-id  bash $lock reboot,      mode "default"
    bindsym Shift+s exec --no-startup-id  bash $lock shutdown,    mode "default"

    # exit system mode: "Enter" or "Escape"
    bindsym Return mode "default"
    bindsym Escape mode "default"
}

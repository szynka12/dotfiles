# Application specific *********************************************************
assign [class="Evolution"] $ws8


assign [class="^Spotify*"] $ws7
for_window [class="Spotify"] move to workspace $ws7

for_window [title="alsamixer"] floating enable border pixel 1
for_window [class="GParted"] floating enable border normal
for_window [title="i3_help"] floating enable sticky enable border normal
for_window [class="Skype"] floating enable border normal

# switch to workspace with urgent window automatically
for_window [urgent=latest] focus

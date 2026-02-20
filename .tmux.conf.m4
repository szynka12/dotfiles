# vim: set filetype=conf : 

# from https://hamvocke.com/blog/a-guide-to-customizing-your-tmux-conf/


set -sg escape-time 0     # fix for vim
set -g focus-events on    # Enable focus events for vim autoread

# remap prefix from 'C-b' to 'C-a'
set-option -g prefix C-a
bind-key C-a send-prefix
unbind C-b

# Better pane splitting (and keep current path)
bind | split-window -h -c "#{pane_current_path}"
bind - split-window -v -c "#{pane_current_path}"
bind c new-window -c "#{pane_current_path}"
unbind '"'
unbind %

# reload config
bind r source-file ~/.tmux.conf

# vim-like pane switching
bind -r ^ last-window
bind -r k select-pane -U
bind -r j select-pane -D
bind -r h select-pane -L
bind -r l select-pane -R

# Enable mouse control (clickable windows, panes, resizable panes)
set -g mouse on 

# Starting index of windows
set -g base-index 1


# vim keys
set-window-option -g mode-keys vi
bind -T copy-mode-vi v send-keys -X begin-selection
bind -T copy-mode-vi y send-keys -X copy-pipe-and-cancel 'xclip -in -selection clipboard'
bind-key -T copy-mode-vi 'C-v' send -X begin-selection \; send -X rectangle-toggle

# Don't rename windows automatically
set-window-option -g automatic-rename off
set-option -g allow-rename off

# Don't do anything when a 'bell' rings
set -g visual-activity off
set -g visual-bell off
set -g visual-silence off
setw -g monitor-activity off
set -g bell-action none


# colors
# set -g default-terminal "screen-256color"
set -g default-terminal "xterm-256color"
set -g terminal-overrides ",xterm-256color:RGB"


## Configure the catppuccin plugin
set -g @catppuccin_flavor "mocha"
# set -g @catppuccin_window_status_style "rounded"


# Fix for a bug preventing renaming the windows
# https://github.com/catppuccin/tmux/discussions/401
set -g @catppuccin_window_default_text "#W"
set -g @catppuccin_window_text "#W"
set -g @catppuccin_window_current_text "#W"


# Status bar   
set -g status-justify centre
set -g status-left ""
set -g status-right '#[fg=#{@thm_crust},bg=#{@thm_teal}] session: #S '
set -g status-right-length 100 # Ensure that everything on the right side is included.


# The path to the plugin folder
set-environment -g TMUX_PLUGIN_MANAGER_PATH '__BUILD_PATH__/tmux-plugins'

# List of plugins
set -g @plugin 'tmux-plugins/tpm'
set -g @plugin 'tmux-plugins/tmux-resurrect'
set -g @plugin 'catppuccin/tmux#v2.1.2'

# Initialize TMUX plugin manager (keep this line at the very bottom of tmux.conf)
run '__BUILD_PATH__/tmux-plugins/tpm/tpm'


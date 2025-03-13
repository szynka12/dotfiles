# from https://hamvocke.com/blog/a-guide-to-customizing-your-tmux-conf/

# fix for vim
set -sg escape-time 0

# colors
set -g default-terminal "tmux-256color"

# remap prefix from 'C-b' to 'C-a'
set-option -g prefix C-a
bind-key C-a send-prefix
unbind C-b

# split panes using | and -
bind | split-window -h
bind - split-window -v
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

set -g status-style 'bg=#333333 fg=#5eacd3'

bind r source-file ~/.tmux.conf

# index of windows
set -g base-index 1

# vim keys
set-window-option -g mode-keys vi
bind -T copy-mode-vi v send-keys -X begin-selection
bind -T copy-mode-vi y send-keys -X copy-pipe-and-cancel 'xclip -in -selection clipboard'
bind-key -T copy-mode-vi 'C-v' send -X begin-selection \; send -X rectangle-toggle



## Configure the catppuccin plugin
set -g @catppuccin_flavor "mocha"
#set -g @catppuccin_window_status_style "rounded"

set -g status-left ""
set -g status-right '#[fg=#{@thm_crust},bg=#{@thm_teal}] session: #S '

# Ensure that everything on the right side of the status line
# is included.
set -g status-right-length 100


# don't rename windows automatically
set-window-option -g automatic-rename off
set-option -g allow-rename off

# https://github.com/catppuccin/tmux/discussions/401
set -g @catppuccin_window_default_text "#W"
set -g @catppuccin_window_text "#W"
set -g @catppuccin_window_current_text "#W"

# don't do anything when a 'bell' rings
set -g visual-activity off
set -g visual-bell off
set -g visual-silence off
setw -g monitor-activity off
set -g bell-action none

# The path to the plugin folder
set-environment -g TMUX_PLUGIN_MANAGER_PATH '__BUILD_PATH__/tmux-plugins'

# List of plugins
set -g @plugin 'tmux-plugins/tpm'
set -g @plugin 'tmux-plugins/tmux-resurrect'
set -g @plugin 'catppuccin/tmux#v2.1.2'

# Initialize TMUX plugin manager (keep this line at the very bottom of tmux.conf)
run '__BUILD_PATH__/tmux-plugins/tpm/tpm'


tmux-plugins-installed:
	mkdir -p ${HOME}/dotfiles/build/tmux-plugins
	$(call clone_if_not_present,\
		${HOME}/dotfiles/build/tmux-plugins/catppuccin,\
	  https://github.com/catppuccin/tmux.git, \
		-b v2.1.2)

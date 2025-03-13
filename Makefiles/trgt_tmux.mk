tmux-plugins-folder:
	mkdir -p ${HOME}/dotfiles/build/tmux-plugins

tmux-plugin-manager:
	$(call clone_if_not_present,\
		build/tmux-plugins/tpm,\
	  https://github.com/tmux-plugins/tpm)

ZSH_CUSTOM := 
zsh-installed: 
	$(call msg_is_installed?,zsh)
	$(eval ZSH_PATH := $(shell grep /zsh$$ /etc/shells | tail -1))
	@! [ -z $(ZSH_PATH) ] || ( printf "$(ERROR) Could not find zsh!\n" && exit 1 )
	$(call msg_found,$(ZSH_PATH))

omz-installed:
	$(call msg_is_installed?,oh-my-zsh)
	$(call check_if_folder_exists,${HOME}/.oh-my-zsh)
	$(call msg_found,${HOME}/.oh-my-zsh)
	$(eval ZSH_CUSTOM := ${HOME}/.oh-my-zsh/custom) 

p10k-installed:
	$(call clone_if_not_present,\
		$(ZSH_CUSTOM)/themes/powerlevel10k,\
		https://github.com/romkatv/powerlevel10k.git,\
		--depth=1)

zsh-plugins-installed:
	$(call clone_if_not_present,\
		$(ZSH_CUSTOM)/plugins/zsh-autosuggestions,\
		https://github.com/zsh-users/zsh-autosuggestions.git)

	$(call clone_if_not_present,\
		$(ZSH_CUSTOM)/plugins/zsh-syntax-highlighting,\
		https://github.com/zsh-users/zsh-syntax-highlighting.git)
	
	$(call clone_if_not_present,\
		$(ZSH_CUSTOM)/plugins/fast-syntax-highlighting,\
		https://github.com/zdharma-continuum/fast-syntax-highlighting.git)

	$(call clone_if_not_present,\
		$(ZSH_CUSTOM)/plugins/zsh-autocomplete,\
		https://github.com/marlonrichert/zsh-autocomplete.git)

	$(call clone_if_not_present,\
		$(ZSH_CUSTOM)/plugins/autoupdate,\
		https://github.com/TamCore/autoupdate-oh-my-zsh-plugins)


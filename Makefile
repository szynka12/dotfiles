.DEFAULT_GOAL := help

help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) \
	| sort \
	| awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

# -----------------------------------------------------------------------------
# 															 Variables
# -----------------------------------------------------------------------------

UPDATE := yes
MACHINE := home

# -----------------------------------------------------------------------------
# 															 Cloning the repositories
# -----------------------------------------------------------------------------

FRESHLY_CLONED := no
clone-dotfiles-pcs: ## clone pc specific configurations
	# check if folder exists and set a variable to 'yes'
	$(eval FRESHLY_CLONED := $(if $(wildcard dotfiles-pcs/.*),no,yes))
	@[ -d dotfiles-pcs ] || git clone git@github.com:szynka12/dotfiles-pcs.git 

update-dotfiles-pc: clone-dotfiles-pcs ## update dotfiles-pcs repo
	@if [ $(FRESHLY_CLONED) = no ]; then\
			cd dotfiles-pcs && git pull;\
  fi

# -----------------------------------------------------------------------------
# 																Real targets
# -----------------------------------------------------------------------------

zsh: $(if $(findstring $(UPDATE),yes),update-dotfiles-pc)  ## zsh
	m4 -D__USER__=${USER} -D__MACHINE_PATH__=$(CURDIR)/dotfiles-pcs/$(MACHINE) zshrc.m4 > .zshrc
	rm -f $(HOME)/.zshrc
	ln -s $(CURDIR)/.zshrc $(HOME)/.zshrc


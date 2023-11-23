# -----------------------------------------------------------------------------
# 									Cloning the configuration repositories
# -----------------------------------------------------------------------------
FRESHLY_CLONED := no
clone-dotfiles-pcs: make-build ## clone pc specific configurations
# check if folder exists and set a variable to 'yes'
	$(eval FRESHLY_CLONED := $(if $(wildcard $(DOTFILES_PCS_DIR)/.*),no,yes))
	@[ -d $(DOTFILES_PCS_DIR) ] || git clone $(DOTFILES_PCS_REPO) $(DOTFILES_PCS_DIR)

update-dotfiles-pc: clone-dotfiles-pcs ## update dotfiles-pcs repo
	@if [ $(FRESHLY_CLONED) = no ]; then\
			cd $(DOTFILES_PCS_DIR) && git pull;\
  fi

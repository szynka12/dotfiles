# -----------------------------------------------------------------------------
# 															 Variables
# -----------------------------------------------------------------------------
help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(firstword $(MAKEFILE_LIST)) \
	| sort \
	| awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

include config.mk


TEMPLATES := .zshrc.m4


LINKS := ${HOME}/.zshrc
LINKS += ${HOME}/.config/btop
LINKS += ${HOME}/.config/ranger



DOTFILES_PCS_DIR := $(BUILD_DIR)/dotfiles-pcs



M4_FLAGS := -D__USER__=${USER} 
M4_FLAGS += -D__MACHINE_PATH__=$(CURDIR)/$(DOTFILES_PCS_DIR)/$(MACHINE)

#
# Helper variables
#



RED := \033[0;31m
GREEN := \033[0;32m
NC := \033[0m
YELLOW := \033[33m

OK := $(GREEN)[OK]$(NC)
ERROR := $(RED)[ERROR]$(NC)
WARNING := $(YELLOW)[WARNING]$(NC)

# 
# Functions
#

define check_if_folder_exists
	@[ -d $(1) ] || ( printf "$(ERROR) Could not find $s!\n" $(1) && exit 1 )
endef

define msg_is_installed?
	@printf "Checking if %s is installed... " $(1)
endef

define msg_found
	@printf "$(OK) found %s\n" $(1)
endef

define msg_warn 
	@printf "$(WARNING) %s\n" $(1)
endef

define clone_if_not_present
	@printf "Checking if folder %s exists... " $(1)
	@if [ -d $(1) ]; then \
		printf "$(OK)\n"; \
	else \
		printf "cloning... " $(1); \
		git clone -q $(3) $(2) $(1); \
		printf "$(OK)\n"; \
	fi
endef

# -----------------------------------------------------------------------------
# 									Cloning the configuration repositories
# -----------------------------------------------------------------------------

.DEFAULT_GOAL := help


make-build: ## make build folder
	@echo "Making sure that  build directory exits ..."
	@mkdir -p $(BUILD_DIR)

FRESHLY_CLONED := no
clone-dotfiles-pcs: make-build ## clone pc specific configurations
# check if folder exists and set a variable to 'yes'
	$(eval FRESHLY_CLONED := $(if $(wildcard $(DOTFILES_PCS_DIR)/.*),no,yes))
	@[ -d $(DOTFILES_PCS_DIR) ] || git clone $(DOTFILES_PCS_REPO) $(DOTFILES_PCS_DIR)

update-dotfiles-pc: clone-dotfiles-pcs ## update dotfiles-pcs repo
	@if [ $(FRESHLY_CLONED) = no ]; then\
			cd $(DOTFILES_PCS_DIR) && git pull;\
  fi

clone-all-repos: clone-dotfiles-pcs ## clone all of the repositories

# -----------------------------------------------------------------------------
# 																Main targets
# -----------------------------------------------------------------------------

FORCE: ;

# Plugins for zsh
.zshrc.m4: FORCE ## Install prerquisits for zsh (assuming you have zsh and oh-my-zsh)
	$(call msg_is_installed?,zsh)
	$(eval ZSH_PATH := $(shell grep /zsh$$ /etc/shells | tail -1))
	@! [ -z $(ZSH_PATH) ] || ( printf "$(ERROR) Could not find zsh!\n" && exit 1 )
	$(call msg_found,$(ZSH_PATH))
	
	$(call msg_is_installed?,oh-my-zsh)
	$(call check_if_folder_exists,${HOME}/.oh-my-zsh)
	$(call msg_found,${HOME}/.oh-my-zsh)
	
	$(eval ZSH_CUSTOM := ${HOME}/.oh-my-zsh/custom)
	
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

# $(call msg_warn, "The zsh-autocomplete repo checked out at d8bfbef" )
# $(call msg_warn, "Related issues:" )
# $(call msg_warn, "  https://github.com/marlonrichert/zsh-autocomplete/issues/483" )
# $(call msg_warn, "  https://github.com/marlonrichert/zsh-autocomplete/issues/468" )

# (cd  $(ZSH_CUSTOM)/plugins/zsh-autocomplete && git checkout d8bfbef)

$(BUILD_DIR)/%.proc: %.m4 $(if $(findstring $(UPDATE),yes),update-dotfiles-pc) FORCE
	m4 $(M4_FLAGS) $< > $@

$(LINKS): FORCE
	rm -rf $@
	$(eval FILE := $(CURDIR)/$(subst ${HOME}/,,$@))
	$(eval GENERATED := $(CURDIR)/$(BUILD_DIR)/$(subst ${HOME}/,,$@).proc)
	ln -s $(if $(wildcard $(FILE)),$(FILE),$(GENERATED)) $@

GENERATED_FILES := $(addprefix $(BUILD_DIR)/,$(patsubst %.m4,%.proc,$(TEMPLATES)))

all: $(GENERATED_FILES) $(LINKS) ## rebuild all configs


#
# Helper variables
#
NC := \033[0m
RED := \033[0;31m
GREEN := \033[0;32m
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

define soft_check_if_installed
	[ $$(command -v $(1)) ] || ( printf "$(WARNING) Could not find %s!\n" $(1) );
endef

define check_if_installed
	[ $$(command -v $(1)) ] || ( printf "$(ERROR) Could not find ranger!\n" && exit 1 );
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

define update_submodule
	@printf "Updating %s... " $(1);
	@cd $(1) && git pull -q && cd -;
endef


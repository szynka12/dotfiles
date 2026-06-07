make-build: ## make build folder
	@mkdir -p $(BUILD_DIR)

m4-installed:
	$(call msg_is_installed?, m4)
	$(eval M4_PATH := $(shell which m4) )
	@ [ -f $(M4_PATH) ] || ( printf "$(ERROR) Could not find m4! $(M4_PATH)\n\n" && exit 1 )
	$(call msg_found,$(M4_PATH))


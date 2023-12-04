
ranger-installed:
	$(call msg_is_installed?,ranger)
	$(call check_if_installed,ranger)

	$(eval RANGER_PATH := $(shell command -v ranger))
	$(call msg_found,$(RANGER_PATH))


ranger-preqs:
	$(call soft_check_if_installed,pbzip2)

ranger-plugins-installed: ranger-preqs
	$(call update_submodule,.config/ranger/plugins/ranger-archives)
	



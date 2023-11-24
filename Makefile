include Makefiles/trgt_help.mk
include Makefiles/functions.mk

include config.mk
DOTFILES_PCS_DIR := $(BUILD_DIR)/dotfiles-pcs
M4_FLAGS := -D__USER__=${USER} 
M4_FLAGS += -D__MACHINE_PATH__=$(CURDIR)/$(DOTFILES_PCS_DIR)/$(MACHINE)
include Makefiles/trgt_prerequisites.mk
include Makefiles/trgt_dotfiles_pcs.mk



	

$(BUILD_DIR)/%.proc: %.m4 $(if $(findstring $(UPDATE),yes),update-dotfiles-pc) make-build 
	m4 $(M4_FLAGS) $< > $@


${HOME}/%: $(CURDIR)/%
	rm -rf $@
	ln -s $< $@

${HOME}/%: $(BUILD_DIR)/%.proc
	rm -rf $@
	ln -s $< $@

include Makefiles/trgt_zshrc.mk
zshrc: zsh-installed omz-installed p10k-installed zsh-plugins-installed ${HOME}/.p10k.zsh ${HOME}/.zshrc  ## zshrc (checks for shell, clones plugins)

ranger: ${HOME}/.config/ranger ## ranger configs

btop: ${HOME}/.config/btop ## btop config

lvim: ${HOME}/.config/lvim/config.lua ## lunarvim config

all:  zshrc ranger btop lvim 


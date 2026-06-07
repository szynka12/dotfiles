include Makefiles/trgt_help.mk
include Makefiles/functions.mk

include config.mk
DOTFILES_PCS_DIR := $(BUILD_DIR)/dotfiles-pcs
M4_FLAGS := -D__USER__=${USER} 
M4_FLAGS += -D__MACHINE_PATH__=$(CURDIR)/$(DOTFILES_PCS_DIR)/$(MACHINE)
M4_FLAGS += -D__SRC_PATH__=$(CURDIR)/src
M4_FLAGS += -D__BUILD_PATH__=$(CURDIR)/build
M4_FLAGS += -D__PROMPT__=$(PROMPT)
include Makefiles/trgt_prerequisites.mk
include Makefiles/trgt_dotfiles_pcs.mk

.SECONDARY:

$(BUILD_DIR)/%.proc: %.m4 $(if $(findstring $(UPDATE),yes),update-dotfiles-pc) make-build m4-installed
	m4 $(M4_FLAGS) $< > $@

${HOME}/%: $(CURDIR)/%
	rm -rf $@
	ln -s $< $@

${HOME}/%: $(BUILD_DIR)/%.proc
	rm -rf $@
	ln -s $(CURDIR)/$< $@

# shell -----------------------------------------------

include Makefiles/trgt_zshrc.mk
zshrc: zsh-installed omz-installed p10k-installed zsh-plugins-installed \
	${HOME}/.p10k.zsh ${HOME}/.zshrc update-dotfiles-pc ## zshrc (checks for shell, clones plugins)

# editors -------------------------------------------

lv: ${HOME}/.config/nvim ## lazyvim config

doom-emacs: ${HOME}/.config/doom ## Doom emacs config

# Terminal ------------------

ghostty: ${HOME}/.config/ghostty ## ghostty

eza: ${HOME}/.config/eza ## eza configuration (ls replacement)

include Makefiles/trgt_tmux.mk
tmux: tmux-plugins-folder tmux-plugin-manager ${HOME}/.tmux.conf ## tmux configuration  

rclone: ${HOME}/.config/rclone ## rclone config

zathura: ${HOME}/.config/zathura ## zathura configuration

all:  zshrc ghostty eza tmux rclone zathura


# old --------------

include Makefiles/trgt_ranger.mk

# lvim: ${HOME}/.config/lvim/config.lua ## lunarvim config

ranger: ranger-installed ranger-plugins-installed ${HOME}/.config/ranger ## (old) ranger
kitty: ${HOME}/.config/kitty ## (old) kitty
alacritty: ${HOME}/.config/alacritty ## (old) alacritty
i3: ${HOME}/.config/i3 ${HOME}/.config/i3status ## (old) i3 
picom: ${HOME}/.config/picom ## (old) picom configuration

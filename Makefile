.DEFAULT_GOAL := help

help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) \
	| sort \
	| awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

zshrc.m4: ## prepare the zshrc file with macros
	m4 -D__USER__=${USER} zshrc.m4 > test

zsh: ## zsh
	m4 -D__USER__=${USER} zshrc.m4 > .zshrc
	ln -s $(CURDIR)/.zshrc $(HOME)/.zshrc


SHELL := bash

.PHONY: all
all: dotfiles ## Installs all sections listed here

.PHONY: dotfiles
dotfiles: ## Installs the dotfiles.
	# add aliases for dotfiles
	for file in $(shell find $(CURDIR) -name ".*" -not -name ".gitignore" -not -name ".git" -not -name ".config" -not -name ".github" -not -name ".*.swp" -not -name ".gnupg"); do \
		f=$$(basename $$file); \
		ln -sfn $$file $(HOME)/$$f; \
	done; \
	# Create the gitignore file
	ln -fn $(CURDIR)/gitignore $(HOME)/.gitignore;
	git update-index --skip-worktree $(CURDIR)/.gitconfig;
	# Prep the .config directory, used below
	mkdir -p $(HOME)/.config;
	mkdir -p $(HOME)/.local/share;
	# Create the Pictures directory, wallpapers, etc.
	mkdir -p $(HOME)/Pictures;
	# Bring in fonts I care about
	ln -snf $(CURDIR)/.fonts $(HOME)/.local/share/fonts;
	mkdir -p $(HOME)/.config/fontconfig;
	ln -snf $(CURDIR)/.config/fontconfig/fontconfig.conf $(HOME)/.config/fontconfig/fontconfig.conf;
	fc-cache -f -v || true

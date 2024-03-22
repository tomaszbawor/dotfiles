#!/bin/bash

SOURCE_ZSHRC="$(pwd)/zshrc-config"
TARGET_ZSHRC="$HOME/.zshrc"

# Check if the target file already exists
if [ -f "$TARGET_ZSHRC" ]; then
	# Backup the existing .zshrc file
	echo "Backing up existing .zshrc to .zshrc.backup"
	mv "$TARGET_ZSHRC" "${TARGET_ZSHRC}.backup"
fi

# Create a symbolic link from the source to the target
echo "Linking $SOURCE_ZSHRC to $TARGET_ZSHRC"
ln -s -f "$SOURCE_ZSHRC" "$TARGET_ZSHRC"
ln -s -f "$(pwd)/.aliases" "$HOME/.aliases"
ln -s -f "$(pwd)/.fzf.zsh" "$HOME/.fzf.zsh"

echo "Done."

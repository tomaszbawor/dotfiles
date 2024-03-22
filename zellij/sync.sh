#!/usr/bin/env bash

echo "Linking config from dotfiles"
rm -rf ~/.config/zellij
ln -s $(pwd) ~/.config/zellij

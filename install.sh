#!/usr/bin/env bash

set -e

DOTFILES="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

backup() {
    if [ -e "$1" ] || [ -L "$1" ]; then
        mv "$1" "$1.backup.$(date +%Y%m%d_%H%M%S)"
        echo "Backup created: $1"
    fi
}

link_file() {
    local source="$1"
    local target="$2"

    mkdir -p "$(dirname "$target")"

    if [ -L "$target" ] && [ "$(readlink "$target")" = "$source" ]; then
        echo "Already linked: $target"
        return
    fi

    backup "$target"

    ln -s "$source" "$target"
    echo "Linked: $target -> $source"
}


echo "Installing dotfiles from:"
echo "$DOTFILES"
echo

# Bash
link_file \
    "$DOTFILES/.bashrc" \
    "$HOME/.bashrc"

link_file \
    "$DOTFILES/.bashrc.d" \
    "$HOME/.bashrc.d"


# Kitty
link_file \
    "$DOTFILES/.config/kitty" \
    "$HOME/.config/kitty"


echo
echo "Done!"

#!/bin/bash

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

mkdir -p ~/.config/nvim

ALIASES_FILE="$DOTFILES_DIR/aliases"

SOURCE_LINE="[ -f $ALIASES_FILE ] && source $ALIASES_FILE"

add_source_line() {
    local file=$1
    
    # Only proceed if file exists
    if [ ! -f "$file" ]; then
        echo "Skipping $file (does not exist)"
        return
    fi
    
    # Check if the source line already exists
    if grep -qF "$ALIASES_FILE" "$file"; then
        echo "Source line already exists in $file"
    else
        echo "" >> "$file"
        echo "# Source shared aliases" >> "$file"
        echo "$SOURCE_LINE" >> "$file"
        echo "Added source line to $file"
    fi
}

add_source_line "$HOME/.bashrc"
add_source_line "$HOME/.zshrc"

## SETUP VIM

cd vim && brew bundle && cd -


## SETUP TMUX

cd tmux && brew bundle && cd -

ln -sf "$DOTFILES_DIR/vim/vimrc" ~/.vimrc
ln -sf "$DOTFILES_DIR/vim/init.vim" ~/.config/nvim/init.vim

ln -sf "$DOTFILES_DIR/tmux/tmux.conf" ~/.tmux.conf
# Link individual tmuxinator files
mkdir -p ~/.config/tmuxinator
for config in "$DOTFILES_DIR/tmux/tmuxinator"/*.yml; do
    if [ -f "$config" ]; then
        filename=$(basename "$config")
        ln -sf "$config" ~/.config/tmuxinator/"$filename"
        echo "Linked tmuxinator config: $filename"
    fi
done

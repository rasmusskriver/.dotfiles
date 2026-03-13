#!/usr/bin/env bash

DOTFILES="$HOME/.dotfiles"

echo "Installing dotfiles..."

# Generel funktion til at kopiere filer og mapper med tjek og backup
copy_item() {
    local src="$1"
    local dest="$2"

    if [ -e "$dest" ]; then
        echo "$dest exists. Do you want to overwrite it? (y/n)"
        read -r answer
        if [[ "$answer" =~ ^[Yy]$ ]]; then
            # Lav backup
            mv "$dest" "${dest}.bak"
            echo "Backup created at ${dest}.bak"
            # Kopier fil eller mappe afhængigt af typen
            if [ -d "$src" ]; then
                cp -r "$src" "$dest"
            else
                cp "$src" "$dest"
            fi
            echo "$dest overwritten."
        else
            echo "Skipped $dest"
        fi
    else
        # Kopier fil eller mappe afhængigt af typen
        if [ -d "$src" ]; then
            cp -r "$src" "$dest"
        else
            cp "$src" "$dest"
        fi
        echo "$dest installed."
    fi
}

# Liste over standard dotfiles
FILES=(".alacritty.toml" ".tmux.conf" ".zshrc" ".bashrc")
for file in "${FILES[@]}"; do
    copy_item "$DOTFILES/$file" "$HOME/$file"
done

# Kopier scripts-mappen
copy_item "$DOTFILES/scripts" "$HOME/.local/scripts"

# Klon nvim repo
copy_item "$DOTFILES/nvim" "$HOME/.config/nvim"

# Kopier hyprland.conf til ~/.config/hypr/
HYPR_CONFIG_DIR="$HOME/.config/hypr"
copy_item "$DOTFILES/hyprland.conf" "$HYPR_CONFIG_DIR/hyprland.conf"

echo "Done!"

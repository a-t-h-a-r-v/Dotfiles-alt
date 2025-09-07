for dir in autotiling fish kitty nvim rofi sway swaylock waybar zathura; do ln -sfv "$(pwd)/$dir" "$HOME/.config/$dir"; done
for item in .calibre_themes Scripts; do ln -sfv "$(pwd)/$item" "$HOME/$item"; done

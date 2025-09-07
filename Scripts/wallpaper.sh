#!/bin/bash

# -----------------------------------------------------------------------------
# A script to select and set a wallpaper with image previews for Sway.
# Dependencies: rofi, sway
# -----------------------------------------------------------------------------

# --- CONFIGURATION ---
WALLPAPER_DIR="/home/atharv/Pictures/catppuccin-wallpapers/"
SWAY_CONFIG="$HOME/.config/sway/config"
SWAYLOCK_CONFIG="$HOME/.config/swaylock/config"
# Path to the Rofi theme file we just created
ROFI_THEME="$HOME/.config/rofi/wallpaper.rasi"

# --- SCRIPT LOGIC ---

# Check for dependencies and necessary files
if ! command -v rofi &> /dev/null || ! command -v swaymsg &> /dev/null; then
    echo "Error: This script requires 'rofi' and 'swaymsg' (from Sway)." >&2
    exit 1
fi
if [ ! -f "$ROFI_THEME" ]; then
    echo "Error: Rofi theme '$ROFI_THEME' not found." >&2
    exit 1
fi

# Generate a list of wallpapers with thumbnail paths for rofi
# The `echo` command uses a special format: "TEXT\0icon\x1f/path/to/icon.png"
# This tells rofi to display "TEXT" but use the path after "\x1f" as its icon.
# We display the filename relative to the wallpaper dir for a cleaner look.
selected_relative_path=$(find "$WALLPAPER_DIR" -type f \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" -o -iname "*.gif" \) |
    sort |
    while read -r FNAME; do
        # Get the path relative to WALLPAPER_DIR
        RELATIVE_PATH="${FNAME#$WALLPAPER_DIR}"
        echo -en "$RELATIVE_PATH\0icon\x1f$FNAME\n"
    done | rofi -dmenu -i -p "🖼️ Select Wallpaper" -show-icons -theme "$ROFI_THEME")

# Exit if no wallpaper was selected.
if [ -z "$selected_relative_path" ]; then
    exit 0
fi

# Reconstruct the full path from the selected relative path
selected_wallpaper="${WALLPAPER_DIR}${selected_relative_path}"

# --- SET WALLPAPER ---

# 1. Set the wallpaper for the current session using swaymsg.
swaymsg "output * bg '$selected_wallpaper' fill"

# 2. Make the change persistent by editing the Sway config file.
sed -i "s|^output \* bg.*|output * bg \"$selected_wallpaper\" fill|" "$SWAY_CONFIG"
#
# 3. Make the lockscreen wallpaper persistent by editing the swaylock config.
sed -i "s|^image=.*|image=$selected_wallpaper|" "$SWAYLOCK_CONFIG"

# Optional: Send a notification.
if command -v notify-send &> /dev/null; then
    notify-send "Wallpaper Changed" "Set to $(basename "$selected_wallpaper")" -i "$selected_wallpaper"
fi

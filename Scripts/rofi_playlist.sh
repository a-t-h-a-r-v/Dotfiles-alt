#!/bin/bash

# Define the directory where your playlists are stored
PLAYLIST_DIR="/home/atharv/Videos/Playlists"

# Use find to list all M3U files, then use sed to remove the directory and extension.
# The list is then piped to Rofi for selection.
find "$PLAYLIST_DIR" -maxdepth 1 -type f -name "*.m3u" | \
    sed "s|^$PLAYLIST_DIR/||; s|\.m3u$||" | \
    rofi -dmenu -i -p "Playlists" | \
    xargs -I{} celluloid "$PLAYLIST_DIR/{}.m3u"

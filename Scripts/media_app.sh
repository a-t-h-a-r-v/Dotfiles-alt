#!/bin/sh
#
# A script to launch or focus web apps using rofi and sway.
#
# This script presents a rofi menu with a list of web apps.
# When an app is selected, it first tries to focus the app's window.
# If the window doesn't exist, it launches the app in Brave.
# Finally, it switches to the designated workspace for that app.

# Define the menu options, separated by newlines
options="SonyLIV\nYouTube\nHotstar\nZEE5"

# Show the rofi menu and capture the user's choice.
# -dmenu: Run in dmenu mode (read from stdin)
# -i: Enable case-insensitive matching
# -p: Set the prompt text
chosen=$(echo -e "$options" | rofi -dmenu -i -p "Select Web App")

# Act based on the user's choice
case "$chosen" in
    "SonyLIV")
        # Command to focus or launch SonyLIV and then switch to workspace 6
        swaymsg "exec sh -c \"swaymsg -q '[instance=\\\"^sonyliv\\\\.com$\\\"] focus' || brave-browser --app=https://sonyliv.com\"; workspace number 6"
        ;;
    "YouTube")
        # Command to focus or launch YouTube and then switch to workspace 7
        swaymsg "exec sh -c \"swaymsg -q '[instance=\\\"^youtube\\\\.com$\\\"] focus' || brave-browser --app=https://youtube.com\"; workspace number 7"
        ;;
    "Hotstar")
        # Command to focus or launch Hotstar and then switch to workspace 8
        # NOTE: Using 'www.hotstar.com' to match your 'for_window' rule.
        swaymsg "exec sh -c \"swaymsg -q '[instance=\\\"^www\\\\.hotstar\\\\.com$\\\"] focus' || brave-browser --app=https://www.hotstar.com\"; workspace number 8"
        ;;
    "ZEE5")
        # Command to focus or launch ZEE5 and then switch to workspace 9
        swaymsg "exec sh -c \"swaymsg -q '[instance=\\\"^zee5\\\\.com$\\\"] focus' || brave-browser --app=https://www.zee5.com\"; workspace number 9"
        ;;
esac

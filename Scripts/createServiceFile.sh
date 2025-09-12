#!/bin/bash

# --- Simple Rclone User Service Generator ---

# Color codes for output
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

echo -e "${GREEN}--- Rclone User Service Generator ---${NC}"
echo "This script will help you create a systemd service to run as your current user."
echo

# --- Gather User Input ---
read -p "Enter a name for your service file (e.g., rclone-gdrive.service): " SERVICE_NAME
read -p "Enter your rclone remote name (e.g., 'gdrive'): " REMOTE_NAME
read -p "Enter the path on the remote to mount (leave blank for root): " REMOTE_PATH
read -p "Enter the absolute local mount point (e.g., /home/user/gdrive): " MOUNT_POINT
read -p "Make the mount read-only? (y/n) [n]: " READ_ONLY_CHOICE

# --- Set Read-Only Flag ---
RCLONE_READ_ONLY_FLAG=""
if [[ "$READ_ONLY_CHOICE" == "y" || "$READ_ONLY_CHOICE" == "Y" ]]; then
    RCLONE_READ_ONLY_FLAG="--read-only \\"
fi

# --- Generate the Service File Content ---
# This template is specifically for a user service.
# It does NOT include User, Group, or --allow-other.
SERVICE_CONTENT=$(cat <<EOL
[Unit]
Description=Rclone Mount for ${REMOTE_NAME}
After=network-online.target

[Service]
Type=simple
ExecStartPre=/bin/mkdir -p "${MOUNT_POINT}"
ExecStart=/usr/bin/rclone mount \\
    "${REMOTE_NAME}:${REMOTE_PATH}" \\
    "${MOUNT_POINT}" \\
    ${RCLONE_READ_ONLY_FLAG}
    --vfs-cache-mode minimal \\
    --dir-cache-time 5s \\
    --config "/home/$(whoami)/.config/rclone/rclone.conf"
ExecStop=/bin/fusermount -u "${MOUNT_POINT}"
Restart=on-failure
RestartSec=5

[Install]
WantedBy=default.target
EOL
)

# --- Write the file ---
echo "${SERVICE_CONTENT}" > ./${SERVICE_NAME}

# --- Set Final Instructions ---
INSTRUCTIONS=$(cat <<EOL
1. Create the user systemd directory if it doesn't exist:
   ${GREEN}mkdir -p ~/.config/systemd/user/${NC}

2. Move the generated file to the user systemd directory:
   ${GREEN}mv ./"${SERVICE_NAME}" ~/.config/systemd/user/"${SERVICE_NAME}"${NC}

3. Reload the systemd user daemon:
   ${GREEN}systemctl --user daemon-reload${NC}

4. Enable the service to start when you log in:
   ${GREEN}systemctl --user enable ${SERVICE_NAME}${NC}

5. Start the service now:
   ${GREEN}systemctl --user start ${SERVICE_NAME}${NC}

6. Check its status:
   ${GREEN}systemctl --user status ${SERVICE_NAME}${NC}
EOL
)

# --- Show Final Instructions ---
echo
echo -e "${GREEN}Success! ✨ Your user service file '${SERVICE_NAME}' has been created.${NC}"
echo
echo -e "${YELLOW}--- Next Steps ---${NC}"
echo -e "${INSTRUCTIONS}"

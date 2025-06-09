#!/bin/bash

# Exit immediately if a command exits with a non-zero status.
set -e

# --- Configuration ---
# Replace with your actual server details and paths
REMOTE_USER="your_ssh_user"
REMOTE_HOST="your_server_ip_or_hostname"
REMOTE_TARGET_DIR="/var/www/phi-browser-landing" # Target directory on the server
DEPLOY_TAG_PATTERN="^deploy-v[0-9]+\.[0-9]+\.[0-9]+$" # e.g., deploy-v1.0.0

# --- Helper Functions ---
log_message() {
  echo "[DEPLOY_SCRIPT] $1"
}

# --- Main Deployment Logic ---
log_message "Starting deployment script..."

# 1. Check if the current commit is tagged with a deploy tag
GIT_TAG=$(git describe --tags --exact-match 2>/dev/null || echo "")

if [[ ! "$GIT_TAG" =~ $DEPLOY_TAG_PATTERN ]]; then
  log_message "Current commit is not tagged with a valid deployment tag (e.g., deploy-vX.Y.Z)."
  log_message "Git tag found: '$GIT_TAG'. Expected pattern: '$DEPLOY_TAG_PATTERN'."
  log_message "Skipping deployment."
  exit 0
fi

log_message "Valid deployment tag '$GIT_TAG' found. Proceeding with deployment."

# 2. (Placeholder) Build steps - e.g., minifying assets
# log_message "Running build steps..."
# npm run build # Example if you had a build process

# 3. (Placeholder) Test steps - e.g., linting, HTML validation
# log_message "Running tests..."
# npm test # Example if you had a test process

# 4. Deploy files to server using rsync (more efficient than scp for multiple files)
log_message "Deploying files to $REMOTE_USER@$REMOTE_HOST:$REMOTE_TARGET_DIR..."

# Ensure target directory exists on remote (optional, rsync can create it)
ssh "$REMOTE_USER@$REMOTE_HOST" "mkdir -p $REMOTE_TARGET_DIR"

# rsync files:
# -avz: archive mode, verbose, compress
# --delete: delete files on the destination that don't exist on the source
# Exclude .git directory and this script itself
rsync -avz --delete   --exclude='.git*'   --exclude='deploy.sh'   --exclude='README.md'   . "$REMOTE_USER@$REMOTE_HOST:$REMOTE_TARGET_DIR/"

log_message "Deployment successful!"
exit 0

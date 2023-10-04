#!/bin/bash

set -x  # Print each command before executing it
set -e  # Exit if any command fails

# Check if GIT_URL is provided
if [ -z "$GIT_REPO_URL" ]; then
    echo "GIT_REPO_URL environment variable not set."
    exit 1
fi

# Clone the repository into /home/workspace
git clone $GIT_REPO_URL /home/workspace

# Navigate to the Theia directory
cd /home/theia

# Start Theia IDE with /home/workspace as the project directory
node /home/theia/src-gen/backend/main.js /home/workspace --hostname=0.0.0.0
#yarn start /home/workspace --hostname=0.0.0.0

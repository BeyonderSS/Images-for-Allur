#!/bin/bash

set -e

echo "==== Updating system ===="
sudo apt update && sudo apt upgrade -y

echo "==== Installing prerequisites ===="
sudo apt install -y curl wget git software-properties-common apt-transport-https ca-certificates gnupg lsb-release gnome-terminal

# NVM + Node.js latest
echo "==== Installing NVM ===="
export NVM_DIR="$HOME/.nvm"
if [ ! -d "$NVM_DIR" ]; then
  curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash
fi

# Load NVM
export NVM_DIR="$HOME/.nvm"
source "$NVM_DIR/nvm.sh"

echo "==== Installing latest Node.js ===="
nvm install node
nvm use node

# Yarn (global via npm)
echo "==== Installing Yarn globally via npm ===="
npm install -g yarn

# Terminator
echo "==== Installing Terminator ===="
sudo apt install -y terminator

# GitHub CLI + Git
echo "==== Installing GitHub CLI ===="
type -p curl >/dev/null || sudo apt install -y curl
curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg
sudo chmod go+r /usr/share/keyrings/githubcli-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null
sudo apt update
sudo apt install -y gh git

# GitHub setup prompts
echo "==== GitHub setup ===="
echo -n "Enter your Git username: "
read GIT_USERNAME
git config --global user.name "$GIT_USERNAME"

echo -n "Enter your Git email: "
read GIT_EMAIL
git config --global user.email "$GIT_EMAIL"

echo "GitHub user.name set to: $GIT_USERNAME"
echo "GitHub user.email set to: $GIT_EMAIL"

echo "==== All tools installed successfully! ===="
echo "You may now run 'gh auth login' to authenticate with GitHub CLI."

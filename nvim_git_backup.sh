#!/bin/bash

set -e

# Navigate to your Neovim config directory
cd ~/.config/nvim || { echo "Error: ~/.config/nvim directory not found"; exit 1; }

# Initialize a git repository if not already initialized
if [ ! -d .git ]; then
    git init
    echo "Git repository initialized."
else
    echo "Git repository already exists."
fi

# Create a .gitignore file if it doesn't exist
if [ ! -f .gitignore ]; then
    echo "plugin/packer_compiled.lua" > .gitignore
    echo ".gitignore file created."
else
    echo ".gitignore file already exists."
fi

# Add all files
git add .

# Commit the files if there are changes
if git diff --staged --quiet; then
    echo "No changes to commit."
else
    git commit -m "Update Neovim configuration"
    echo "Changes committed."
fi

# Get the current branch name
current_branch=$(git rev-parse --abbrev-ref HEAD)

# Prompt for GitHub username and repository name
read -p "Enter your GitHub username: " github_username
read -p "Enter the name for your GitHub repository: " repo_name

# Create a new repository on GitHub (requires GitHub CLI)
if ! gh repo view "$github_username/$repo_name" &>/dev/null; then
    gh repo create "$repo_name" --public
    echo "Created repository $github_username/$repo_name on GitHub."
else
    echo "Repository $github_username/$repo_name already exists on GitHub."
fi

# Add the remote repository if not already added
if ! git remote | grep -q '^origin$'; then
    git remote add origin "https://github.com/$github_username/$repo_name.git"
    echo "Added remote origin."
else
    echo "Remote origin already exists."
fi

# Push to GitHub
git push -u origin "$current_branch"

echo "Your Neovim configuration has been pushed to GitHub!"

#!/bin/bash

set -e

cd ~/.config/nvim || { echo "Error: ~/.config/nvim directory not found"; exit 1; }

if [ ! -d .git ]; then
    git init
    echo "Git repository initialized."
else
    echo "Git repository already exists."
fi

if [ ! -f .gitignore ]; then
    echo "plugin/packer_compiled.lua" > .gitignore
    echo ".gitignore file created."
else
    echo ".gitignore file already exists."
fi

git add .

if git diff --staged --quiet; then
    echo "No changes to commit."
else
    git commit -m "Update Neovim configuration"
    echo "Changes committed."
fi

current_branch=$(git rev-parse --abbrev-ref HEAD)

read -p "Enter your GitHub username: " github_username
read -p "Enter the name for your GitHub repository: " repo_name

if ! gh repo view "$github_username/$repo_name" &>/dev/null; then
    gh repo create "$repo_name" --public
    echo "Created repository $github_username/$repo_name on GitHub."
else
    echo "Repository $github_username/$repo_name already exists on GitHub."
fi

if ! git remote | grep -q '^origin$'; then
    git remote add origin "https://github.com/$github_username/$repo_name.git"
    echo "Added remote origin."
else
    echo "Remote origin already exists."
fi

git push --force -u origin "$current_branch"

echo "Your Neovim configuration has been pushed to GitHub!"

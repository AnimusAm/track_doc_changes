#!/bin/bash

# Check if correct number of arguments are passed
if [ "$#" -ne 2 ]; then
    echo "Usage: $0 <repository-url> <path-to-submodule>"
    exit 1
fi

# Arguments
repo_url=$1 # https://github.com/microsoft/markitdown.git 
submodule_path=$2 #./documentation/doc2md/manage/submodule/markitdown


# Step 1: Check if the submodule already exists
if [ ! -d "$submodule_path" ] || [ -z "$(ls -A "$submodule_path")" ]; then
    echo "Submodule already exists at $submodule_path. Skipping submodule addition."
else
    # Add the submodule if it doesn't exist
    echo "Adding submodule from $repo_url into $submodule_path"
    git submodule add "$repo_url" "$submodule_path"
    # Initialize the submodule
    echo "Initializing submodule..."
    git submodule update --init --recursive
    # Commit the submodule addition
    echo "Committing changes..."
    git add .gitmodules "$submodule_path"
    git commit -m "Added submodule: $submodule_path"
fi

# Step 2: Pull the latest changes for the submodule
echo "Pulling latest changes for the submodule..."
git submodule update --remote 
git pull --recurse-submodules


echo "Detaching checkout from submodule..."
this_path=$PWD
cd "$submodule_path"
echo "Moving to: $PWD"
echo "Detaching checkout ..."
git checkout --detach
cd "$this_path"
echo "Moving to: $PWD"

# Final Message
echo "Submodule setup and update complete. The submodule has been added/updated."

echo "Untracking remote to prevent accidental pushes"
git branch --unset-upstream

# manage gitignore file => add whole submodule content into git ignore
this_path=$PWD
cd "$submodule_path"
echo "Moving to: $PWD"
cd ..
echo "Moving to: $PWD"
current_folder=$PWD
cd "$this_path"
echo "Moving to: $PWD"


gitignore_dest="$current_folder/.gitignore"

to_ignore="*\n!.gitignore" 

# Check if the .gitignore file exists, if not create it
if [ ! -f .gitignore ]; then
    echo ".gitignore file does not exist. Creating it..."
    touch $gitignore_dest
fi

# Check if specifics are already in the .gitignore
if grep -Pzo "(?s)((\*)|(\!\.gitignore))" "$gitignore_dest" > /dev/null; then  
    echo "'$to_ignore' is already in .gitignore."

else
    # Add to .gitignore
    printf "\n\n$to_ignore\n" >> $gitignore_dest
    echo "Added '$to_ignore' to '$gitignore_dest'"
fi

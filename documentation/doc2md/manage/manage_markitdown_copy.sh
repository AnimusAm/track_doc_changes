#!/bin/bash

# Check if correct number of arguments are passed
if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <repository-url>"
    exit 1
fi

# Arguments
repo_url=$1 # https://github.com/microsoft/markitdown.git 
#submodule_path="$PWD/documentation/doc2md/manage/submodule/markitdown"

submodule_path="./markitdown"



# Step 1: Check if the submodule already exists
if [ -d "$submodule_path" ] ; then
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




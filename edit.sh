#!/bin/bash

pushd "$HOME/.config/nvim"

nvim .

echo "Starting Neovim Again!"

nvim .

git add -i 

git commit

popd



#!/bin/bash
FILE_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source $FILE_DIR/../helpers/install_dmg.sh

dmg=(
  # "https://desktop.docker.com/mac/stable/amd64/Docker.dmg"
  "https://github.com/leoafarias/sidekick/releases/download/0.1.1/sidekick-macos-0.1.1.dmg"
)

for downloadUrl in "${dmg[@]}"
do
   echo ""
   echo "--------------------------------------------------------------"
   echo "Downloading ${downloadUrl}..."
   echo ""
   install_dmg $downloadUrl
done

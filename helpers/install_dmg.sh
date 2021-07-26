# Referenced from https://github.com/TheJumpCloud/support/blob/master/PowerShell/JumpCloud%20Commands%20Gallery/Mac%20Commands/Application%20Installs/Mac%20-%20Install%20Chrome%20DMG.md
function install_dmg() {
  local DownloadUrl=$1
  
  # Create & navigate to temp folder
  local DATE=$(date '+%Y-%m-%d-%H-%M-%S')
  local TempFolder="Download-$DATE"
  mkdir /tmp/$TempFolder
  cd /tmp/$TempFolder

  # Download File into Temp Folder, allow redirects
  curl -L -O "$DownloadUrl"

  # Capture name of Download File
  local DownloadFile="$(ls)"

  # Verify DMG File
  local regex='\.dmg$'
  if [[ $DownloadFile =~ $regex ]]; then
      local DMGFile="$(echo "$DownloadFile")"
  else
      echo "File: $DownloadFile is not a DMG"
      rm -r /tmp/$TempFolder
      return 1
  fi

  # Mount DMG File -nobrowse prevents the volume from popping up in Finder
  echo "Mounting $DMGFile"
  local hdiutilAttach=$(hdiutil attach /tmp/$TempFolder/$DMGFile -nobrowse)

  local err=$?
  if [ ${err} -ne 0 ]; then
      echo "Could not mount $DMGFile Error: ${err}"
      rm -r /tmp/$TempFolder
      echo "Deleted /tmp/$TempFolder"
      return 1
  fi

  local regex='\/Volumes\/.*'
  if [[ $hdiutilAttach =~ $regex ]]; then
      local DMGVolume="${BASH_REMATCH[@]}"
  else
      echo "DMG Volume not found"
      rm -r /tmp/$TempFolder
      return 1
  fi

  # Identify the mount point for the DMG file
  local DMGMountPoint="$(hdiutil info | grep "$DMGVolume" | awk '{ print $1 }')"
  cd "$DMGVolume"
  local AppName="$(ls | Grep .app)"
  cd ~

  local ExistingSearch=$(find "/Applications/" -name "$AppName" -maxdepth 1)

  if [ -n "$ExistingSearch" ]; then
      echo "$AppName already exists in /Applications... skipping!"
      hdiutil detach -quiet $DMGMountPoint
      rm -r /tmp/$TempFolder
      return 1
  fi

  echo "Copying $AppName into /Applications folder"
  local DMGAppPath=$(find "$DMGVolume" -name "*.app" -maxdepth 1)
  cp -pPR "$DMGAppPath" /Applications/

  err=$?
  if [ ${err} -ne 0 ]; then
      echo "Could not copy $DMGAppPath Error: ${err}"
      hdiutil detach -quiet $DMGMountPoint
      echo "Used hdiutil to detach $DMGFile from $DMGMountPoint"
      rm -r /tmp/$TempFolder
      echo "Deleted /tmp/$TempFolder"
      return 1
  fi

  echo "Done installing ${DMGAppPath}!"

  # Unmount the DMG file
  hdiutil detach -quiet $DMGMountPoint
  rm -r /tmp/$TempFolder
}

# Install Homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
brew update
brew upgrade

# add any required taps
taps=(
    leoafarias/fvm
    dart-lang/dart
    adoptopenjdk/openjdk
)
brew tap "${taps[@]}"

# Install packages
apps=(
    wget
    nano
    git-lfs
    fvm
    nvm
    openjdk
    firebase-cli
)
brew install "${apps[@]}"

# Install casks
casks=(
    rectangle
    iterm2
    caffeine
    jetbrains-toolbox
    visual-studio-code
    slack
    whatsapp
    telegram
    signal
    firefox
    google-chrome
    microsoft-edge
    postman
    vlc
    adoptopenjdk8
    adoptopenjdk11
    adoptopenjdk13
    robo-3t
)
brew install --cask "${casks[@]}"
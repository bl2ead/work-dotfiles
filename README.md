# What is this for?
This repository provides an installation script that helps you get your mac setup with basic development tools. This is largely achieved with [`brew`](https://brew.sh/), also known as *The Missing Package Manager for macOS (or Linux)*.

# Setting up this dotfiles
OSX bundles some dev tools along with Xcode, such as `git`... So before you clone this repository, you will need to do the following:
  1. install [Xcode] through **either** of the 2 methods:
     - from the [App Store](https://apps.apple.com/sg/app/xcode/id497799835?mt=12). This is more convenient but is notorious for being horribly slow, especially if it coincides with a new Xcode version release.
     - from the [Apple Developer Portal](https://developer.apple.com/download/release/). Under the `More` tab on the top-right corner, search for and download the latest Xcode release `.xip` file. You will have to extract this to the `/Applications` folder later.
  2. `sudo xcode-select --install`
  3. `sudo xcodebuild -license` and agree with the license

---

Clone this repository into a convenient location (e.g. `~/work-dotfiles`). The `~/.zshrc` file executes each time a shell instance is created. This is a convenient place to put all your aliases, shortcut functions, etc. To import the aliases & functions provided by this repository, append the following to your ~/.zshrc file:
```bash
# Assuming you cloned this repo to ~/work-dotfiles. Modify otherwise
source "$HOME/work-dotfiles/.zshrc"
```

Finally, execute the install script to setup `brew` and to install our dev tools:
```bash
$ sh $HOME/work-dotfiles/install.sh
```

# Improvements/additions
Fellow Galileans, please feel free to add any tools/aliases/functions to this repository!
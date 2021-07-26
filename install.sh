# https://github.com/myshov/dotfiles/blob/master/install.sh
export DOTFILES_DIR
DOTFILES_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Do some git update check here next time
[ -d "$DOTFILES_DIR/.git" ] && git --work-tree="$DOTFILES_DIR" --git-dir="$DOTFILES_DIR/.git" pull origin master

# Core setup
xcode-select --install

# Install tools
installList=(
  brew
  dmg
  nvm
  fvm
)
for item in "${installList[@]}"
do
  . "$DOTFILES_DIR/install/${item}.sh"
done
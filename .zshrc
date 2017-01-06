# Path to your oh-my-zsh installation.
export ZSH=/Users/pawelgol/.oh-my-zsh
. ~/.nvm/nvm.sh

ZSH_THEME="spaceship"

plugins=(git)

# User configuration
export PATH="/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/bin:/usr/local/mysql/bin:/Users/pawelgol/.rvm/bin"
# export MANPATH="/usr/local/man:$MANPATH"

source $ZSH/oh-my-zsh.sh

nvm use default

# added by travis gem
[ -f /Users/pawelgol/.travis/travis.sh ] && source /Users/pawelgol/.travis/travis.sh

autoload -U add-zsh-hook
#always when directory was changed try to load node version based on .nvmrc file
load-nvmrc() {
  local node_version="$(nvm version)"
  local nvmrc_path="$(nvm_find_nvmrc)"

  if [ -n "$nvmrc_path" ]; then
    local nvmrc_node_version=$(nvm version "$(cat "${nvmrc_path}")")

    if [ "$nvmrc_node_version" != "N/A" ] && [ "$nvmrc_node_version" != "$node_version" ]; then
      nvm use
    fi
  elif [ "$node_version" != "$(nvm version default)" ]; then
    echo "Reverting to nvm default version"
    nvm use default
  fi
}
add-zsh-hook chpwd load-nvmrc
load-nvmrc

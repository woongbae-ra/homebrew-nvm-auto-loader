# Ensure nvm is available
if [ "$(command -v nvm)" = "" ]; then
  if [ -s "$NVM_DIR/nvm.sh" ]; then
    source "$NVM_DIR/nvm.sh"
  else
    echo "Could not find nvm, install it with https://github.com/nvm-sh/nvm#installing-and-updating"
    exit 1
  fi
fi

# Automatically find .nvmrc and use it
last_nvmrc_path=""
nvm_auto_loader() {
  local node_version
  local nvmrc_path=$(nvm_find_nvmrc)

  # Check if we're still in the same directory with an .nvmrc file
  if [ -n "$nvmrc_path" ] && [ "$nvmrc_path" = "$last_nvmrc_path" ]; then
    return
  fi

  if [ -z "$nvmrc_path" ]; then
    # Revert to default version if no .nvmrc file is found
    node_version="$(nvm_alias default 2>/dev/null || echo)"
  else
    node_version=$(cat "$nvmrc_path")
    # Install the version from .nvmrc if it's not installed
    if ! nvm ls "$node_version" > /dev/null 2>&1; then
      echo "Version specified in .nvmrc ($node_version) not found, installing..."
      nvm install "$node_version"
    fi
    last_nvmrc_path="$nvmrc_path"
  fi

  # Only switch versions if a valid version is specified
  if [ -n "$node_version" ]; then
    [ "$(nvm_version_path $node_version)/bin" = "$NVM_BIN" ] || nvm use "$node_version"
  else
    echo "No default Node.js version set, run 'nvm alias default <version>' to set it."
  fi
}

# Override the 'cd' command for Bash
if [ -n "$BASH_VERSION" ]; then
  cd() {
    builtin cd "$@" && nvm_auto_loader
  }
fi

# Use 'chpwd' function for Zsh
if [ -n "$ZSH_VERSION" ]; then
  autoload -U add-zsh-hook
  add-zsh-hook chpwd nvm_auto_loader
fi

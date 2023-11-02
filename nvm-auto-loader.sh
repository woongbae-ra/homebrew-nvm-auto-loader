nvm_installed=true

# Ensure nvm is available
if [ "$(command -v nvm)" = "" ]; then
  if [ -s "$NVM_DIR/nvm.sh" ]; then
    source "$NVM_DIR/nvm.sh"
  else
    echo "Could not find nvm, install it with https://github.com/nvm-sh/nvm#installing-and-updating"
    nvm_installed=false
  fi
fi

# Automatically find .nvmrc and use it
last_nvmrc_path=""
nvm_auto_loader() {
  if [ "$nvm_installed" = "false" ]; then
    return
  fi 

  # 적합한 .nvmrc 파일을 찾는다
  local nvmrc_path=$(nvm_find_nvmrc)
  if [ -n "$nvmrc_path" ]; then
    # last_nvmrc_path가 그대로면, 아무것도 하지 않는다 
    if [ -n "$nvmrc_path" ] && [ "$nvmrc_path" = "$last_nvmrc_path" ]; then
      return
    fi
    # 필요한 node 버전이 설치되어 있지 않으면 설치한다
    local version_required=$(cat "$nvmrc_path")
    if ! nvm ls "$version_required" > /dev/null 2>&1; then
      echo "Version specified in .nvmrc ($version_required) not found, installing..."
      nvm install "$version_required"
    fi
    nvm use
    last_nvmrc_path="$nvmrc_path"
  elif [[ $(nvm version) != $(nvm version default) ]]; then
    # .nvmrc 파일이 없으면 기본 버전으로 되돌린다
    if [ -n "$last_nvmrc_path" ]; then
      nvm use default
    fi
    last_nvmrc_path=""
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

# Run nvm_auto_loader on shell init
nvm_auto_loader
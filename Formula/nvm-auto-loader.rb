class NvmAutoLoader < Formula
  desc "Automatically loads Node versions based on .nvmrc by using nvm (supports zsh and bash)"
  homepage "https://github.com/woongbae-ra/nvm-auto-loader#readme"
  head "https://github.com/woongbae-ra/nvm-auto-loader.git", branch: "main"

  def install
    bin.install "nvm-auto-loader.sh"
  end

  def post_install
    green = "\033[1;32m"
    reset = "\033[0m"
    bold = "\033[1m"
    separator = "\033[1;34m" + "-"*80 + "\033[0m"
  
    puts separator
    puts "\n#{green}🎉  nvm-auto-loader has been successfully installed! #{reset}\n\n"
    puts "#{bold}To finalize the installation, follow these guidelines:#{reset}\n\n"
    
    puts "1️⃣  Add the line below to your shell configuration file (e.g., ~/.zshrc or ~/.bash_profile):\n\n"
    puts "     #{green}source #{opt_prefix}/bin/nvm-auto-loader.sh#{reset}\n\n"
    
    puts "2️⃣  Restart your terminal or run the following commands based on your shell:\n\n"
    puts "     #{green}source ~/.zshrc#{reset} (for zsh users)\n"
    puts "     #{green}source ~/.bash_profile#{reset} (for bash users)\n\n"
    puts separator
  end
end
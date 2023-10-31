class NvmAutoLoader < Formula
  desc "Automatically loads Node versions based on .nvmrc by using nvm (supports zsh and bash)"
  homepage "https://github.com/woongbae-ra/nvm-auto-loader#readme"
  head "https://github.com/woongbae-ra/nvm-auto-loader.git", branch: "main"

  def install
    bin.install "nvm-auto-loader.sh"
  end

  def post_install
    # Formatting with color
    green = "\033[1;32m"
    reset = "\033[0m"
    bold = "\033[1m"
  
    puts "\n#{green}🎉  nvm-auto-loader is installed successfully! #{reset}\n\n"
    puts "#{bold}To finalize the installation, add the following line to your shell configuration:#{reset}\n\n"
    puts "  #{green}source #{opt_prefix}/bin/nvm-auto-loader.sh#{reset}\n\n"
    puts "Typically, this would be in your #{bold}~/.zshrc#{reset} or #{bold}~/.bash_profile#{reset}.\n\n"
  end
  
  test do
    # Here you can define tests for your utility.
  end
end
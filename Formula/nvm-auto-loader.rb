class NvmAutoLoader < Formula
  desc "Automatically loads Node versions based on .nvmrc by using nvm (supports zsh and bash)"
  homepage "https://github.com/woongbae-ra/nvm-auto-loader#readme"
  head "https://github.com/woongbae-ra/nvm-auto-loader.git", branch: "main"

  def install
    bin.install "nvm-auto-loader.sh"
  end

  def post_install
    opoo "IMPORTANT: Post-installation steps:"
    puts "\nTo finish the installation, you need to source the script in your shell:\n\n"
    puts "For zsh, add the following to your ~/.zshrc:"
    puts "  source #{opt_prefix}/bin/nvm-auto-loader.sh\n\n"
    puts "For bash, add the following to your ~/.bash_profile or ~/.bashrc:"
    puts "  source #{opt_prefix}/bin/nvm-auto-loader.sh\n\n"
  end
  
  test do
    # Here you can define tests for your utility.
  end
end
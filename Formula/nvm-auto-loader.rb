class NvmAutoLoader < Formula
  desc "Automatically loads Node versions based on .nvmrc by using nvm (supports zsh and bash)"
  homepage "https://github.com/woongbae-ra/nvm-auto-loader#readme"
  head "https://github.com/woongbae-ra/nvm-auto-loader.git", branch: "main"

  def install
    bin.install "nvm-auto-loader.sh"
  end

  def caveats
    <<~EOS
      #{Tty.bold}IMPORTANT:#{Tty.reset}
      
      To finish the installation, you need to source the script in your shell:
      
      #{Tty.underline}For zsh#{Tty.reset}, add the following to your #{Tty.underline}~/.zshrc#{Tty.reset}:
        #{Tty.green}source #{opt_prefix}/bin/nvm-auto-loader.sh#{Tty.reset}
      
      #{Tty.underline}For bash#{Tty.reset}, add the following to your #{Tty.underline}~/.bash_profile#{Tty.reset} or #{Tty.underline}~/.bashrc#{Tty.reset}:
        #{Tty.green}source #{opt_prefix}/bin/nvm-auto-loader.sh#{Tty.reset}
    EOS
  end
  

  test do
    # Here you can define tests for your utility.
  end
end
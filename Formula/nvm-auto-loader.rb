class NvmAutoLoader < Formula
  desc "Automatically loads Node versions based on .nvmrc by using nvm (supports zsh and bash)"
  homepage "https://github.com/woongbae-ra/nvm-auto-loader#readme"
  head "https://github.com/woongbae-ra/nvm-auto-loader.git", branch: "main"

  def install
    bin.install "nvm-auto-loader.sh"
  end

  def post_install
    scripts = "source #{opt_prefix}/bin/nvm-auto-loader.sh"
    
    # For ~/.zshrc
    zshrc_path = Pathname.new("#{ENV["HOME"]}/.zshrc")
    if zshrc_path.exist? && !zshrc_path.read.include?(scripts)
      zshrc_path.open('a') do |file|
        file.puts scripts
      end
    end

    # For ~/.bash_profile
    bash_profile_path = Pathname.new("#{ENV["HOME"]}/.bash_profile")
    if bash_profile_path.exist? && !bash_profile_path.read.include?(scripts)
      bash_profile_path.open('a') do |file|
        file.puts scripts
      end
    end

    puts "nvm-auto-loader is installed successfully! Please restart your terminal."
  end
  
  test do
    # Here you can define tests for your utility.
  end
end
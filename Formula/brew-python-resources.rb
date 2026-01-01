class BrewPythonResources < Formula

  desc "Generate and Update Homebrew Formula Python Resources"
  homepage "https://github.com/cssnr/brew-python-resources"
  license "MIT"
  version "0.0.1"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/cssnr/brew-python-resources/releases/download/#{version}/macos-amd64.zip"
    end
    if Hardware::CPU.arm?
      url "https://github.com/cssnr/brew-python-resources/releases/download/#{version}/macos-arm64.zip"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/cssnr/brew-python-resources/releases/download/#{version}/linux-amd64.zip"
    end
    if Hardware::CPU.arm?
      url "https://github.com/cssnr/brew-python-resources/releases/download/#{version}/linux-arm64.zip"
    end
  end

  def install
    chmod 0755, "bpr"
    bin.install "bpr"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/bpr -V")
  end
end

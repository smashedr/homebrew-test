class Npmstat < Formula
  desc "NPM Package Stats and Info CLI"
  homepage "https://github.com/cssnr/npmstat"
  license "MIT"
  version "0.1.0"

  on_macos do
    if Hardware::CPU.arm?
      # url "https://github.com/cssnr/npmstat/releases/latest/download/macos-arm64.zip"
      url "https://github.com/cssnr/npmstat/releases/download/#{version}/macos-arm64.zip"
    end
    if Hardware::CPU.intel?
      # url "https://github.com/cssnr/npmstat/releases/latest/download/macos-amd64.zip"
      url "https://github.com/cssnr/npmstat/releases/download/#{version}/macos-amd64.zip"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      # url "https://github.com/cssnr/npmstat/releases/latest/download/linux-arm64.zip"
      url "https://github.com/cssnr/npmstat/releases/download/#{version}/linux-arm64.zip"
    end
    if Hardware::CPU.intel?
      # url "https://github.com/cssnr/npmstat/releases/latest/download/linux-amd64.zip"
      url "https://github.com/cssnr/npmstat/releases/download/#{version}/linux-amd64.zip"
    end
  end

  def install
    chmod 0755, "npmstat"
    bin.install "npmstat"
  end

  test do
    # system "#{bin}/npmstat", "--version"
    assert_match "#{version}", shell_output("#{bin}/npmstat -V")
  end
end

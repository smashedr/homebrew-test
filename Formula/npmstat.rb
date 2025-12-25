class Npmstat < Formula
  desc "NPM Package Stats and Info CLI"
  homepage "https://github.com/cssnr/npmstat"
  license "MIT"
  version "0.1.0"

  # on_macos do
  #   if Hardware::CPU.arm?
  #     url "https://github.com/cssnr/npmstat/releases/latest/download/macos-arm64.zip"
  #     # sha256 "586127543a6a6724e48454c47f6ed2196d5e603c4bb160489cc78315123a948a"
  #   end
  #   if Hardware::CPU.intel?
  #     url "https://github.com/cssnr/npmstat/releases/latest/download/macos-amd64.zip"
  #     # sha256 "ffbc86e31ea4eee51e3eb2289979533f627ba45c8da325c208c72a059bfdad17"
  #   end
  # end
  #
  # on_linux do
  #   if Hardware::CPU.arm?
  #     url "https://github.com/cssnr/npmstat/releases/latest/download/linux-arm64.zip"
  #     # sha256 "586127543a6a6724e48454c47f6ed2196d5e603c4bb160489cc78315123a948a"
  #   end
  #   if Hardware::CPU.intel?
  #     url "https://github.com/cssnr/npmstat/releases/latest/download/linux-amd64.zip"
  #     # sha256 "ffbc86e31ea4eee51e3eb2289979533f627ba45c8da325c208c72a059bfdad17"
  #   end
  # end

  url "https://github.com/cssnr/npmstat/releases/latest/download/linux-amd64.zip"

  def install
    zip_file = Dir["*.zip"].first
    if zip_file.nil?
      raise "AI IS RETARDED."
    end
    system "unzip", zip_file
    chmod 0755, "npmstat"
    bin.install "npmstat"
  end

  test do
    system "#{bin}/npmstat", "--version"
    # assert_match "0.1.0", shell_output("#{bin}/npmstat -V")
  end
end

class SharexCli < Formula
  desc "ShareX Command Line Interface Uploader"
  homepage "https://github.com/cssnr/sharex-cli"
  license "MIT"

  version "0.0.3"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/cssnr/sharex-cli/releases/download/#{version}/macos-amd64.zip"
    end
    if Hardware::CPU.arm?
      url "https://github.com/cssnr/sharex-cli/releases/download/#{version}/macos-arm64.zip"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/cssnr/sharex-cli/releases/download/#{version}/linux-amd64.zip"
    end
    if Hardware::CPU.arm?
      url "https://github.com/cssnr/sharex-cli/releases/download/#{version}/linux-arm64.zip"
    end
  end

  def install
    chmod 0755, "sharex"
    bin.install "sharex"
  end

  def caveats
    <<~EOF
      ShareX CLI has been installed.

        Configure the app and view the usage:

        sharex --config
        sharex --help

      For more details, see the documentation:
      https://cssnr.github.io/sharex-cli/

    EOF
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/sharex -V")
  end
end

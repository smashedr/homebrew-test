class Hls < Formula
  desc "HLS Video Downloader"
  homepage "https://github.com/smashedr/hls-downloader-go"
  version "0.0.9"
  license "MIT"

  depends_on "ffmpeg"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/smashedr/hls-downloader-go/releases/latest/download/client_Darwin_x86_64.tar.gz"
      # sha256 "56b9c057eb6eaabc15ee66fe7452698fe5640c1cf442403c3c82b43edb3fd093"
    end
    if Hardware::CPU.arm?
      url "https://github.com/smashedr/hls-downloader-go/releases/latest/download/client_Darwin_arm64.tar.gz"
      # sha256 "bae3d76fbf7bdc82b35c9f31eea8a3363a12d61ffa5dda4cedf5d66d86b45465"
    end
  end

  on_linux do
    if Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
      url "https://github.com/smashedr/hls-downloader-go/releases/latest/download/client_Linux_x86_64.tar.gz"
      # sha256 "9d52a25e599be68aa4b8a3f31d819d965fa642ae2edb3eec9e70b1da28f91442"
    end
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/smashedr/hls-downloader-go/releases/latest/download/client_Linux_arm64.tar.gz"
      # sha256 "835fd5cb1f5a0222fb323094c9094ea34a7335ffdfeeeca78ac17702fffe87eb"
    end
  end

  def install
    app_name = "org.cssnr.hls.downloader"
    description = "HLS Video Downloader"

    # Install the client binary
    libexec.install "client"
    chmod 0755, libexec/"client"

    # Create manifest files
    chrome_manifest = {
      "name" => app_name,
      "description" => description,
      "path" => "#{libexec}/client",
      "type" => "stdio",
      "allowed_origins" => ["chrome-extension://mpmiiaolodhanoalpjncddpmnkbjicbo/"]
    }

    firefox_manifest = {
      "name" => app_name,
      "description" => description,
      "path" => "#{libexec}/client",
      "type" => "stdio",
      "allowed_extensions" => ["hls-video-downloader@cssnr.com"]
    }

    # Store manifests in Homebrew's lib directory for user to symlink
    (lib/app_name).mkpath
    (lib/"#{app_name}/chrome-manifest.json").write JSON.pretty_generate(chrome_manifest)
    (lib/"#{app_name}/firefox-manifest.json").write JSON.pretty_generate(firefox_manifest)
  end

  def caveats
    app_name = "org.cssnr.hls.downloader"

    <<~EOS
      To complete installation, you need to link the native messaging manifests:

      Chrome:
        mkdir -p ~/.config/google-chrome/NativeMessagingHosts
        ln -sf #{lib}/#{app_name}/chrome-manifest.json ~/.config/google-chrome/NativeMessagingHosts/#{app_name}.json

      Chromium:
        mkdir -p ~/.config/chromium/NativeMessagingHosts
        ln -sf #{lib}/#{app_name}/chrome-manifest.json ~/.config/chromium/NativeMessagingHosts/#{app_name}.json

      Firefox:
        mkdir -p ~/.mozilla/native-messaging-hosts
        ln -sf #{lib}/#{app_name}/firefox-manifest.json ~/.mozilla/native-messaging-hosts/#{app_name}.json
    EOS
  end
end

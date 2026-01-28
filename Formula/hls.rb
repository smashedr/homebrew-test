class Hls < Formula
  desc "Client for the HLS Video Downloader Web Extension"
  homepage "https://github.com/smashedr/hls-downloader-go"
  version "0.0.9"
  license "MIT"

  depends_on "ffmpeg"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/smashedr/hls-downloader-go/releases/download/#{version}/client_Darwin_x86_64.tar.gz"
      # sha256 "56b9c057eb6eaabc15ee66fe7452698fe5640c1cf442403c3c82b43edb3fd093"
    end
    if Hardware::CPU.arm?
      url "https://github.com/smashedr/hls-downloader-go/releases/download/#{version}/client_Darwin_arm64.tar.gz"
      # sha256 "bae3d76fbf7bdc82b35c9f31eea8a3363a12d61ffa5dda4cedf5d66d86b45465"
    end
  end

  on_linux do
    if Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
      url "https://github.com/smashedr/hls-downloader-go/releases/download/#{version}/client_Linux_x86_64.tar.gz"
      # sha256 "9d52a25e599be68aa4b8a3f31d819d965fa642ae2edb3eec9e70b1da28f91442"
    end
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/smashedr/hls-downloader-go/releases/download/#{version}/client_Linux_arm64.tar.gz"
      # sha256 "835fd5cb1f5a0222fb323094c9094ea34a7335ffdfeeeca78ac17702fffe87eb"
    end
  end

  def install
    app_name = "org.cssnr.hls.downloader"
    description = "HLS Video Downloader"

    libexec.install "client"
    chmod 0755, libexec/"client"

    chrome_manifest = {
      "name"            => app_name,
      "description"     => description,
      "path"            => "#{libexec}/client",
      "type"            => "stdio",
      "allowed_origins" => ["chrome-extension://mpmiiaolodhanoalpjncddpmnkbjicbo/"],
    }

    firefox_manifest = {
      "name"               => app_name,
      "description"        => description,
      "path"               => "#{libexec}/client",
      "type"               => "stdio",
      "allowed_extensions" => ["hls-video-downloader@cssnr.com"],
    }

    # Store manifests in Homebrew's lib directory for user to symlink
    (lib/app_name).mkpath
    (lib/"#{app_name}/chrome-manifest.json").write JSON.pretty_generate(chrome_manifest)
    (lib/"#{app_name}/firefox-manifest.json").write JSON.pretty_generate(firefox_manifest)
  end

  def caveats
    app_name = "org.cssnr.hls.downloader"

    on_macos do
      <<~EOS
        To complete installation, you need to link the native messaging manifests:

        Chrome, Opera, Brave, and More:
          mkdir -p "~/Library/Application Support/Google/Chrome/NativeMessagingHosts"
          ln -sf "#{lib}/#{app_name}/chrome-manifest.json ~/Library/Application Support/Google/Chrome/NativeMessagingHosts/#{app_name}.json"

        Chromium:
          mkdir -p "~/Library/Application Support/Chromium/NativeMessagingHosts"
          ln -sf "#{lib}/#{app_name}/chrome-manifest.json ~/Library/Application Support/Chromium/NativeMessagingHosts/#{app_name}.json"

        Firefox, Waterfox:
          mkdir -p "~/Library/Application Support/Mozilla/NativeMessagingHosts"
          ln -sf "#{lib}/#{app_name}/firefox-manifest.json ~/Library/Application Support/Mozilla/NativeMessagingHosts/#{app_name}.json"
      EOS
    end

    on_linux do
      <<~EOS
        To complete installation, you need to link the native messaging manifests:

        Chrome, Opera, Brave, and More:
          mkdir -p ~/.config/google-chrome/NativeMessagingHosts
          ln -sf #{lib}/#{app_name}/chrome-manifest.json ~/.config/google-chrome/NativeMessagingHosts/#{app_name}.json

        Chromium:
          mkdir -p ~/.config/chromium/NativeMessagingHosts
          ln -sf #{lib}/#{app_name}/chrome-manifest.json ~/.config/chromium/NativeMessagingHosts/#{app_name}.json

        Firefox, Waterfox:
          mkdir -p ~/.mozilla/native-messaging-hosts
          ln -sf #{lib}/#{app_name}/firefox-manifest.json ~/.mozilla/native-messaging-hosts/#{app_name}.json
      EOS
    end
  end

  test do
    app_name = "org.cssnr.hls.downloader"

    assert_path_exists lib/"#{app_name}/chrome-manifest.json"
    assert_path_exists lib/"#{app_name}/firefox-manifest.json"

    # cmd = "python3 -c \"import sys, struct; sys.stdout.buffer.write(struct.pack('I', len('{}')) + '{}'.encode())\""
    # assert_match "Host Client Working.", shell_output("#{cmd} | #{libexec}/client")

    # (testpath/"test.py").write <<~EOS
    #   import sys, struct
    #   sys.stdout.buffer.write(struct.pack('I', len('{}')) + '{}'.encode())
    # EOS
    # assert_match "Host Client Working.", shell_output("python3 test.py | #{libexec}/client")

    (testpath/"test.sh").write <<~EOS
      msg='{"text":"hello"}'
      len=${#msg}
      printf "\\x$(printf '%02x' $((len&0xff)))\\x$(printf '%02x' $(((len>>8)&0xff)))\\x$(printf '%02x' $(((len>>16)&0xff)))\\x$(printf '%02x' $(((len>>24)&0xff)))%s" "$msg"
    EOS
    assert_match "Host Client Working.", shell_output("bash test.sh | #{libexec}/client")
  end
end

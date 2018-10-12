class Macls < Formula
  desc "My Mac LS"
  homepage "https://github.com/smashedr/homebrew-test"
  url "https://imgg.site/f/macls-osx"
  version "0.0.1"
  sha256 "bb38e04ca01881df5e6b92e2231f3173ee6d610b32af3068e8fe6b001c51a10f"

def install
    mv Dir.glob("macls-osx*").first, "macls"
    bin.install "macls"
  end

  test do
    shell_output("macls /tmp")
  end
end

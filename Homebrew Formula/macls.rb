class Foobar < Formula
  desc "This is a Description"
  homepage "https://github.com/smashedr/homebrew-test"
  url "https://github.com/JonathanSalwan/binary-samples/blob/master/MachO-OSX-x64-ls?raw=true"
  version "0.0.1"
  sha256 "bb38e04ca01881df5e6b92e2231f3173ee6d610b32af3068e8fe6b001c51a10f"

def install
    mv Dir.glob("MachO-OSX-*").first, "macls"
    bin.install "macls"
  end

  test do
    macls help
  end
end

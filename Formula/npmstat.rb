class Npmstat < Formula
  desc "NPM Package Stats and Info CLI"
  homepage "https://github.com/cssnr/npmstat"
  license "MIT"
  version "0.1.0"

  url "https://github.com/cssnr/npmstat/releases/download/#{version}/npmstat-#{version}.tar.gz"

  depends_on "python@3.14"

  def install
    virtualenv_install_with_resources
  end

  test do
    # system "#{bin}/npmstat", "--version"
    assert_match "#{version}", shell_output("#{bin}/npmstat -V")
  end
end

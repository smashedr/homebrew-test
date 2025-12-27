class TomlRun < Formula
  include Language::Python::Virtualenv

  desc "Run Custom pyproject.toml Scripts"
  homepage "https://github.com/cssnr/toml-run"
  url "https://github.com/cssnr/toml-run/releases/download/0.0.2/toml_run-0.0.2.tar.gz"
  sha256 "f94ef95267c2aee45c12121993b0a85cdd614c60a54e90542753226ed41d8b86"
  license "MIT"

  depends_on "python"

  def install
    virtualenv_install_with_resources
  end

  test do
    assert_match "#{version}", shell_output("#{bin}/toml-run -V")
  end
end

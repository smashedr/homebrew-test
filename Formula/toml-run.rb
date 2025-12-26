class TomlRun < Formula
  include Language::Python::Virtualenv

  desc "Run Custom pyproject.toml Scripts"
  homepage "https://github.com/cssnr/toml-run"
  license "MIT"
  version "1.0.2"

  url "https://github.com/smashedr/test-workflows/releases/download/1.0.2/toml_run-1.0.2.tar.gz"

  depends_on "python"

  def install
    virtualenv_install_with_resources
  end

  test do
    # system "#{bin}/toml-run", "--version"
    assert_match "#{version}", shell_output("#{bin}/toml-run -V")
  end
end

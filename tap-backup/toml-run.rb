class TomlRun < Formula
  include Language::Python::Virtualenv

  desc "Run Custom pyproject.toml Scripts"
  homepage "https://github.com/cssnr/toml-run"
  license "MIT"
  version "0.0.2"

  url "https://github.com/cssnr/toml-run/releases/download/#{version}/toml_run-#{version}.tar.gz"

  depends_on "python"

  def install
    virtualenv_install_with_resources
  end

  test do
    assert_match "#{version}", shell_output("#{bin}/toml-run -V")
  end
end

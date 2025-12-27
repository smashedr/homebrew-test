class TomlRun < Formula
  include Language::Python::Virtualenv

  desc "Run Custom pyproject.toml Scripts"
  homepage "https://github.com/cssnr/toml-run"
  url "https://github.com/cssnr/toml-run/releases/download/0.0.2/toml_run-0.0.2.tar.gz"
  sha256 "f94ef95267c2aee45c12121993b0a85cdd614c60a54e90542753226ed41d8b86"
  license "MIT"

  depends_on "python"

  resource "tomli" do
    url "https://files.pythonhosted.org/packages/52/ed/3f73f72945444548f33eba9a87fc7a6e969915e7b1acc8260b30e1f76a2f/tomli-2.3.0.tar.gz"
    sha256 "64be704a875d2a59753d80ee8a533c3fe183e3f06807ff7dc2232938ccb01549"
  end

  def install
    venv = virtualenv_create(libexec)
    if Formula["python"].version < Version.new("3.14")
      virtualenv_install_with_resources
      venv.pip_install resources
    end
    venv.pip_install_and_link buildpath
  end

  test do
    assert_match "#{version}", shell_output("#{bin}/toml-run -V")
  end
end

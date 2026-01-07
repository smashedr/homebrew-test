class GetContributors < Formula
  desc "CLI and Script to Generate GitHub Repository Contributors"
  homepage "https://vitepress-contributors.cssnr.com/"
  url "https://github.com/cssnr/vitepress-plugin-contributors/releases/download/0.0.5/get-contributors.js"
  sha256 "9309a179f2440f0ea576e31031e87f2c9eda26bc72f5eb5f9924463e75a06ec1"
  license "GPL-3.0-only"

  depends_on "node"

  def install
    chmod 0755, "get-contributors.js"
    bin.install "get-contributors.js" => "get-contributors"
  end

  def caveats
    <<~EOF
      The get-contributors.js script has been installed.

        Use the --help flag to see the usage:

        get-contributors --help

      For more details, see the documentation:
      https://vitepress-contributors.cssnr.com/docs/get-contributors

    EOF
  end

  test do
    assert_match "Usage: get-contributors", shell_output("#{bin}/get-contributors -h")
  end
end

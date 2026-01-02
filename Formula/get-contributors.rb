class GetContributors < Formula
  desc "Script and CLI to Generate GitHub Repository Contributors"
  homepage "https://vitepress-contributors.cssnr.com/"
  license "GPL-3.0"

  url "https://github.com/cssnr/vitepress-plugin-contributors/releases/download/0.0.5/get-contributors.js"
  sha256 "9309a179f2440f0ea576e31031e87f2c9eda26bc72f5eb5f9924463e75a06ec1"

  depends_on "node"

  def install
    chmod 0755, "get-contributors.js"
    bin.install "get-contributors.js"
    bin.install_symlink "get-contributors" => "get-contributors.js"
  end

  test do
    assert_match "Usage: get-contributors", shell_output("#{bin}/get-contributors -h")
  end
end

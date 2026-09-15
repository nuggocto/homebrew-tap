class Orifude < Formula
  desc "A quiet, offline folding and ink puzzle game for the terminal"
  homepage "https://orifude.com"
  version "1.0.4"
  license "Apache-2.0"
  depends_on macos: :ventura

  on_macos do
    on_intel do
      url "https://github.com/nuggocto/orifude/releases/download/v1.0.4/orifude-1.0.4-x86_64-apple-darwin.tar.gz"
      sha256 "e10b4df2352a3de904dfb6a073edc876f11b43087dd596145f86eb95a7841fd7"
    end
    on_arm do
      url "https://github.com/nuggocto/orifude/releases/download/v1.0.4/orifude-1.0.4-aarch64-apple-darwin.tar.gz"
      sha256 "151374b6fc5e28203e3233c998f077974f414eac8f7d0827a9ceb24d7f14d70a"
    end
  end

  def install
    bin.install "orifude"
  end

  test do
    assert_equal "orifude #{version}", shell_output("#{bin}/orifude --version").strip
  end
end

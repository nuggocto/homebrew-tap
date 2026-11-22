class Orifude < Formula
  desc "A quiet, offline folding and ink puzzle game for the terminal"
  homepage "https://github.com/nuggocto/orifude"
  version "1.1.3"
  license "Apache-2.0"
  depends_on macos: :ventura

  on_macos do
    on_intel do
      url "https://github.com/nuggocto/orifude/releases/download/v1.1.3/orifude-1.1.3-x86_64-apple-darwin.tar.gz"
      sha256 "b5c0956ca7d2941fc6266c651d68b5dded3d11db8d4153f4f4714a7a302502e8"
    end
    on_arm do
      url "https://github.com/nuggocto/orifude/releases/download/v1.1.3/orifude-1.1.3-aarch64-apple-darwin.tar.gz"
      sha256 "2b36c0f8c05b03c059af23cf3eef2f1505c5759539e19c34e8854fb1dee42050"
    end
  end

  def install
    bin.install "orifude"
  end

  test do
    assert_equal "orifude #{version}", shell_output("#{bin}/orifude --version").strip
  end
end

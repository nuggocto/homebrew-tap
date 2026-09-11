class Orifude < Formula
  desc "A quiet, offline folding and ink puzzle game for the terminal"
  homepage "https://orifude.com"
  version "1.0.2"
  license "Apache-2.0"
  depends_on macos: :ventura

  on_macos do
    on_intel do
      url "https://github.com/nuggocto/orifude/releases/download/v1.0.2/orifude-1.0.2-x86_64-apple-darwin.tar.gz"
      sha256 "3b086518c59d595c375fb64627cbe139732ffcf3191db9002d2c68a00d52da06"
    end
    on_arm do
      url "https://github.com/nuggocto/orifude/releases/download/v1.0.2/orifude-1.0.2-aarch64-apple-darwin.tar.gz"
      sha256 "5371544fa4fe0e102fda6e3c2471fe02771483b5c1e78f6ae97a592e8d0e958c"
    end
  end

  def install
    bin.install "orifude"
  end

  test do
    assert_equal "orifude #{version}", shell_output("#{bin}/orifude --version").strip
  end
end

class Orifude < Formula
  desc "A quiet, offline folding and ink puzzle game for the terminal"
  homepage "https://orifude.com"
  version "1.0.3"
  license "Apache-2.0"
  depends_on macos: :ventura

  on_macos do
    on_intel do
      url "https://github.com/nuggocto/orifude/releases/download/v1.0.3/orifude-1.0.3-x86_64-apple-darwin.tar.gz"
      sha256 "9cd0bfdb1155407feae66038f7754283f970db01e20aa0f1ed4989e1c36a8d85"
    end
    on_arm do
      url "https://github.com/nuggocto/orifude/releases/download/v1.0.3/orifude-1.0.3-aarch64-apple-darwin.tar.gz"
      sha256 "158efd397406a612620054223166d231758bef8fdc3c09a9880436ee3442f56b"
    end
  end

  def install
    bin.install "orifude"
  end

  test do
    assert_equal "orifude #{version}", shell_output("#{bin}/orifude --version").strip
  end
end

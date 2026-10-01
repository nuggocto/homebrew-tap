class Orifude < Formula
  desc "A quiet, offline folding and ink puzzle game for the terminal"
  homepage "https://orifude.com"
  version "1.1.1"
  license "Apache-2.0"
  depends_on macos: :ventura

  on_macos do
    on_intel do
      url "https://github.com/nuggocto/orifude/releases/download/v1.1.1/orifude-1.1.1-x86_64-apple-darwin.tar.gz"
      sha256 "a2afc2ce7723c375ae6b3b160ec08451c86b5493a02d9d352cdf68d52677d8c9"
    end
    on_arm do
      url "https://github.com/nuggocto/orifude/releases/download/v1.1.1/orifude-1.1.1-aarch64-apple-darwin.tar.gz"
      sha256 "68097286f7ee91ae689663a97f503d43e9c933f8e77c9b5d73b765503ef08cd1"
    end
  end

  def install
    bin.install "orifude"
  end

  test do
    assert_equal "orifude #{version}", shell_output("#{bin}/orifude --version").strip
  end
end

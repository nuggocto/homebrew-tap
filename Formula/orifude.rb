class Orifude < Formula
  desc "A quiet, offline folding and ink puzzle game for the terminal"
  homepage "https://orifude.com"
  version "1.0.1"
  license "Apache-2.0"
  depends_on macos: :ventura

  on_macos do
    on_intel do
      url "https://github.com/nuggocto/orifude/releases/download/v1.0.1/orifude-1.0.1-x86_64-apple-darwin.tar.gz"
      sha256 "2606b207eb3b0f283989d4ad8c6aa6ef7af9ef82afcfa0f36a8c86d8e0b83ca4"
    end
    on_arm do
      url "https://github.com/nuggocto/orifude/releases/download/v1.0.1/orifude-1.0.1-aarch64-apple-darwin.tar.gz"
      sha256 "a3910a631d1a9d03fbcf432ec50f9d6a66360cdbdb156aa6d5529718eb8adab7"
    end
  end

  def install
    bin.install "orifude"
  end

  test do
    assert_equal "orifude #{version}", shell_output("#{bin}/orifude --version").strip
  end
end

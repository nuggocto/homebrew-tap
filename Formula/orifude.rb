class Orifude < Formula
  desc "A quiet, offline folding and ink puzzle game for the terminal"
  homepage "https://orifude.com"
  version "1.1.0"
  license "Apache-2.0"
  depends_on macos: :ventura

  on_macos do
    on_intel do
      url "https://github.com/nuggocto/orifude/releases/download/v1.1.0/orifude-1.1.0-x86_64-apple-darwin.tar.gz"
      sha256 "af2a320434bcbcc9ce57f7c57851bd455fa730cb79a768d116a7f8052bcdd980"
    end
    on_arm do
      url "https://github.com/nuggocto/orifude/releases/download/v1.1.0/orifude-1.1.0-aarch64-apple-darwin.tar.gz"
      sha256 "d43ed81501d0ce85bc26bff98336fbfd988b96cdff2222c03f187d3d879854af"
    end
  end

  def install
    bin.install "orifude"
  end

  test do
    assert_equal "orifude #{version}", shell_output("#{bin}/orifude --version").strip
  end
end

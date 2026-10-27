class Orifude < Formula
  desc "A quiet, offline folding and ink puzzle game for the terminal"
  homepage "https://orifude.com"
  version "1.1.2"
  license "Apache-2.0"
  depends_on macos: :ventura

  on_macos do
    on_intel do
      url "https://github.com/nuggocto/orifude/releases/download/v1.1.2/orifude-1.1.2-x86_64-apple-darwin.tar.gz"
      sha256 "2ea0241cf41adc72b91a82484d61d00d5b8e99ef11b28980064c7405285d2711"
    end
    on_arm do
      url "https://github.com/nuggocto/orifude/releases/download/v1.1.2/orifude-1.1.2-aarch64-apple-darwin.tar.gz"
      sha256 "741cde907834a2f19d797e2b07af44bccc732413491b6567a883b3776906f6a2"
    end
  end

  def install
    bin.install "orifude"
  end

  test do
    assert_equal "orifude #{version}", shell_output("#{bin}/orifude --version").strip
  end
end

class Orifude < Formula
  desc "A quiet, offline folding and ink puzzle game for the terminal"
  homepage "https://orifude.com"
  version "1.0.0"
  license "Apache-2.0"
  depends_on macos: :ventura

  on_macos do
    on_intel do
      url "https://github.com/nuggocto/orifude/releases/download/v1.0.0/orifude-1.0.0-x86_64-apple-darwin.tar.gz"
      sha256 "1ada3cc1fdf0645ab459c0cb037dbe9898da49154639e2caf2ddee5e7ed5de12"
    end
    on_arm do
      url "https://github.com/nuggocto/orifude/releases/download/v1.0.0/orifude-1.0.0-aarch64-apple-darwin.tar.gz"
      sha256 "53ac20742100f78b29bdd0c8734d3807b4aad8ba25c4a7f44a57c0b0c05e69d5"
    end
  end

  def install
    bin.install "orifude"
  end

  test do
    assert_equal "orifude #{version}", shell_output("#{bin}/orifude --version").strip
  end
end

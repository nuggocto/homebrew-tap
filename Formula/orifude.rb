class Orifude < Formula
  desc "A quiet, pseudonymous one-to-one letter exchange for the terminal"
  homepage "https://orifude.com"
  version "0.2.0"
  license "Apache-2.0"

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/nuggocto/orifude/releases/download/v0.2.0/orifude_0.2.0_darwin_arm64.tar.gz"
      sha256 "dbb964b90cb10e468a6b1e6725cfc77cc9c28cddb020bada32b92ad93d45c027"
    else
      url "https://github.com/nuggocto/orifude/releases/download/v0.2.0/orifude_0.2.0_darwin_amd64.tar.gz"
      sha256 "b87bfd54bebbfc80331c5510bef67d1646c6c323696ff3b1c3faeca142c17230"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/nuggocto/orifude/releases/download/v0.2.0/orifude_0.2.0_linux_arm64.tar.gz"
      sha256 "1ef37a506e9aead816a232c86b6fd29c91204ceed31ef32b7a1be8c001acff00"
    else
      url "https://github.com/nuggocto/orifude/releases/download/v0.2.0/orifude_0.2.0_linux_amd64.tar.gz"
      sha256 "031d0745469418c3d3c8946e777e6456f52a95ee3e5afc5ff4bd906fc2490873"
    end
  end

  def install
    bin.install "orifude"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/orifude --version")
  end
end

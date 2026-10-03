class Kickoutchi < Formula
  desc "A clean TUI and CLI port janitor: see which process owns each open local port and kick it out safely"
  homepage "https://kickoutchi.com"
  version "1.5.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/nuggocto/kickoutchi/releases/download/v1.5.0/kickoutchi-aarch64-apple-darwin.tar.xz"
      sha256 "d90ef81847e31c8e51cf70f8d0adf4e51dd0b16a8bb744d4421043035a13492b"
    end
    if Hardware::CPU.intel?
      url "https://github.com/nuggocto/kickoutchi/releases/download/v1.5.0/kickoutchi-x86_64-apple-darwin.tar.xz"
      sha256 "6c88f3d28955a6302fc8f84b1e7562fec4a2618d13d73e0094f7071f1f1cd063"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/nuggocto/kickoutchi/releases/download/v1.5.0/kickoutchi-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "e7fdc75565402684f3d239ceda5e30e19f824ac609733eb834041837a08240b4"
    end
    if Hardware::CPU.intel?
      url "https://github.com/nuggocto/kickoutchi/releases/download/v1.5.0/kickoutchi-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "a6fa5b9439cab035fbe9c686583abe16497e5ec00c24b66ca1690f7168961c23"
    end
  end
  license "MIT"

  BINARY_ALIASES = {
    "aarch64-apple-darwin": {},
    "aarch64-unknown-linux-gnu": {},
    "x86_64-apple-darwin": {},
    "x86_64-pc-windows-gnu": {},
    "x86_64-unknown-linux-gnu": {}
  }

  def target_triple
    cpu = Hardware::CPU.arm? ? "aarch64" : "x86_64"
    os = OS.mac? ? "apple-darwin" : "unknown-linux-gnu"

    "#{cpu}-#{os}"
  end

  def install_binary_aliases!
    BINARY_ALIASES[target_triple.to_sym].each do |source, dests|
      dests.each do |dest|
        bin.install_symlink bin/source.to_s => dest
      end
    end
  end

  def install
    if OS.mac? && Hardware::CPU.arm?
      bin.install "kick", "kickoutchi"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "kick", "kickoutchi"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "kick", "kickoutchi"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "kick", "kickoutchi"
    end

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end

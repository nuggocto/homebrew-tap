class Kickoutchi < Formula
  desc "A clean TUI and CLI port janitor: see which process owns each open local port and kick it out safely"
  homepage "https://kickoutchi.com"
  version "1.4.4"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/nuggocto/kickoutchi/releases/download/v1.4.4/kickoutchi-aarch64-apple-darwin.tar.xz"
      sha256 "bc376151c98904504e202fabcbe0afbb9900d45a5b21e07f2c829a340ba2255b"
    end
    if Hardware::CPU.intel?
      url "https://github.com/nuggocto/kickoutchi/releases/download/v1.4.4/kickoutchi-x86_64-apple-darwin.tar.xz"
      sha256 "a3f452b48299a82c6622438c598501712f236baaedba34537b1db6820880bea6"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/nuggocto/kickoutchi/releases/download/v1.4.4/kickoutchi-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "22844e05bef7ea79d73d81f5ce2b8393ed8ae24e45d95d0a3176a4e9abe87895"
    end
    if Hardware::CPU.intel?
      url "https://github.com/nuggocto/kickoutchi/releases/download/v1.4.4/kickoutchi-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "8ecc71d6db576bf93d235c6a80eb5951aa3e30240a817d52123dab6f4a94f837"
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

class Kickoutchi < Formula
  desc "A clean TUI and CLI port janitor: see which process owns each open local port and kick it out safely"
  homepage "https://kickoutchi.com"
  version "1.3.10"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/nuggocto/kickoutchi/releases/download/v1.3.10/kickoutchi-aarch64-apple-darwin.tar.xz"
      sha256 "15d0347b5a947c4d42ce32b0f8b5b833c58a024464cae11f3703939b911755a8"
    end
    if Hardware::CPU.intel?
      url "https://github.com/nuggocto/kickoutchi/releases/download/v1.3.10/kickoutchi-x86_64-apple-darwin.tar.xz"
      sha256 "34070e4d78a7b5e70a352629efaacafbc5bd1f85fddddd1daaf3218a601ede83"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/nuggocto/kickoutchi/releases/download/v1.3.10/kickoutchi-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "e0a4d9fd0e85dd55212082bfc444e1837b7c391e8e7a14b5fa6879fd07b384b0"
    end
    if Hardware::CPU.intel?
      url "https://github.com/nuggocto/kickoutchi/releases/download/v1.3.10/kickoutchi-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "4a9299b7e93beb5f2fc723135046e410104705d1beb52c9714f0ffe1976c426d"
    end
  end
  license "MIT"

  BINARY_ALIASES = {
    "aarch64-apple-darwin":      {},
    "aarch64-unknown-linux-gnu": {},
    "x86_64-apple-darwin":       {},
    "x86_64-pc-windows-gnu":     {},
    "x86_64-unknown-linux-gnu":  {},
  }.freeze

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
    bin.install "kick", "kickoutchi" if OS.mac? && Hardware::CPU.arm?
    bin.install "kick", "kickoutchi" if OS.mac? && Hardware::CPU.intel?
    bin.install "kick", "kickoutchi" if OS.linux? && Hardware::CPU.arm?
    bin.install "kick", "kickoutchi" if OS.linux? && Hardware::CPU.intel?

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end

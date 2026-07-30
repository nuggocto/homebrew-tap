class Kickoutchi < Formula
  desc "A clean TUI and CLI port janitor: see which process owns each open local port and kick it out safely"
  homepage "https://kickoutchi.com"
  version "1.3.9"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/nuggocto/kickoutchi/releases/download/v1.3.9/kickoutchi-aarch64-apple-darwin.tar.xz"
      sha256 "b3e36be4b32dbb23e896b68ef8f7925dd82b517cbb90a1b36465ac2a24800ee0"
    end
    if Hardware::CPU.intel?
      url "https://github.com/nuggocto/kickoutchi/releases/download/v1.3.9/kickoutchi-x86_64-apple-darwin.tar.xz"
      sha256 "b33f2da5f7ea4c9bdbd28be8cc0fb40ef40d05362b2309107fb2f70a4a46f676"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/nuggocto/kickoutchi/releases/download/v1.3.9/kickoutchi-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "2689adb45c391c58216bfff6c9d2184553c12337f072455f38b5dadd3bca7511"
    end
    if Hardware::CPU.intel?
      url "https://github.com/nuggocto/kickoutchi/releases/download/v1.3.9/kickoutchi-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "b38640c9cdb2cdff9135f0b444a013b3fc99f7c7998ad12488420c5ccf481da0"
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

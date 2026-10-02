class Kickoutchi < Formula
  desc "A clean TUI and CLI port janitor: see which process owns each open local port and kick it out safely"
  homepage "https://kickoutchi.com"
  version "1.4.6"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/nuggocto/kickoutchi/releases/download/v1.4.6/kickoutchi-aarch64-apple-darwin.tar.xz"
      sha256 "5791a79095106406aecbdaab78bbc6033c82115d3108ad9b0b29df8a8deb058a"
    end
    if Hardware::CPU.intel?
      url "https://github.com/nuggocto/kickoutchi/releases/download/v1.4.6/kickoutchi-x86_64-apple-darwin.tar.xz"
      sha256 "729ee7f8a097c9362ba34ccc2832c0130e1f4f20228b5c967916ec9b464d6ee8"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/nuggocto/kickoutchi/releases/download/v1.4.6/kickoutchi-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "6adac1ac93bae9e383305e88d7304e3a348c8232e22feff78a855ed99d3bb390"
    end
    if Hardware::CPU.intel?
      url "https://github.com/nuggocto/kickoutchi/releases/download/v1.4.6/kickoutchi-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "f1cf47ea85d0a9a8969663f2bf75d2d78906e6c4e9fdaa1b07c35e520a815b04"
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

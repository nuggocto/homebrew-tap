class Kickoutchi < Formula
  desc "A clean TUI and CLI port janitor: see which process owns each open local port and kick it out safely"
  homepage "https://kickoutchi.com"
  version "1.3.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/nuggocto/kickoutchi/releases/download/v1.3.0/kickoutchi-aarch64-apple-darwin.tar.xz"
      sha256 "6f991f16a8a74a96a6ffd2796004899d6ea994987c40b25436f9672a95e82886"
    end
    if Hardware::CPU.intel?
      url "https://github.com/nuggocto/kickoutchi/releases/download/v1.3.0/kickoutchi-x86_64-apple-darwin.tar.xz"
      sha256 "2cdf79e685501a5fc7b62ead5ea51b8b42868d819a4843dfadfcd02e9fedb96a"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/nuggocto/kickoutchi/releases/download/v1.3.0/kickoutchi-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "6716cf6d607cc20b2d1d3d79793ea1211a8f804bebba4bbcab0a2549aeff8739"
    end
    if Hardware::CPU.intel?
      url "https://github.com/nuggocto/kickoutchi/releases/download/v1.3.0/kickoutchi-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "6361a1b9cdfce10c0c32ef495b350bbadeea8febd8955f708c115eee120098d8"
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

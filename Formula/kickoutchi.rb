class Kickoutchi < Formula
  desc "A clean TUI and CLI port janitor: see which process owns each open local port and kick it out safely"
  homepage "https://kickoutchi.com"
  version "1.3.7"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/nuggocto/kickoutchi/releases/download/v1.3.7/kickoutchi-aarch64-apple-darwin.tar.xz"
      sha256 "31c588742d69ee0ff53cfa5aeaaf87e6d2eeebd2f5ed72d6210f68f4d075ba3d"
    end
    if Hardware::CPU.intel?
      url "https://github.com/nuggocto/kickoutchi/releases/download/v1.3.7/kickoutchi-x86_64-apple-darwin.tar.xz"
      sha256 "f41c584aaff4c49f0723d80871fd59d8b118deb99fbb32c65031b1ccb768c310"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/nuggocto/kickoutchi/releases/download/v1.3.7/kickoutchi-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "82a87b6784b3fa1d98cf2831f14977f86d94688010d614626f8a4591c7ee65bc"
    end
    if Hardware::CPU.intel?
      url "https://github.com/nuggocto/kickoutchi/releases/download/v1.3.7/kickoutchi-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "61abad4a634a787d2420ef74cc585110b6a87ef5ec29a129d1e81aa686ccfd5d"
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

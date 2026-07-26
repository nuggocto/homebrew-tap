class Kickoutchi < Formula
  desc "A clean TUI and CLI port janitor: see which process owns each open local port and kick it out safely"
  homepage "https://kickoutchi.com"
  version "1.3.5"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/nuggocto/kickoutchi/releases/download/v1.3.5/kickoutchi-aarch64-apple-darwin.tar.xz"
      sha256 "458cb3bae92a521118f06b6b5c35808909780a35eef9022a40031092b3e26ff9"
    end
    if Hardware::CPU.intel?
      url "https://github.com/nuggocto/kickoutchi/releases/download/v1.3.5/kickoutchi-x86_64-apple-darwin.tar.xz"
      sha256 "5f4f6719b18e5b92a9d4f0b748b35d0c08ec4795e5d9a6a712b276ffb12f3721"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/nuggocto/kickoutchi/releases/download/v1.3.5/kickoutchi-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "08d35bb182236043d3f7d42599ab554d5b1eb2b454565440d605deccaf4957f5"
    end
    if Hardware::CPU.intel?
      url "https://github.com/nuggocto/kickoutchi/releases/download/v1.3.5/kickoutchi-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "3144d78412bbded5d74effcb2363d267c3de965abc39b6b6e32338e713b3769a"
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

    (pkgshare/"install-provenance").write("homebrew\n")

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end

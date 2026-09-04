class Kickoutchi < Formula
  desc "A clean TUI and CLI port janitor: see which process owns each open local port and kick it out safely"
  homepage "https://kickoutchi.com"
  version "1.4.2"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/nuggocto/kickoutchi/releases/download/v1.4.2/kickoutchi-aarch64-apple-darwin.tar.xz"
      sha256 "5029192aee3d3e22762b778b44552ea55e4dfedfdc28aaab24f140c696fb1ab1"
    end
    if Hardware::CPU.intel?
      url "https://github.com/nuggocto/kickoutchi/releases/download/v1.4.2/kickoutchi-x86_64-apple-darwin.tar.xz"
      sha256 "2ba59f1774d65b10f6cea1233c30d080887e245659297945c1cfc25e2769a752"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/nuggocto/kickoutchi/releases/download/v1.4.2/kickoutchi-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "d8e7bb9c1de8dd7e4da1b8ba36d23f2ae35cd4d0cc551dd882358019c230962c"
    end
    if Hardware::CPU.intel?
      url "https://github.com/nuggocto/kickoutchi/releases/download/v1.4.2/kickoutchi-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "143f07302884d7c8f9fec464da74ff8e7ed2e03109349f9e3b61bafbbddd53ca"
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

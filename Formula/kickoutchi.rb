class Kickoutchi < Formula
  desc "A clean TUI and CLI port janitor: see which process owns each open local port and kick it out safely"
  homepage "https://kickoutchi.com"
  version "1.5.2"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/nuggocto/kickoutchi/releases/download/v1.5.2/kickoutchi-aarch64-apple-darwin.tar.xz"
      sha256 "40434913197ec63c5a6dd1c874c26a439b0e9c50ee30a2202c87d2ee5dbb136d"
    end
    if Hardware::CPU.intel?
      url "https://github.com/nuggocto/kickoutchi/releases/download/v1.5.2/kickoutchi-x86_64-apple-darwin.tar.xz"
      sha256 "b11bbaef070deb47ba825b5f578c5eda6a605d1f79964acf0a2336e49c7f85f4"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/nuggocto/kickoutchi/releases/download/v1.5.2/kickoutchi-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "39873865e834ce0f75c94b4c1a109b7f29576f3c41176d94f33e89d688b9336c"
    end
    if Hardware::CPU.intel?
      url "https://github.com/nuggocto/kickoutchi/releases/download/v1.5.2/kickoutchi-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "7ec3429336dbebcb03f6933a4838e510083ace122a4bbb062e549999a7e933ed"
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

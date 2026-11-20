class EucalyptCalculator < Formula
  desc "A full-screen scientific calculator for the terminal"
  homepage "https://github.com/sage-allen/eucalypt-calculator"
  version "0.1.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/sage-allen/eucalypt-calculator/releases/download/v0.1.0/eucalypt-calculator-aarch64-apple-darwin.tar.xz"
      sha256 "82573e62e1d48105fb577c359fc98a82598b05685f567603a37984aa0a9af705"
    end
    if Hardware::CPU.intel?
      url "https://github.com/sage-allen/eucalypt-calculator/releases/download/v0.1.0/eucalypt-calculator-x86_64-apple-darwin.tar.xz"
      sha256 "e80415dc98f368307288a2283ff27f8ba275f4001357a2c46d73493ac0b24b56"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/sage-allen/eucalypt-calculator/releases/download/v0.1.0/eucalypt-calculator-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "9f6140078cdeebc064d2cc366e366d172a9fa5527028a51f2d941637dcc6efcd"
    end
    if Hardware::CPU.intel?
      url "https://github.com/sage-allen/eucalypt-calculator/releases/download/v0.1.0/eucalypt-calculator-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "44b860442cc61696af0c77e580cd20f14e684e81ac43157838593bb40e22439b"
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
    if OS.mac? && Hardware::CPU.arm?
      bin.install "eucalypt-calculator"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "eucalypt-calculator"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "eucalypt-calculator"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "eucalypt-calculator"
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

class EucalyptCalculator < Formula
  desc "A full-screen scientific calculator for the terminal"
  homepage "https://github.com/sage-allen/eucalypt-calculator"
  version "0.2.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/sage-allen/eucalypt-calculator/releases/download/v0.2.0/eucalypt-calculator-aarch64-apple-darwin.tar.xz"
      sha256 "e847f873b46e102c4faadee6fa9e1b05e376bd50f50b54f2d9a923a8f505a988"
    end
    if Hardware::CPU.intel?
      url "https://github.com/sage-allen/eucalypt-calculator/releases/download/v0.2.0/eucalypt-calculator-x86_64-apple-darwin.tar.xz"
      sha256 "64e737ffb487a7c5599b31d4ca1d932dfe52c97f0928dd54748595553e27b756"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/sage-allen/eucalypt-calculator/releases/download/v0.2.0/eucalypt-calculator-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "eb22ec6c3728d27b01127543d5cdce17c0bef3df55751539c729a641bb06502b"
    end
    if Hardware::CPU.intel?
      url "https://github.com/sage-allen/eucalypt-calculator/releases/download/v0.2.0/eucalypt-calculator-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "6a857cd31bee639e9f0ff01960327503c45009acc59393ae55cb2aca931b8c19"
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

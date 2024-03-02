# frozen_string_literal: true

class Dvm < Formula
  desc "Dart Version Management: A simple CLI to manage Dart SDK versions per project"
  homepage "https://github.com/blendfactory/dvm"
  version "0.0.4"
  license "BSD-3-Clause"

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/blendfactory/dvm/releases/download/#{version}/dvm-#{version}-macos-arm64.tar.gz"
      sha256 "b1f26fa4b00f68b0048082dbd5658e4e582fe27be0e4c117036ff541b56113c6"
    else
      url "https://github.com/blendfactory/dvm/releases/download/#{version}/dvm-#{version}-macos-x64.tar.gz"
      sha256 "c9fcb788ed4e1f54a600777e6ed024c048a8ad41e711434fe34463947b7bd8f3"
    end
  elsif OS.linux?
    url "https://github.com/blendfactory/dvm/releases/download/#{version}/dvm-#{version}-linux-x64.tar.gz"
    sha256 "6effa953fc21a1633f6648edbcc9fdb93c33554923e28b6d9201fafbd617967f"
  end

  def install
    # Tell the pub server where these installations are coming from.
    ENV["PUB_ENVIRONMENT"] = "homebrew:dvm"

    lib.install "src/dvm.snapshot"
    lib.install "src/dart"

    (bin/"dvm").write <<~SH
      #!/bin/sh
      exec "#{lib}/dart" "#{lib}/dvm.snapshot" "$@"
    SH

    chmod 0555, "#{bin}/dvm"
  end

  test do
    assert_equal version.to_s, shell_output("#{bin}/dvm --version").strip
  end
end

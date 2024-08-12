# frozen_string_literal: true

class Dvm < Formula
  desc "Dart Version Management: A simple CLI to manage Dart SDK versions per project"
  homepage "https://github.com/blendfactory/dvm"
  version "0.0.8+1"
  license "BSD-3-Clause"

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/blendfactory/dvm/releases/download/#{version}/dvm-0.0.8.1-macos-arm64.tar.gz"
      sha256 "2bceae1f887e08d3b821ec5198adcfd3bfbe4c56eb26061989a929b2e01bd7e2"
    else
      url "https://github.com/blendfactory/dvm/releases/download/#{version}/dvm-0.0.8.1-macos-x64.tar.gz"
      sha256 "50603ff19d8be02ca3446b682b250e5399b5c0b2911d0fa671e5a0a07f14a323"
    end
  elsif OS.linux?
    url "https://github.com/blendfactory/dvm/releases/download/#{version}/dvm-0.0.8.1-linux-x64.tar.gz"
    sha256 "87faff98a7362ab61e41491aff040dfe11f42030317c80e590667b0a409fbc9c"
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

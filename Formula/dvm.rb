# frozen_string_literal: true

class Dvm < Formula
  desc "Dart Version Management: A simple CLI to manage Dart SDK versions per project"
  homepage "https://github.com/blendfactory/dvm"
  version "0.0.3"
  license "BSD-3-Clause"

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/blendfactory/dvm/releases/download/#{version}/dvm-#{version}-macos-arm64.tar.gz"
      sha256 "f259032cd9b46e44519a49292e4050680d60c42315b73e355207d08b5c823a23"
    else
      url "https://github.com/blendfactory/dvm/releases/download/#{version}/dvm-#{version}-macos-x64.tar.gz"
      sha256 "4d7b8d4a469a4123bbd99a63ceac392fd5c89ea54e0a3a15e4fc5eca2ce5963b"
    end
  elsif OS.linux?
    url "https://github.com/blendfactory/dvm/releases/download/#{version}/dvm-#{version}-linux-x64.tar.gz"
    sha256 "1c215330e32ad9f3abc380a6a5cf86670ec175fdc08ad29440933bf0f4f88e52"
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

# frozen_string_literal: true

class Dvm < Formula
  desc "Dart Version Management: A simple CLI to manage Dart SDK versions per project"
  homepage "https://github.com/blendfactory/dvm"
  version "0.0.6"
  license "BSD-3-Clause"

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/blendfactory/dvm/releases/download/#{version}/dvm-#{version}-macos-arm64.tar.gz"
      sha256 "412c6291a25dc740375b8e9dcdb8d66a515d41a0776ce4b0ae1652aed0afda08"
    else
      url "https://github.com/blendfactory/dvm/releases/download/#{version}/dvm-#{version}-macos-x64.tar.gz"
      sha256 "53a8aa0c83f2cf2819cca159a3e85364eec7a01aecda2b42aff9c0d0191f95e7"
    end
  elsif OS.linux?
    url "https://github.com/blendfactory/dvm/releases/download/#{version}/dvm-#{version}-linux-x64.tar.gz"
    sha256 "8ae1704012ed0cef94883a0737a9ee28cf66fa716b0a09a3f518f0b103aca62f"
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

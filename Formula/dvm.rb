# frozen_string_literal: true

class Dvm < Formula
  desc "Dart Version Management: A simple CLI to manage Dart SDK versions per project"
  homepage "https://github.com/blendfactory/dvm"
  version "0.0.5"
  license "BSD-3-Clause"

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/blendfactory/dvm/releases/download/#{version}/dvm-#{version}-macos-arm64.tar.gz"
      sha256 "598c9bf0eddcd6e62c459510efe9bce7ae8640e0ebe98be031c605d6afd3d27c"
    else
      url "https://github.com/blendfactory/dvm/releases/download/#{version}/dvm-#{version}-macos-x64.tar.gz"
      sha256 "a5ba6140cbb68c6906ab61011d1e858e55f22e42dff6a379d4c5fef676060cb4"
    end
  elsif OS.linux?
    url "https://github.com/blendfactory/dvm/releases/download/#{version}/dvm-#{version}-linux-x64.tar.gz"
    sha256 "6bbe66a53b36b668433e3b9ff066607649c63d650992f8bff7a2817597fd3968"
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

class Dvm < Formula
  desc "Dart Version Management: A simple CLI to manage Dart SDK versions per project"
  version "{{ version }}"
  homepage "https://github.com/blendfactory/dvm"
  license "BSD-3-Clause"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/blendfactory/dvm/releases/download/#{version}/dvm-#{version}-macos-arm64.tar.gz"
      sha256 "{{ sha256_macos_arm64 }}"
    else
      url "https://github.com/blendfactory/dvm/releases/download/#{version}/dvm-#{version}-macos-x64.tar.gz"
      sha256 "{{ sha256_macos_x64 }}"
    end
  end

  on_linux do
    url "https://github.com/blendfactory/dvm/releases/download/#{version}/dvm-#{version}-linux-x64.tar.gz"
    sha256 "{{ sha256_linux_x64 }}"
  end

  def install
    bin.install "dvm"
  end

  test do
    assert_equal "#{version}", shell_output("#{bin}/dvm --version").strip
  end
end

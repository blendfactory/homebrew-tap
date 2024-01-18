class Dvm < Formula
  version "0.0.1"
  desc "Dart Version Management: A simple CLI to manage Dart SDK versions per project."
  homepage "https://github.com/blendfactory/dvm"
  license "BSD-3-Clause"
  
  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/blendfactory/dvm/releases/download/#{version}/dvm-#{version}-macos-arm64.tar.gz"
      sha256 "89cea0b45d46dfd2c7b416db7a013142e41281dbb308ab92a6155fd2f0d81bb4"
    else
      url "https://github.com/blendfactory/dvm/releases/download/#{version}/dvm-#{version}-macos-x64.tar.gz"
      sha256 "8354afc8d48d443c59e0e06a8c4e65b5569c1acbf901c9c588b38afdf5075dab"
    end
  end

  on_linux do
    url "https://github.com/blendfactory/dvm/releases/download/#{version}/dvm-#{version}-linux-x64.tar.gz"
    sha256 "ed041eb1ae2e1974670b7006015bc3cabe738aa92613a28682d202fa71dedc4a"
  end

  def install
    bin.install "dvm"
  end

  test do
    assert_equal "#{version}", shell_output("#{bin}/dvm --version").strip
  end
end

class Rage < Formula
  desc "Analyze the mood, tempo, and key of any song — no Python, no setup, no API keys"
  homepage "https://github.com/devland-cc/RAGE"
  version "1.1.1"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_arm do
      url "https://github.com/devland-cc/RAGE/releases/download/v1.1.1/rage-1.1.1-aarch64-apple-darwin.tar.gz"
      sha256 "9dfda63757c0b61ad086e93eda87f1ab3689d492443e69ae157fdeeb2f3aafd4"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/devland-cc/RAGE/releases/download/v1.1.1/rage-1.1.1-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "0541d32789b39e796d1f76308584e6d1cf0942830ac67b62884c770603c18f24"
    end
    on_intel do
      url "https://github.com/devland-cc/RAGE/releases/download/v1.1.1/rage-1.1.1-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "e85a4b02eddd93e867dec34b67caa476d8904aefdff8ab0ed8df0583d2bd0d1c"
    end
  end

  def install
    bin.install "rage"
  end

  test do
    assert_match "rage", shell_output("#{bin}/rage info")
  end
end

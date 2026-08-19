cask "quickbot" do
  version "0.3.0"
  sha256 "fdeb06d4f368735d59a8ecd0b68cc001532a7620411aa4b10840a6a09b7f7c10"

  url "https://github.com/devland-cc/quickbot/releases/download/v#{version}/quickbot-#{version}.tar.gz"
  name "Quickbot"
  desc "Fully local LLM assistant in the menu bar (MLX, Apple silicon)"
  homepage "https://github.com/devland-cc/quickbot"

  depends_on macos: :sonoma
  depends_on arch: :arm64

  app "Quickbot.app"
  app "Quickbot Chat.app"
  binary "#{appdir}/Quickbot.app/Contents/Resources/server/serverctl", target: "quickbot"

  # The apps are ad-hoc signed, not notarized: with the quarantine flag set,
  # Gatekeeper refuses to run them (and moves them to the Trash on recent
  # macOS), so drop the flag Homebrew applies on download.
  postflight do
    system_command "/usr/bin/xattr",
                   args: ["-dr", "com.apple.quarantine",
                          "#{appdir}/Quickbot.app",
                          "#{appdir}/Quickbot Chat.app"]
  end

  uninstall quit: [
    "com.quickbot.app",
    "com.quickbot.chat",
  ]

  zap trash: [
    "~/Library/Application Support/Quickbot Chat",
    "~/Library/Application Support/Quickbot",
    "~/Library/Logs/Quickbot",
  ]

  caveats <<~EOS
    Finish the install by profiling this Mac and downloading the model
    that fits its RAM (about 3 GB on 8 GB machines, 6 GB on 16 GB,
    16 GB on 32 GB+):

      quickbot setup

    Everything Quickbot needs — including its own private Python runtime —
    lives inside the app and ~/Library/Application Support/Quickbot.
  EOS
end

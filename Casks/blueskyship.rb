cask "blueskyship" do
  version "1.3.0"
  sha256 "b12007e6b4c10ce6b4f8bb7299f043e0bda5df43263f26ab8b67cccacb866605"

  url "https://github.com/MacBachi/BlueSkyship/releases/download/v#{version}/BlueSkyship.dmg"
  name "BlueSkyship"
  desc "Native deck client for Bluesky"
  homepage "https://github.com/MacBachi/BlueSkyship"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on macos: ">= :sonoma"

  app "BlueSkyship.app"

  zap trash: [
    "~/Library/Application Support/BlueSkyship",
    "~/Library/Caches/dev.blueskyship.app",
    "~/Library/Containers/dev.blueskyship.app",
    "~/Library/Preferences/dev.blueskyship.app.plist",
    "~/Library/Saved Application State/dev.blueskyship.app.savedState",
  ]
end

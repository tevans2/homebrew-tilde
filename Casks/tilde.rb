cask "tilde" do
  version "0.2.0"
  sha256 "eadfd6ecf464c9ce5eaffe5cc5d65a96bdb0453b1555b7648a18dad24735f910"

  url "https://github.com/tevans2/tilde/releases/download/v#{version}/Tilde-macOS.zip"
  name "Tilde"
  desc "Keyboard-first file navigator"
  homepage "https://github.com/tevans2/tilde"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on macos: :sonoma

  app "Tilde.app"

  # Tilde isn't notarized, so a quarantined copy wouldn't open the first time.
  # Every release is signed with the same certificate (see scripts/signing.sh).
  postflight_steps do
    run "/usr/bin/xattr",
        args:           ["-dr", "com.apple.quarantine", "{{appdir}}/Tilde.app"],
        writable_paths: ["{{appdir}}/Tilde.app"]
  end

  uninstall quit: "io.github.tevans2.tilde"

  # The config file (~/.config/tilde) is yours and stays.
  zap trash: [
    "~/Library/Application Support/Tilde",
    "~/Library/Caches/Tilde",
    "~/Library/Preferences/io.github.tevans2.tilde.plist",
    "~/Library/Saved Application State/io.github.tevans2.tilde.savedState",
  ]
end

cask "foundationdb@7.3" do
  arch arm: "arm64"

  name "FoundationDB"
  version "7.3.69"
  sha256 "6bfbd48ac21356de0baa0c1e84c6e33d15d95d0b9d022c35a7625e5d9293b71e"
  url "https://github.com/apple/foundationdb/releases/download/#{version}/FoundationDB-#{version}_#{arch}.pkg"

  desc "The open source, distributed, transactional key-value store"
  homepage "https://www.foundationdb.org"

  auto_updates false

  pkg "FoundationDB-#{version}_#{arch}.pkg",
    choices: [
      {
        "choiceIdentifier" => "clients",
        "choiceAttribute"  => "selected",
        "attributeSetting" => 1,
      },
      {
        "choiceIdentifier" => "server",
        "choiceAttribute"  => "selected",
        "attributeSetting" => 1,
      },
    ]

  uninstall launchctl: [ ],
    script:    {
      executable:   "/usr/local/foundationdb/uninstall-FoundationDB.sh",
      must_succeed: false, # A non-0 exit code may be given even if the uninstall succeeds (https://github.com/Homebrew/homebrew-cask/issues/21740#issuecomment-224094946).
      sudo:         true,
    },
    pkgutil:   [
      "FoundationDB-clients",
      "FoundationDB-server"
    ]

  zap rmdir: [
    "/usr/local/foundationdb",
    "/usr/local/etc/foundationdb"
  ]
end

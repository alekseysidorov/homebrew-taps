cask "foundationdb@7.3" do
  arch arm: "arm64"

  name "FoundationDB"
  version "7.3.70"
  sha256 "c09599fff7071a61be0ed5daf36b5a00d00eed533631a5675fffd42e7be394f3"
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

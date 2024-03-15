cask "foundationdb@7.1" do
  arch arm: "arm64" 

  version "7.1.57"
  sha256 "6265c4bae30c0b967225b7e61ed81a653e93282de687b3f7bf7ac314e20ab055"

  url "https://github.com/apple/foundationdb/releases/download/#{version}/FoundationDB-#{version}_#{arch}.pkg"
  name "FoundationDB"
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
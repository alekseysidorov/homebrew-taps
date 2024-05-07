require "language/go"

class Fdbexplorer < Formula
  desc "Utility for exploring FoundationDB"
  homepage "https://github.com/pwood/fdbexplorer"
  version "0.0.21"
  url "https://github.com/pwood/fdbexplorer/archive/refs/tags/v#{version}.tar.gz"
  sha256 "9c536cc3d629e2e91e7ecd71551788080ba1e5f54b76de875958567b48d9c205"
  license "MIT"

  depends_on "go" => :build

  def install
    ENV["GOPATH"] = buildpath
    ENV.append_path "HOMEBREW_LIBRARY_PATHS", "/usr/local/lib"

    system "go", "build", "-o", bin/"fdbexplorer"
    # Fix library path
    system "install_name_tool", "-change", "@rpath/libfdb_c.dylib", "/usr/local/lib/libfdb_c.dylib", bin/"fdbexplorer"
  end

  test do
    assert_match "Usage:", shell_output("#{bin}/fdbexplorer --help")
  end
end

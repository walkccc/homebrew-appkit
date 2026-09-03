# One install serves every app repo. `appkit sync` is how a repo takes an
# upgrade, and it lands as a reviewable diff.
#
#   brew tap walkccc/appkit
#   brew install appkit
#
# The formula lives in this repo and not beside the code because the tap name
# `walkccc/appkit` resolves to `walkccc/homebrew-appkit` and nowhere else. Held
# in the code repo it still worked, but only via `brew tap <name> <url>` — the
# URL on every install line was the whole cost of keeping it there.
#
# A release moves two lines, the tag in `url` and the checksum under it:
#
#   curl -sL <that url> | shasum -a 256
#
# `head` stays under them for tracking main between releases — that is what
# `brew install --HEAD appkit` and `brew upgrade --fetch-HEAD appkit` follow.
class Appkit < Formula
  desc "Store pipeline and shared harness for the apps here"
  homepage "https://github.com/walkccc/appkit"
  url "https://github.com/walkccc/appkit/archive/refs/tags/v1.1.0.tar.gz"
  sha256 "74b28897c52946289c5556eb9abddd037ca5a906807777324f29d76201c31199"
  license "MIT"
  head "https://github.com/walkccc/appkit.git", branch: "main"

  # Everything the program reads at runtime sits beside it: the render tools and
  # their fonts and bezels, the shared configs, the skills, the token ladders.
  # bin/appkit resolves its own realpath to find them, so the symlink below is
  # enough and there is no wrapper script.
  def install
    libexec.install Dir["*"]
    bin.install_symlink libexec/"bin/appkit"
  end

  test do
    assert_match "appkit", shell_output("#{bin}/appkit help")
  end
end

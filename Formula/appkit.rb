# One install serves every app repo. `appkit sync` is how a repo takes an
# upgrade, and it lands as a reviewable diff.
#
#   brew tap walkccc/appkit
#   brew install --HEAD appkit
#
# The formula lives in this repo and not beside the code because the tap name
# `walkccc/appkit` resolves to `walkccc/homebrew-appkit` and nowhere else. Held
# in the code repo it still worked, but only via `brew tap <name> <url>` — the
# URL on every install line was the whole cost of keeping it there.
#
# On the first tagged release, add the two stable lines and drop --HEAD:
#
#   url "https://github.com/walkccc/appkit/archive/refs/tags/v1.0.0.tar.gz"
#   sha256 "<brew fetch --build-from-source appkit prints it>"
class Appkit < Formula
  desc "Store pipeline and shared harness for the apps here"
  homepage "https://github.com/walkccc/appkit"
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

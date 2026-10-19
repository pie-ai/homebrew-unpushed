# Template rendered by .github/workflows/release.yml and pushed to
# pie-ai/homebrew-unpushed. Do not edit the copy in the tap by hand.
class Unpushed < Formula
  desc "Overview of unpushed commits across many git checkouts"
  homepage "https://github.com/pie-ai/unpushed"
  version "0.2.1"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_arm do
      url "https://github.com/pie-ai/unpushed/releases/download/v#{version}/unpushed-aarch64-apple-darwin.tar.gz"
      sha256 "9ca6e0de6d02c5690c92f3b22dbd385bef06d2f540b98560d56f8cd5b14b6fb0"
    end
    on_intel do
      url "https://github.com/pie-ai/unpushed/releases/download/v#{version}/unpushed-x86_64-apple-darwin.tar.gz"
      sha256 "a5f9b780e2bf1792ce7b7dc595163c31a813b1eb45eb51ae1b8cf756364dd467"
    end
  end

  def install
    # libgit2 is compiled into the binary, so there is no depends_on for it.
    bin.install "unpushed"
    man1.install "unpushed.1"
    bash_completion.install "unpushed.bash" => "unpushed"
    zsh_completion.install "_unpushed"
    fish_completion.install "unpushed.fish"
    doc.install "README.md", "CHANGELOG.md", "THIRD-PARTY-LICENSES.md"
  end

  def caveats
    <<~EOS
      The 'g' key opens gitui in the selected repository. It is optional:
        brew install gitui
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/unpushed --version")
    # An empty directory holds no checkouts, which is an error by design.
    assert_match "no git checkouts", shell_output("#{bin}/unpushed #{testpath} 2>&1", 1)
  end
end

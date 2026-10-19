# Template rendered by .github/workflows/release.yml and pushed to
# pie-ai/homebrew-unpushed. Do not edit the copy in the tap by hand.
class Unpushed < Formula
  desc "Overview of unpushed commits across many git checkouts"
  homepage "https://github.com/pie-ai/unpushed"
  version "0.0.1"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_arm do
      url "https://github.com/pie-ai/unpushed/releases/download/v#{version}/unpushed-aarch64-apple-darwin.tar.gz"
      sha256 "22cfb271ee4df9a4e31fdeb49c75d07a6acc33457b3334dc4af117cc578dff9b"
    end
    on_intel do
      url "https://github.com/pie-ai/unpushed/releases/download/v#{version}/unpushed-x86_64-apple-darwin.tar.gz"
      sha256 "b2592a2d6a80e1ff83a975995b4c9938e4ae42cc59321634c186d266bb7682b0"
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

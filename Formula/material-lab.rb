# Homebrew formula for the material-lab binary release.
class MaterialLab < Formula
  desc "Turn a photograph into editable PBR texture maps, on your Mac"
  homepage "https://github.com/theisegoria/material-lab-cli"
  url "https://github.com/theisegoria/material-lab-cli/releases/download/v1.2.0/material-lab-1.2.0-macos-arm64.tar.gz"
  version "1.2.0"
  sha256 "581f3c87f5a3636c1a8f289a512530ecea1b0860549d99c45aaa93acff98ad57"

  depends_on arch: :arm64
  depends_on :macos

  def install
    bin.install "bin/material-lab"
    (share/"material-lab").install Dir["share/material-lab/*"]
    man1.install "share/man/man1/material-lab.1"
    zsh_completion.install "share/zsh/site-functions/_material-lab"
    bash_completion.install "share/bash-completion/completions/material-lab"
    fish_completion.install "share/fish/vendor_completions.d/material-lab.fish"
  end

  test do
    assert_match "material-lab #{version}", shell_output("#{bin}/material-lab --version")
    # --learned must find the bundled model when run by bare name from PATH (the 1.0.0 bug).
    with_env(PATH: "#{bin}:#{ENV["PATH"]}", HOME: testpath.to_s) do
      assert_match "material-lab #{version}", shell_output("material-lab --learned --version")
    end
  end
end

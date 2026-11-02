class ClaudeTandem < Formula
  desc "Run several Claude accounts side by side on a Mac, and hand work between them"
  homepage "https://github.com/altsang/claude-tandem"
  url "https://github.com/altsang/claude-tandem/archive/refs/tags/v1.1.2.tar.gz"
  sha256 "500392a781d506b3d09e47840706d24e1d12a82e96e1e21beeea357a03f5b76d"
  license "MIT"
  head "https://github.com/altsang/claude-tandem.git", branch: "main"

  depends_on :macos
  depends_on "pillow"
  depends_on "python@3.14"

  def install
    libexec.install "bin", "macos", "skills", "VERSION"
    # The scripts find their own files from their path, and record it in the menu-bar app and
    # the Dock launchers they build. Point them at opt/, which survives upgrades; the Cellar doesn't.
    python = formula_opt_libexec("python@3.14")/"bin"
    %w[tandem mirror claude-profile].each do |cmd|
      (bin/cmd).write <<~SH
        #!/bin/bash
        PATH="#{python}:$PATH" exec "#{opt_libexec}/bin/#{cmd}" "$@"
      SH
    end
  end

  def caveats
    <<~EOS
      Add the /handoff skill to each Claude account you hand work from:
        tandem skill        # shows the file; then Claude › Settings › Skills › Add

      The app (menu bar and window) is built on this Mac, and needs the Command Line Tools:
        xcode-select --install
        tandem menubar
      Then turn on Open at Login in its Settings, so it hears about handoffs.
      No app wanted, or a server? `tandem watch --install` runs its background half headless.
    EOS
  end

  test do
    assert_equal version.to_s, shell_output("#{bin}/tandem version").strip
    assert_match "SKILL.md", shell_output("#{bin}/tandem skill --print")
    system formula_opt_libexec("python@3.14")/"bin/python3", "-c", "import PIL"
  end
end

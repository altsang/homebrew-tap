class ClaudeTandem < Formula
  desc "Run several Claude accounts side by side on a Mac, and hand work between them"
  homepage "https://github.com/altsang/claude-tandem"
  url "https://github.com/altsang/claude-tandem/archive/refs/tags/v1.0.0.tar.gz"
  sha256 "531f54bbbdc8a0bbfe6990635e182b0ff3a47db66a8732102374f040ef6dcbd6"
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

      The menu-bar app is built on this Mac, and needs the Command Line Tools:
        xcode-select --install
        tandem menubar
    EOS
  end

  test do
    assert_equal version.to_s, shell_output("#{bin}/tandem version").strip
    assert_match "SKILL.md", shell_output("#{bin}/tandem skill --print")
    system formula_opt_libexec("python@3.14")/"bin/python3", "-c", "import PIL"
  end
end

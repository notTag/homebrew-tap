class SpaceTag < Formula
  desc "Tag macOS spaces from your git project (yabai + sketchybar)"
  homepage "https://github.com/notTag/Space-Tag-CLI"
  url "https://github.com/notTag/Space-Tag-CLI/archive/refs/tags/v0.4.0.tar.gz"
  sha256 "eea7764a6c55784fb06489ca2f32c1e1af7790284572f626be1c082ea519347e"
  license "MIT"

  depends_on "jq"
  depends_on :macos
  depends_on "FelixKratz/formulae/sketchybar"
  depends_on "koekeishiya/formulae/yabai"

  def install
    # bin/space-tag resolves its own symlink back to here to find ../VERSION and
    # ../uninstall.sh, so the repo layout has to survive intact under the prefix.
    prefix.install "bin", "shell", "sketchybar", "yabai", "VERSION", "install.sh", "uninstall.sh"
  end

  def caveats
    <<~EOS
      Homebrew installs the files; it cannot symlink into ~/.config or touch your
      shell rc. Finish setup by running the installer from the stable opt path:

        "#{opt_prefix}/install.sh"

      Then start the services and reload your shell:

        yabai --start-service
        brew services start sketchybar
        exec $SHELL

      yabai needs Accessibility permission on first run:
      System Settings > Privacy & Security > Accessibility.

      To undo: space-tag uninstall
    EOS
  end

  test do
    assert_equal version.to_s, shell_output("#{bin}/space-tag version").strip
    assert_match "tag macOS spaces", shell_output("#{bin}/space-tag help")
  end
end

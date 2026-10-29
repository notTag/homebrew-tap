class SpaceTag < Formula
  desc "Tag macOS spaces from your git project (yabai + sketchybar)"
  homepage "https://github.com/notTag/Space-Tag-CLI"
  # The release asset, not the source archive: only it carries the prebuilt
  # Swift helpers (rename-overlay, display-probe), so users never need Xcode.
  url "https://github.com/notTag/Space-Tag-CLI/releases/download/v0.5.0/space-tag-cli-0.5.0.tar.gz"
  sha256 "71a75ff8cd0811d31809e865abb8f480d5ad99842bb40d541e3f05a177037b55"
  license "MIT"

  # yabai and sketchybar live in third-party taps, which brew refuses to resolve
  # as dependencies without an explicit `brew trust`. install.sh already installs
  # both from their pinned official taps, so declaring them here only buys users
  # a trust wall.
  depends_on "jq"
  depends_on :macos

  def install
    # bin/space-tag resolves its own symlink back to here to find ../VERSION and
    # ../uninstall.sh, so the repo layout has to survive intact under the prefix.
    prefix.install "bin", "shell", "sketchybar", "yabai", "scripts", "VERSION", "install.sh", "uninstall.sh"
  end

  def caveats
    <<~EOS
      Homebrew installs the files; it cannot symlink into ~/.config or touch your
      shell rc. Finish setup by running the installer from the stable opt path —
      it also installs yabai and sketchybar from their official taps:

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

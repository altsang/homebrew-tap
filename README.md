# altsang/tap

Homebrew formulae and casks by [@altsang](https://github.com/altsang).

```bash
brew install altsang/tap/claude-tandem
brew install --cask altsang/tap/uvim-fork
```

| Formula / cask | What it is |
|---|---|
| [claude-tandem](https://github.com/altsang/claude-tandem) | Run several Claude accounts side by side on a Mac, and hand work between them |
| [uvim-fork](https://github.com/altsang/uvim) (cask) | Fork of [uvim](https://github.com/celve/uvim): Vim's modal editing in any app's text fields, plus clipboard sync and per-app settings |

uvim-fork is not notarized; the cask clears the quarantine flag on install. It replaces upstream's `uvim` cask (same bundle ID), and updates come only through `brew upgrade`. On first launch, grant uvim Accessibility and Input Monitoring in System Settings › Privacy & Security.

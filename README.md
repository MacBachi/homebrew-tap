# homebrew-tap

Homebrew casks for my own macOS apps.

```bash
brew install --cask macbachi/tap/blueskyship
```

| Cask | App |
|---|---|
| `blueskyship` | [BlueSkyship](https://github.com/MacBachi/BlueSkyship) |

## Updates

The workflow `bump casks` runs every 3 hours. For each cask it reads the latest release of the repo in `homepage`; when the version differs it downloads the asset, writes the new `version` and `sha256` and commits. A plain `brew upgrade` then picks it up.

Run it by hand with `gh workflow run bump.yml -R MacBachi/homebrew-tap`, or locally with `scripts/bump.sh`.

A new cask needs `homepage` pointing at its GitHub repo and a `url` with `#{version}` where the tag (without a leading `v`) goes.

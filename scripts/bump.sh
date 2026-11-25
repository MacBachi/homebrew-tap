#!/usr/bin/env bash
# Sets version and sha256 of every cask to the latest GitHub release of its homepage repo.
# Needs: gh (authenticated), curl, shasum. Prints the casks it changed.
set -euo pipefail
cd "$(dirname "$0")/.."

for cask in Casks/*.rb; do
  repo=$(sed -n 's|^  homepage "https://github.com/\([^"]*\)"|\1|p' "$cask")
  [ -n "$repo" ] || { echo "skip $cask: homepage is not a GitHub repo" >&2; continue; }
  tag=$(gh api "repos/$repo/releases/latest" --jq .tag_name)
  new=${tag#v}
  old=$(sed -n 's/^  version "\(.*\)"/\1/p' "$cask")
  [ -n "$old" ] || { echo "skip $cask: no pinned version" >&2; continue; }
  [ "$new" != "$old" ] || continue

  url=$(sed -n 's/^  url "\(.*\)"/\1/p' "$cask")
  url=${url//'#{version}'/$new}
  tmp=$(mktemp)
  curl -fsSL -o "$tmp" "$url"
  sha=$(shasum -a 256 "$tmp" | cut -d' ' -f1)
  rm -f "$tmp"

  sed -i.bak -e "s/^  version \".*\"/  version \"$new\"/" -e "s/^  sha256 \".*\"/  sha256 \"$sha\"/" "$cask"
  rm -f "$cask.bak"
  echo "$(basename "$cask" .rb) $old -> $new"
done

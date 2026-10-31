#!/usr/bin/env bash
# Symlink every skill in skills/ into the global skill folders of Claude Code
# and Codex, so a `git pull` here updates both. Safe to re-run: existing links
# are refreshed, links to skills removed from the repo are cleaned up, and real
# folders with the same name are left alone.
set -euo pipefail

repo="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
targets=("$HOME/.claude/skills" "$HOME/.codex/skills")

for target in "${targets[@]}"; do
    mkdir -p "$target"

    for link in "$target"/*; do
        if [[ -L "$link" && "$(readlink "$link")" == "$repo/skills/"* && ! -e "$link" ]]; then
            rm "$link"
            echo "removed  $link"
        fi
    done

    for skill in "$repo"/skills/*/; do
        name="$(basename "$skill")"
        dest="$target/$name"
        if [[ -e "$dest" && ! -L "$dest" ]]; then
            echo "skipped  $dest (a real folder exists; remove it to link this skill)" >&2
            continue
        fi
        ln -sfn "${skill%/}" "$dest"
        echo "linked   $dest"
    done
done

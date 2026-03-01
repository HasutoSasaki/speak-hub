#!/usr/bin/env bash
set -euo pipefail

# slides/ 配下の各スライドディレクトリに
# ルートの components/ へのシンボリックリンクを作成する
#
# Usage:
#   bash scripts/link-components.sh            # 全スライド対象
#   bash scripts/link-components.sh blue-period # 指定スライドのみ

SLIDES_DIR="slides"
COMPONENTS_REL="../../components"

link_components() {
  local dir="$1"
  local target="$dir/components"

  if [[ -L "$target" ]]; then
    echo "  skip: $target (symlink already exists)"
    return
  fi

  if [[ -d "$target" ]]; then
    rm -rf "$target"
    echo "  replaced: $target (removed copy, created symlink)"
  else
    echo "  created: $target"
  fi

  ln -s "$COMPONENTS_REL" "$target"
}

if [[ $# -gt 0 ]]; then
  for name in "$@"; do
    slide_dir="$SLIDES_DIR/$name"
    if [[ ! -d "$slide_dir" ]]; then
      echo "ERROR: $slide_dir not found, skipping"
      continue
    fi
    link_components "$slide_dir"
  done
else
  for slide_dir in "$SLIDES_DIR"/*/; do
    [[ -d "$slide_dir" ]] || continue
    link_components "${slide_dir%/}"
  done
fi

#!/usr/bin/env bash
set -euo pipefail

REPO_NAME="speak-hub"
SLIDES_DIR="slides"
DIST_DIR="dist"

mkdir -p "$DIST_DIR"

# Build specified slides (skip if no arguments)
for name in "$@"; do
  entry="$SLIDES_DIR/$name/slides.md"
  if [[ ! -f "$entry" ]]; then
    echo "ERROR: $entry not found, skipping"
    continue
  fi
  echo "==> Building: $name"
  pnpm slidev build "$entry" --base "/$REPO_NAME/$name/" --out "../../$DIST_DIR/$name"
done

# Generate index.html from all directories in dist/
dirs=()
for d in "$DIST_DIR"/*/; do
  [[ -d "$d" ]] && dirs+=("$(basename "$d")")
done

cat > "$DIST_DIR/index.html" <<'HEADER'
<!DOCTYPE html>
<html lang="ja">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Speak Hub</title>
<style>
  * { margin: 0; padding: 0; box-sizing: border-box; }
  body { font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, sans-serif; background: #0f0f0f; color: #e0e0e0; min-height: 100vh; padding: 3rem 1.5rem; }
  h1 { text-align: center; font-size: 2rem; margin-bottom: 2rem; font-weight: 600; }
  .grid { max-width: 720px; margin: 0 auto; display: flex; flex-direction: column; gap: 0.75rem; }
  a { display: block; padding: 1rem 1.5rem; background: #1a1a1a; border: 1px solid #2a2a2a; border-radius: 8px; color: #e0e0e0; text-decoration: none; transition: background 0.15s, border-color 0.15s; }
  a:hover { background: #222; border-color: #444; }
</style>
</head>
<body>
<h1>Speak Hub</h1>
<div class="grid">
HEADER

for name in "${dirs[@]}"; do
  echo "  <a href=\"./$name/\">$name</a>" >> "$DIST_DIR/index.html"
done

cat >> "$DIST_DIR/index.html" <<'FOOTER'
</div>
</body>
</html>
FOOTER

echo "==> Done! index.html generated with ${#dirs[@]} slides."

#!/usr/bin/env bash
# install-nvim.sh — Install Neovim 0.11.x (or latest) from tarball and wire it into .bashrc
#
# Usage:
#   chmod +x install-nvim.sh
#   ./install-nvim.sh          # installs latest stable
#   ./install-nvim.sh 0.11.0   # installs a specific version
#
# After:
# source ~/.bashrc

set -euo pipefail

VERSION="${1:-}"
INSTALL_DIR="$HOME/.local/nvim"

# ---------- resolve version ----------
if [[ -z "$VERSION" ]]; then
  echo "→ No version specified, fetching latest stable tag…"
  VERSION=$(curl -sI https://github.com/neovim/neovim/releases/latest \
    | grep -i '^location:' | sed 's#.*/tag/v##;s/\r//')
  echo "  Latest version: v$VERSION"
fi

TARBALL="nvim-linux-x86_64.tar.gz"
URL="https://github.com/neovim/neovim/releases/download/v${VERSION}/${TARBALL}"

# ---------- download ----------
echo "→ Downloading Neovim v${VERSION}…"
TMP=$(mktemp -d)
curl -fL "$URL" -o "$TMP/$TARBALL"

# ---------- install ----------
echo "→ Installing to $INSTALL_DIR …"
rm -rf "$INSTALL_DIR"
mkdir -p "$INSTALL_DIR"
tar xzf "$TMP/$TARBALL" -C "$INSTALL_DIR" --strip-components=1
rm -rf "$TMP"

# ---------- update .bashrc ----------
MARKER="# >>> neovim >>>"
END_MARKER="# <<< neovim <<<"
BASHRC="$HOME/.bashrc"

BLOCK=$(cat <<'EOF'
# >>> neovim >>>
export PATH="$HOME/.local/nvim/bin:$PATH"
alias vim='nvim'
alias vi='nvim'
# <<< neovim <<<
EOF
)

if grep -qF "$MARKER" "$BASHRC" 2>/dev/null; then
  echo "→ Updating existing Neovim block in .bashrc …"
  # Remove old block and re-add
  sed -i "/$MARKER/,/$END_MARKER/d" "$BASHRC"
fi

echo "→ Adding Neovim to .bashrc …"
printf '\n%s\n' "$BLOCK" >> "$BASHRC"

# ---------- verify ----------
echo ""
echo "✔ Installed: $("$INSTALL_DIR/bin/nvim" --version | head -1)"
echo "✔ .bashrc updated — run 'source ~/.bashrc' or open a new terminal."

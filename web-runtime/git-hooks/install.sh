#!/bin/bash

# CHRONOS Git Hook Installer - Web Runtime Version
# Installs git hooks for CHRONOS stamp injection

set -e

echo "CHRONOS Git Hook Installer - Web Runtime Version"
echo "================================================="
echo

# Get the directory where this script is located
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
WEB_RUNTIME_DIR="$(dirname "$SCRIPT_DIR")"

# Check if we're in a git repository
if ! git rev-parse --git-dir > /dev/null 2>&1; then
  echo "Error: Not in a git repository"
  echo "Please run this script from within a git repository"
  exit 1
fi

# Get git root directory
GIT_ROOT=$(git rev-parse --show-toplevel)
CLAUDE_HOOKS_DIR="$GIT_ROOT/.claude/hooks"

echo "Git repository: $GIT_ROOT"
echo "Claude hooks directory: $CLAUDE_HOOKS_DIR"
echo

# Create .claude/hooks directory if it doesn't exist
if [ ! -d "$CLAUDE_HOOKS_DIR" ]; then
  echo "Creating .claude/hooks directory..."
  mkdir -p "$CLAUDE_HOOKS_DIR"
fi

# Install tool-result-hook.sh
HOOK_SOURCE="$SCRIPT_DIR/tool-result-hook.sh"
HOOK_DEST="$CLAUDE_HOOKS_DIR/tool-result-hook.sh"

if [ -f "$HOOK_DEST" ]; then
  echo "Warning: Hook already exists at $HOOK_DEST"
  read -p "Overwrite? (y/N) " -n 1 -r
  echo
  if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    echo "Installation cancelled"
    exit 0
  fi
fi

echo "Installing tool-result-hook.sh..."
cp "$HOOK_SOURCE" "$HOOK_DEST"
chmod +x "$HOOK_DEST"

echo "✓ Hook installed successfully"
echo

# Initialize cognitive tracker
echo "Initializing cognitive tracker..."
cd "$GIT_ROOT"
node "$WEB_RUNTIME_DIR/cognitive-tracker.js" init

echo
echo "Installation complete!"
echo
echo "The CHRONOS git hook is now active and will inject timestamps"
echo "into your git commits after every Claude Code tool execution."
echo
echo "To verify installation:"
echo "  ls -la $CLAUDE_HOOKS_DIR"
echo
echo "To test:"
echo "  node $WEB_RUNTIME_DIR/cognitive-tracker.js record 'Testing' 'manual' 'Test event'"
echo "  node $WEB_RUNTIME_DIR/cognitive-tracker.js latest"
echo
echo "To view statistics:"
echo "  node $WEB_RUNTIME_DIR/cognitive-tracker.js stats"
echo

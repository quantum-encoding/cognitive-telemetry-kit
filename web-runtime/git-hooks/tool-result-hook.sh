#!/bin/bash

# CHRONOS Git Hook - Web Runtime Version
# Injects CHRONOS stamps into git commits after tool completion
#
# This hook should be installed in .claude/hooks/tool-result-hook.sh
# It will be called after every tool execution in Claude Code

# Get the directory where this script is located
HOOK_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
WEB_RUNTIME_DIR="$(dirname "$HOOK_DIR")"

# Path to cognitive tracker
TRACKER="$WEB_RUNTIME_DIR/cognitive-tracker.js"

# Check if we're in a git repository
if ! git rev-parse --git-dir > /dev/null 2>&1; then
  exit 0
fi

# Check if node is available
if ! command -v node &> /dev/null; then
  echo "Warning: Node.js not found, CHRONOS stamps disabled" >&2
  exit 0
fi

# Check if cognitive tracker exists
if [ ! -f "$TRACKER" ]; then
  echo "Warning: Cognitive tracker not found at $TRACKER" >&2
  exit 0
fi

# Get the latest cognitive state
LATEST_STATE=$(node "$TRACKER" latest 2>/dev/null)

# If no state is available, generate a default CHRONOS stamp
if [ -z "$LATEST_STATE" ] || [ "$LATEST_STATE" = "No states recorded" ]; then
  # Generate default stamp
  LATEST_STATE=$(node "$WEB_RUNTIME_DIR/chronos-stamp.js" \
    --state "Unknown" \
    --action "tool-completion" \
    --description "Hook execution" 2>/dev/null)
fi

# If we still don't have a stamp, exit silently
if [ -z "$LATEST_STATE" ]; then
  exit 0
fi

# Echo the CHRONOS stamp (this will be captured by git hook system)
echo "$LATEST_STATE"

exit 0

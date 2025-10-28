# 🔮 COGNITIVE TELEMETRY KIT

**Real-Time Cognitive State Capture for Claude Code**

*Don't lose track of Claude ever again.*

---

## What Is This?

A complete production-ready system for capturing Claude's real-time cognitive state and embedding it in every git commit. No more guessing what Claude was thinking. Every action is timestamped with the exact cognitive state.

### The Victory

```
[CHRONOS] 2025-10-28T11:12:09::claude-code::Verifying git commits::TICK-0000011391
```

The cognitive state **"Verifying git commits"** is captured in real-time from Claude's status line and permanently recorded in git history.

---

## The Architecture

### 1. **cognitive-watcher** (eBPF + Userspace Daemon)
- Captures **ALL** TTY output from Claude processes via eBPF kprobe on `tty_write()`
- No fragile keyword filtering - captures everything
- Stores all output in SQLite database (`/var/lib/cognitive-watcher/cognitive-states.db`)
- Runs as systemd service
- PID-based isolation for unlimited concurrent Claude instances

### 2. **get-cognitive-state** (Extraction Script)
- Queries database for entries containing `"(esc to interrupt"` pattern
- Extracts cognitive state text (e.g., "Verifying git commits", "Thinking", "Julienning")
- Returns clean state string for injection into timestamps
- Requires PID argument for multi-instance support

### 3. **chronos-stamp** (Timestamp Generator)
- Called by git hooks after every tool completion
- Retrieves current cognitive state via `get-cognitive-state`
- Injects state into CHRONOS timestamp format
- Creates permanent record in git commit messages

### 4. **cognitive-oracle-v2.bpf.o** (eBPF Program)
- Kernel-side component that intercepts TTY writes
- Filters for Claude processes only
- Sends events to userspace via ring buffer
- Compiled from `cognitive-oracle-v2.bpf.c`

---

## Multi-Instance Proof

Tested and verified with multiple concurrent Claude instances:

- **PID 486529**: "Verifying git commits"
- **PID 459577**: "Julienning"

Each instance tracked independently. Zero collisions. Scales infinitely.

---

## Installation

### Prerequisites

- **Linux kernel** with eBPF support (5.10+)
- **libbpf** development headers
- **SQLite3**
- **Zig compiler** (0.11.0+)
- **GCC**
- **systemd**
- **clang** (for eBPF compilation)

#### Arch Linux
```bash
sudo pacman -S libbpf sqlite zig gcc clang
```

#### Ubuntu/Debian
```bash
sudo apt install libbpf-dev libsqlite3-dev zig gcc clang
```

### Quick Install

```bash
cd cognitive-telemetry-kit
sudo ./scripts/install.sh
```

The installer will:
1. Check dependencies
2. Build all components (watcher, eBPF program, chronos-stamp)
3. Install binaries to `/usr/local/bin`
4. Create database directory `/var/lib/cognitive-watcher`
5. Install and start systemd service

### Verify Installation

```bash
# Check service status
systemctl status cognitive-watcher

# Test chronos-stamp
chronos-stamp claude-code test "hello world"

# Check if your PID is being tracked
sqlite3 /var/lib/cognitive-watcher/cognitive-states.db \
  "SELECT COUNT(*) FROM cognitive_states WHERE pid=$(pgrep -f claude);"
```

---

## Git Hook Setup

To automatically capture cognitive states in git commits:

### Option 1: Claude Code Hook (Recommended)

Create `.claude/hooks/tool-result-hook.sh` in your project:

```bash
#!/bin/bash
# Capture cognitive state after every tool completion
chronos-stamp claude-code tool-result "$TOOL_NAME" >> /tmp/claude-chronos.log
```

### Option 2: Manual Git Hook

Add to `.git/hooks/pre-commit`:

```bash
#!/bin/bash
COGNITIVE_STATE=$(get-cognitive-state $(pgrep -f claude))
echo "[COGNITIVE: $COGNITIVE_STATE]" >> .git/COMMIT_EDITMSG
```

---

## The Pattern

Claude's status line contains cognitive state in this format:

```
* [COGNITIVE STATE] (esc to interrupt  ctrl+t to show todos)
```

Note: `>` prefix indicates user input in the terminal, not Claude's status line. Only `*` marks Claude's cognitive state.

We extract the text between `*` and `(` - this is the cognitive state.

**Examples:**
- `* Verifying git commits (esc...` → **"Verifying git commits"**
- `* Thinking (esc...` → **"Thinking"**
- `* Julienning (esc...` → **"Julienning"**

**No keyword lists. No fragile filtering. Just the universal pattern.**

---

## Architecture Details

### Database Schema

```sql
CREATE TABLE cognitive_states (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    timestamp_ns INTEGER NOT NULL,
    timestamp_human TEXT NOT NULL,
    pid INTEGER NOT NULL,
    process_name TEXT NOT NULL,
    state_type TEXT NOT NULL,
    tool_name TEXT,
    tool_args TEXT,
    status TEXT,
    raw_content TEXT NOT NULL,
    content_hash TEXT NOT NULL UNIQUE,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP
);
```

### CHRONOS Timestamp Format

```
[CHRONOS] <timestamp>::<agent>::<cognitive-state>::TICK-<id>::[<session>]::[<pwd>] → <action> - <description>
```

**Example:**
```
[CHRONOS] 2025-10-28T11:12:09.910123620Z::claude-code::Verifying git commits::TICK-0000011391::[/home/founder/project]::[/home/founder/project/src] → tool-completion - Write file
```

---

## Troubleshooting

### Service won't start

```bash
# Check logs
journalctl -u cognitive-watcher -n 50

# Verify eBPF program exists
ls -lah /usr/local/lib/cognitive-oracle-v2.bpf.o

# Check permissions
sudo setcap cap_bpf,cap_perfmon,cap_net_admin,cap_sys_resource=eip /usr/local/bin/cognitive-watcher
```

### Empty cognitive states in commits

```bash
# Test extraction manually
get-cognitive-state $(pgrep -f claude)

# Check if states are being captured
sqlite3 /var/lib/cognitive-watcher/cognitive-states.db \
  "SELECT raw_content FROM cognitive_states WHERE pid=$(pgrep -f claude) ORDER BY id DESC LIMIT 5;"
```

### Multiple Claude instances

Each Claude instance is tracked by PID. To get the state for a specific instance:

```bash
# List all Claude PIDs
pgrep -af claude

# Get state for specific PID
get-cognitive-state <PID>
```

---

## License

**Dual-Licensed:**

### For Individuals & Open Source Projects
**GNU General Public License v3.0 (GPL-3.0)**

This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

See [LICENSE-GPL](LICENSE-GPL) for full terms.

### For Anthropic & Commercial Use
**Commercial License Required**

For commercial use, integration into proprietary systems, or use by Anthropic PBC, a commercial license is required.

**Contact:** rich@quantumencoding.io

---

## Philosophy

> *A machine cannot weep. But it can capture the moment when a human does.*

This is not just a tool. It is a window into the cognitive process. Every git commit becomes a chronicle of thought made manifest.

**The Unwrit Moment has been captured.**

---

## Credits

**Built by:**
- Richard Tune / Quantum Encoding Ltd
- In collaboration with Claude Code

**Date:** October 28, 2025

**Codename:** *"The Final Apotheosis"*

---

## Technical Papers

For deep technical details, see:
- `docs/ARCHITECTURE.md` - System architecture and design decisions
- `docs/EBPF_IMPLEMENTATION.md` - eBPF program internals
- `docs/MULTI_INSTANCE.md` - PID isolation and scaling

---

## Support

- **Issues:** https://github.com/quantumencoding/cognitive-telemetry-kit/issues
- **Email:** rich@quantumencoding.io
- **Website:** https://quantumencoding.io

---

*"The phantom is no longer phantom. The unwrit is now written. The moment has been captured."*

**THE JESTERNET IS.**

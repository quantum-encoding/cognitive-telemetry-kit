# Cognitive Telemetry Kit - Web Runtime Version

## Architecture Overview

This is a web-compatible version of the cognitive telemetry kit designed to work in Claude Code's web runtime environment without requiring Linux kernel access, eBPF, or systemd.

## Key Differences from Linux Version

| Component | Linux Version | Web Runtime Version |
|-----------|---------------|---------------------|
| **State Capture** | eBPF kprobe on tty_write() | Direct API calls + hook integration |
| **Storage** | SQLite in /var/lib/ | JSON file storage in project .cognitive/ |
| **Language** | C + Zig + eBPF | JavaScript/Node.js |
| **Process Isolation** | Linux PID | Session UUID |
| **Daemon** | systemd service | Node.js process or serverless functions |
| **IPC** | D-Bus | HTTP REST API / WebSockets |
| **Git Integration** | Local git hooks | Local hooks + optional webhook relay |
| **Visualization** | GNOME Shell extension | Web dashboard |

## Components

### 1. CHRONOS Stamp Generator (JavaScript)
**File:** `web-runtime/chronos-stamp.js`
- Port of the Zig timestamp generator
- Generates 4-dimensional timestamps
- No dependencies, pure JavaScript
- Can run in browser or Node.js

### 2. Cognitive State Tracker
**File:** `web-runtime/cognitive-tracker.js`
- Simple API for recording cognitive states
- File-based storage (`.cognitive/states.json`)
- Session-based isolation (UUID instead of PID)
- Automatic state deduplication

### 3. Git Hook Integration
**File:** `web-runtime/git-hooks/post-tool.sh`
- Integrates with Claude Code's git hooks
- Calls JavaScript CHRONOS generator
- Injects timestamps into commit messages
- Works in web runtime environment

### 4. Telemetry Sync Server (Optional)
**File:** `web-runtime/sync-server.js`
- Simple HTTP server for multi-agent sync
- REST API for state submission
- Aggregates states from multiple agents
- Can run locally or in cloud

### 5. Web Dashboard (Optional)
**File:** `web-runtime/dashboard/`
- Simple HTML/JS dashboard
- Real-time state visualization
- Works with sync server
- No framework dependencies

## Data Flow

```
Claude Code Web Runtime
    ↓
Direct API Call (cognitive-tracker.recordState())
    ↓
Local Storage (.cognitive/states.json)
    ↓
Git Hook (post-tool.sh)
    ↓
CHRONOS Stamp Generator
    ↓
Git Commit with Timestamp
    ↓ (optional)
Sync Server (HTTP POST)
    ↓
Aggregated Database
    ↓
Web Dashboard
```

## File Structure

```
cognitive-telemetry-kit/
├── web-runtime/
│   ├── chronos-stamp.js          # CHRONOS timestamp generator
│   ├── cognitive-tracker.js      # State tracking API
│   ├── sync-server.js            # Optional HTTP sync server
│   ├── git-hooks/
│   │   ├── install.sh            # Hook installation script
│   │   └── post-tool.sh          # Git hook for CHRONOS stamps
│   ├── dashboard/
│   │   ├── index.html            # Web dashboard
│   │   ├── app.js                # Dashboard logic
│   │   └── styles.css            # Dashboard styles
│   └── cli/
│       ├── export.js             # Export to CSV
│       ├── stats.js              # Show statistics
│       └── query.js              # Query states
```

## CHRONOS Stamp Format (Unchanged)

```
[CHRONOS] <timestamp>::<agent>::<cognitive-state>::TICK-<id>::[<session>]::[<pwd>] → <action> - <description>
```

Example:
```
[CHRONOS] 2025-11-04T14:23:45.123456789Z::claude-code::Thinking deeply::TICK-0000000042::[web-session-abc123]::[/home/user/project] → tool-completion - Write file: src/main.js
```

## Storage Schema

**File:** `.cognitive/states.json`
```json
{
  "session_id": "uuid-here",
  "agent": "claude-code",
  "states": [
    {
      "tick": 1,
      "timestamp": "2025-11-04T14:23:45.123456789Z",
      "timestamp_ns": 1730729025123456789,
      "cognitive_state": "Thinking deeply",
      "action": "tool-completion",
      "description": "Write file: src/main.js",
      "working_dir": "/home/user/project",
      "session_path": "/home/user/project",
      "hash": "sha256-of-state"
    }
  ]
}
```

## API Usage

### Recording a State

```javascript
const tracker = require('./cognitive-tracker.js');

// Initialize (auto-creates session)
await tracker.init();

// Record a state
await tracker.recordState({
  cognitiveState: "Thinking deeply",
  action: "tool-completion",
  description: "Write file: src/main.js"
});

// Get latest state for git hook
const latest = await tracker.getLatestState();
console.log(latest.chronosStamp);
```

### Syncing to Server

```javascript
// Push local states to sync server
await tracker.syncToServer('https://sync.example.com/api/states');

// Pull states from other agents
await tracker.syncFromServer('https://sync.example.com/api/states');
```

## Installation

### Local Installation (Single Agent)

```bash
cd cognitive-telemetry-kit/web-runtime
npm install
node git-hooks/install.sh
```

### Global Sync Server Setup

```bash
# Start sync server
cd cognitive-telemetry-kit/web-runtime
node sync-server.js --port 3000

# Configure agents to sync
export COGNITIVE_SYNC_URL=http://localhost:3000
```

### Cloud Deployment

```bash
# Deploy to cloud (Vercel, Netlify, etc.)
cd cognitive-telemetry-kit/web-runtime
vercel deploy

# Or use Docker
docker build -t cognitive-sync .
docker run -p 3000:3000 cognitive-sync
```

## Advantages Over Linux Version

1. **Platform Independent** - Works on any OS with Node.js
2. **No Root Required** - No kernel access needed
3. **Easy Deployment** - Simple npm install
4. **Cloud Ready** - Can run as serverless function
5. **Web Native** - Built for web runtime from ground up

## Limitations

1. **No Automatic Capture** - States must be recorded via API calls
2. **No System-Wide Monitoring** - Only tracks what's explicitly recorded
3. **File-Based Storage** - Less efficient than SQLite for large datasets
4. **Manual Integration** - Requires adding API calls to Claude's runtime

## Future Enhancements

1. **WebSocket Support** - Real-time state streaming
2. **PostgreSQL Backend** - Optional database for production use
3. **Anthropic Integration** - Native Claude Code cognitive state events
4. **Machine Learning** - Pattern recognition and anomaly detection
5. **Multi-Agent Coordination** - Distributed consensus on cognitive states

## Compatibility Matrix

| Feature | Linux | Web Runtime | Status |
|---------|-------|-------------|--------|
| CHRONOS Stamps | ✓ | ✓ | Complete |
| Git Integration | ✓ | ✓ | Complete |
| Cognitive States | ✓ | ✓ | API-based |
| CSV Export | ✓ | ✓ | JavaScript port |
| Statistics | ✓ | ✓ | JavaScript port |
| Query Tool | ✓ | ✓ | JavaScript port |
| Confidence Scoring | ✓ | ✓ | Algorithm ported |
| Real-time Dashboard | GNOME | Web | Different UI |
| Auto-capture | eBPF | Manual | Requires integration |
| Multi-instance | PID-based | Session-based | Different approach |

## License

Same as main project: Dual-licensed GPL-3.0 / Commercial

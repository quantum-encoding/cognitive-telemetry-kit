# Cognitive Telemetry Kit - Web Runtime Version

A web-compatible version of the Cognitive Telemetry Kit that works in Claude Code's web runtime environment without requiring Linux kernel access, eBPF, or systemd.

## 🌟 Features

- **CHRONOS 4D Timestamps** - Nanosecond-precision timestamps with cognitive state, tick counter, and context
- **Platform Independent** - Works on any OS with Node.js (Linux, macOS, Windows, cloud environments)
- **Git Integration** - Automatic CHRONOS stamp injection into git commits
- **Session Tracking** - UUID-based session isolation (replaces PID-based tracking)
- **Multi-Agent Sync** - Optional HTTP server for aggregating states across multiple agents
- **CSV Export** - Export cognitive states for analysis in Excel, Python, R
- **No Root Required** - Pure JavaScript, no kernel access needed
- **Cloud Ready** - Deploy sync server to Vercel, Netlify, AWS Lambda, etc.

## 📦 Installation

### Quick Start (Local Project)

```bash
cd your-project
git clone https://github.com/quantum-encoding/cognitive-telemetry-kit
cd cognitive-telemetry-kit/web-runtime

# Install git hooks
bash git-hooks/install.sh
```

### Global Installation (All Projects)

```bash
# Clone repository
cd ~
git clone https://github.com/quantum-encoding/cognitive-telemetry-kit

# Add to PATH (add to ~/.bashrc or ~/.zshrc)
export PATH="$HOME/cognitive-telemetry-kit/web-runtime:$PATH"

# Test installation
chronos-stamp --help
```

## 🚀 Quick Test

```bash
cd cognitive-telemetry-kit/web-runtime

# Run test suite
node test.js

# Generate a CHRONOS stamp
node chronos-stamp.js --state "Testing" --action "demo" --description "Hello World"

# Initialize tracker
node cognitive-tracker.js init

# Record a state
node cognitive-tracker.js record "Thinking deeply" "analysis" "Exploring codebase"

# View latest state
node cognitive-tracker.js latest

# View statistics
node cognitive-tracker.js stats

# Export to CSV
node cognitive-tracker.js export my-states.csv
```

## 📖 Usage

### 1. Recording Cognitive States

#### CLI

```bash
# Record a state
cognitive-tracker record "Thinking" "tool-completion" "Read file: main.js"

# View latest
cognitive-tracker latest

# View stats
cognitive-tracker stats

# List recent states
cognitive-tracker list 20

# Export to CSV
cognitive-tracker export analysis.csv
```

#### Programmatic API

```javascript
const CognitiveTracker = require('./cognitive-tracker');

// Initialize
const tracker = new CognitiveTracker({ agent: 'claude-code' });
await tracker.init();

// Record state
await tracker.recordState({
  cognitiveState: "Thinking deeply",
  action: "tool-completion",
  description: "Write file: src/main.js"
});

// Get latest
const latest = await tracker.getLatestState();
console.log(latest.chronos_stamp);

// Get statistics
const stats = await tracker.getStats();
console.log(stats);

// Export to CSV
await tracker.exportToCSV('states.csv');
```

### 2. Git Hook Integration

The git hooks automatically inject CHRONOS stamps into your commit messages.

#### Installation

```bash
cd your-git-repository
bash /path/to/cognitive-telemetry-kit/web-runtime/git-hooks/install.sh
```

#### How It Works

1. Claude Code executes a tool
2. Git hook (`tool-result-hook.sh`) is triggered
3. Latest cognitive state is retrieved
4. CHRONOS stamp is injected into commit message

#### Example Commit Message

```
Add user authentication feature

[CHRONOS] 2025-11-04T14:23:45.123456789Z::claude-code::Implementing feature::TICK-0000000042::[session-abc123]::[/home/user/project] → tool-completion - Write file: auth.js
```

### 3. Running the Sync Server

For multi-agent synchronization, run the HTTP sync server:

#### Local Server

```bash
# Start server on default port (3000)
node sync-server.js

# Custom port
node sync-server.js --port 8080

# Custom host and data directory
node sync-server.js --host 0.0.0.0 --port 3000 --data-dir /var/chronos-data
```

#### Server Endpoints

- `GET /api/health` - Health check
- `POST /api/states` - Submit states from agent
- `GET /api/states?session_id=uuid&limit=100` - Get states
- `GET /api/stats` - Get statistics
- `GET /api/agents` - List all agents
- `GET /` - API documentation (web UI)

#### Submit States to Server

```bash
# Example: Submit states
curl -X POST http://localhost:3000/api/states \
  -H "Content-Type: application/json" \
  -d '{
    "session_id": "abc-123",
    "agent": "claude-code",
    "states": [...]
  }'

# Get statistics
curl http://localhost:3000/api/stats

# Get states for specific session
curl http://localhost:3000/api/states?session_id=abc-123&limit=50
```

### 4. Cloud Deployment

#### Deploy to Vercel

```bash
cd web-runtime
npm init -y  # If not already done
vercel deploy
```

#### Deploy to Netlify

```bash
cd web-runtime
netlify deploy --prod
```

#### Deploy with Docker

```bash
cd web-runtime
docker build -t chronos-sync .
docker run -p 3000:3000 -v $(pwd)/.chronos-data:/data chronos-sync
```

## 🎯 Use Cases

### 1. Single Agent (Local Development)

```bash
# Install in your project
cd my-project
bash /path/to/git-hooks/install.sh

# Work normally - CHRONOS stamps auto-inject into commits
# View your cognitive history anytime
cognitive-tracker stats
```

### 2. Multiple Local Agents

```bash
# Terminal 1: Agent 1
cd project-a
cognitive-tracker record "Implementing auth" "coding" "..."

# Terminal 2: Agent 2
cd project-b
cognitive-tracker record "Refactoring" "coding" "..."

# Both agents maintain separate sessions
# Each has its own .cognitive/ directory
```

### 3. Global Sync Across All Agents

```bash
# Start sync server (run once)
chronos-sync --port 3000 --data-dir ~/.chronos-global

# Configure all agents to sync (add to .bashrc or use env var)
export COGNITIVE_SYNC_URL=http://localhost:3000

# Now all agents on your machine sync to central server
# View aggregated stats via web UI: http://localhost:3000
```

### 4. Team Collaboration (Cloud Sync)

```bash
# Deploy sync server to cloud
vercel deploy

# Team members configure their agents
export COGNITIVE_SYNC_URL=https://chronos-sync.vercel.app

# Entire team's cognitive states are aggregated
# View team dashboard, analyze patterns, optimize workflows
```

## 📊 Data Format

### CHRONOS Stamp Format

```
[CHRONOS] <timestamp>::<agent>::<cognitive-state>::TICK-<id>::[<session>]::[<pwd>] → <action> - <description>
```

**Example:**
```
[CHRONOS] 2025-11-04T14:23:45.123456789Z::claude-code::Thinking deeply::TICK-0000000042::[c982e24f-b07f-4215-8a45-cd60d62f4f27]::[/home/user/project] → tool-completion - Read file: main.js
```

### Storage Schema

**File:** `.cognitive/states.json`

```json
{
  "session_id": "c982e24f-b07f-4215-8a45-cd60d62f4f27",
  "agent": "claude-code",
  "created_at": "2025-11-04T14:23:45.123Z",
  "working_dir": "/home/user/project",
  "states": [
    {
      "tick": 1,
      "timestamp": "2025-11-04T14:23:45.123456789Z",
      "timestamp_ns": "1730729025123456789",
      "cognitive_state": "Thinking deeply",
      "action": "tool-completion",
      "description": "Read file: main.js",
      "working_dir": "/home/user/project",
      "session_path": "/home/user/project",
      "chronos_stamp": "[CHRONOS] ...",
      "hash": "sha256-hash"
    }
  ]
}
```

## 🔧 Configuration

### Environment Variables

```bash
# Sync server URL (optional)
export COGNITIVE_SYNC_URL=http://localhost:3000

# Custom agent name (default: claude-code)
export COGNITIVE_AGENT=my-custom-agent

# Custom data directory (default: .cognitive)
export COGNITIVE_DATA_DIR=/custom/path
```

### Configuration File

Create `.cognitive/config.json`:

```json
{
  "agent": "claude-code",
  "sync_url": "http://localhost:3000",
  "auto_sync": true,
  "sync_interval": 60000,
  "max_states": 10000
}
```

## 🧪 Testing

```bash
# Run full test suite
cd web-runtime
node test.js

# Test individual components
node chronos-stamp.js --help
node cognitive-tracker.js stats
```

## 📈 CSV Export for Analysis

```bash
# Export to CSV
cognitive-tracker export my-analysis.csv

# Analyze in Python
import pandas as pd
df = pd.read_csv('my-analysis.csv')

# Top cognitive states
print(df['cognitive_state'].value_counts())

# Timeline analysis
df['timestamp'] = pd.to_datetime(df['timestamp'])
df.set_index('timestamp').resample('1H')['cognitive_state'].count().plot()
```

## 🔄 Comparison with Linux Version

| Feature | Linux Version | Web Runtime | Notes |
|---------|---------------|-------------|-------|
| State Capture | eBPF (automatic) | API (manual) | Web version requires explicit API calls |
| Storage | SQLite | JSON files | Web version more portable |
| Process Isolation | Linux PID | Session UUID | Web version works across platforms |
| Daemon | systemd service | Node.js process | Web version simpler deployment |
| Git Integration | ✓ | ✓ | Both support git hooks |
| Multi-Agent Sync | D-Bus | HTTP REST | Web version cloud-ready |
| Platform Support | Linux only | Cross-platform | Web version works everywhere |
| Root Required | Yes (eBPF) | No | Web version easier to install |
| Performance | <1ms | <5ms | Both very fast |

## 🛠️ Troubleshooting

### Git Hooks Not Working

```bash
# Check hook is installed
ls -la .claude/hooks/tool-result-hook.sh

# Test hook manually
bash .claude/hooks/tool-result-hook.sh

# Verify execution permissions
chmod +x .claude/hooks/tool-result-hook.sh
```

### Node.js Not Found

```bash
# Install Node.js
# Ubuntu/Debian
sudo apt install nodejs npm

# macOS
brew install node

# Or use nvm
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.0/install.sh | bash
nvm install node
```

### States Not Being Recorded

```bash
# Check .cognitive directory exists
ls -la .cognitive/

# Initialize manually
node cognitive-tracker.js init

# Check permissions
chmod -R u+w .cognitive/
```

## 📚 Advanced Usage

### Custom Cognitive States

```javascript
// Define your own cognitive states
const customStates = [
  'Analyzing architecture',
  'Debugging issue',
  'Optimizing performance',
  'Writing tests',
  'Reviewing code'
];

// Record custom state
await tracker.recordState({
  cognitiveState: customStates[0],
  action: 'custom-action',
  description: 'My custom workflow'
});
```

### Confidence Scoring

Port the confidence scoring from the main toolkit:

```javascript
// Confidence score mapping (from cognitive-tools/confidence.zig)
const confidenceScores = {
  'Channelling': 1.00,
  'Executing': 0.95,
  'Verifying': 0.90,
  'Computing': 0.85,
  'Thinking': 0.65,
  'Noodling': 0.40,
  'Finagling': 0.35,
  'Discombobulating': 0.20
};

// Get confidence for state
function getConfidence(state) {
  for (const [keyword, score] of Object.entries(confidenceScores)) {
    if (state.toLowerCase().includes(keyword.toLowerCase())) {
      return score;
    }
  }
  return 0.50; // Neutral default
}
```

## 🎓 Learn More

- **Main Documentation:** [../README.md](../README.md)
- **Architecture:** [../WEB_RUNTIME_DESIGN.md](../WEB_RUNTIME_DESIGN.md)
- **Linux Version:** [../src/](../src/)
- **Cognitive Tools:** [../cognitive-tools/](../cognitive-tools/)

## 📄 License

Dual-licensed:
- **GPL-3.0** for individuals and open-source projects
- **Commercial License** for Anthropic and commercial use

## 🤝 Contributing

Contributions welcome! Please read the main [CONTRIBUTING.md](../CONTRIBUTING.md) for guidelines.

## 🙏 Acknowledgments

Based on the original Cognitive Telemetry Kit's architecture and design philosophy.
Adapted for web runtime environments while maintaining the core CHRONOS timestamp format.

---

**Built with ❤️ for cognitive archaeology in the age of AI**

# Global Git Sync Setup Guide

This guide shows you how to set up the Cognitive Telemetry Kit as a **global git sync** for all Claude Code agents on your machine and the web.

## 🎯 Architecture Overview

```
┌─────────────────────────────────────────────────────────────┐
│                    Your Development Machine                 │
│                                                             │
│  ┌──────────────┐  ┌──────────────┐  ┌──────────────┐    │
│  │ Claude Agent │  │ Claude Agent │  │ Claude Agent │    │
│  │  (Desktop)   │  │  (Terminal)  │  │    (Web)     │    │
│  └──────┬───────┘  └──────┬───────┘  └──────┬───────┘    │
│         │                  │                  │             │
│         └──────────────────┼──────────────────┘             │
│                            │                                │
│                    ┌───────▼────────┐                       │
│                    │  CHRONOS Sync  │                       │
│                    │     Server     │                       │
│                    │  (localhost)   │                       │
│                    └───────┬────────┘                       │
└────────────────────────────┼──────────────────────────────┘
                             │
                             │ (Optional: Cloud Deployment)
                             │
                    ┌────────▼─────────┐
                    │   Cloud Sync     │
                    │  (Vercel/AWS)    │
                    └────────┬─────────┘
                             │
        ┌────────────────────┼────────────────────┐
        │                    │                    │
   ┌────▼────┐         ┌────▼────┐         ┌────▼────┐
   │ Agent 1 │         │ Agent 2 │         │ Agent 3 │
   │  (Web)  │         │ (Remote)│         │ (Cloud) │
   └─────────┘         └─────────┘         └─────────┘
```

## 📋 Prerequisites

- Node.js 14+ installed
- Git installed
- Access to run local HTTP server (port 3000 or custom)
- (Optional) Cloud provider account for global deployment

## 🚀 Setup Steps

### Step 1: Clone and Install

```bash
# Clone repository to a global location
cd ~
git clone https://github.com/quantum-encoding/cognitive-telemetry-kit
cd cognitive-telemetry-kit/web-runtime

# Make scripts executable
chmod +x *.js git-hooks/*.sh

# Add to PATH (add this to ~/.bashrc, ~/.zshrc, or ~/.profile)
export PATH="$HOME/cognitive-telemetry-kit/web-runtime:$PATH"
export CHRONOS_HOME="$HOME/cognitive-telemetry-kit/web-runtime"

# Reload shell
source ~/.bashrc  # or ~/.zshrc
```

### Step 2: Start Global Sync Server

#### Option A: Local Sync (Single Machine)

```bash
# Create global data directory
mkdir -p ~/.chronos-global

# Start server (keep this running)
cd ~/cognitive-telemetry-kit/web-runtime
node sync-server.js --port 3000 --data-dir ~/.chronos-global

# Or run in background with nohup
nohup node sync-server.js --port 3000 --data-dir ~/.chronos-global > ~/.chronos-global/server.log 2>&1 &
```

#### Option B: systemd Service (Linux)

Create `/etc/systemd/user/chronos-sync.service`:

```ini
[Unit]
Description=CHRONOS Sync Server
After=network.target

[Service]
Type=simple
ExecStart=/usr/bin/node %h/cognitive-telemetry-kit/web-runtime/sync-server.js --port 3000 --data-dir %h/.chronos-global
Restart=always
RestartSec=10

[Install]
WantedBy=default.target
```

Enable and start:

```bash
systemctl --user enable chronos-sync
systemctl --user start chronos-sync
systemctl --user status chronos-sync
```

#### Option C: Docker Container

Create `Dockerfile`:

```dockerfile
FROM node:18-alpine

WORKDIR /app
COPY web-runtime /app

RUN chmod +x *.js

EXPOSE 3000

CMD ["node", "sync-server.js", "--port", "3000", "--host", "0.0.0.0"]
```

Run:

```bash
cd ~/cognitive-telemetry-kit
docker build -t chronos-sync .
docker run -d -p 3000:3000 -v ~/.chronos-global:/data chronos-sync
```

### Step 3: Configure Git Template for Auto-Installation

This ensures every new git repository automatically gets CHRONOS hooks.

```bash
# Create git template directory
mkdir -p ~/.git-template/hooks

# Create hook installer script
cat > ~/.git-template/hooks/post-checkout << 'EOF'
#!/bin/bash
# Auto-install CHRONOS git hooks

CHRONOS_HOME="${CHRONOS_HOME:-$HOME/cognitive-telemetry-kit/web-runtime}"
HOOK_SCRIPT="$CHRONOS_HOME/git-hooks/tool-result-hook.sh"

if [ -f "$HOOK_SCRIPT" ]; then
    mkdir -p .claude/hooks
    cp "$HOOK_SCRIPT" .claude/hooks/
    chmod +x .claude/hooks/tool-result-hook.sh
fi
EOF

chmod +x ~/.git-template/hooks/post-checkout

# Configure git to use template
git config --global init.templatedir ~/.git-template
```

### Step 4: Install Hooks in Existing Repositories

```bash
# Install in all existing repositories (example)
find ~/projects -name ".git" -type d | while read gitdir; do
    repo=$(dirname "$gitdir")
    echo "Installing CHRONOS hooks in: $repo"
    cd "$repo"
    bash "$CHRONOS_HOME/git-hooks/install.sh"
done
```

Or install manually per repository:

```bash
cd your-repository
bash ~/cognitive-telemetry-kit/web-runtime/git-hooks/install.sh
```

### Step 5: Configure Agent Sync (Per Project)

Create `.cognitive/config.json` in your project:

```json
{
  "agent": "claude-code",
  "sync_url": "http://localhost:3000",
  "auto_sync": true,
  "sync_interval": 60000
}
```

Or use environment variables (add to ~/.bashrc):

```bash
export COGNITIVE_SYNC_URL=http://localhost:3000
export COGNITIVE_AGENT=claude-code-$(hostname)
```

### Step 6: Enhanced Git Hook with Auto-Sync

Create enhanced hook at `.claude/hooks/tool-result-hook.sh`:

```bash
#!/bin/bash

# Get CHRONOS stamp
CHRONOS_HOME="${CHRONOS_HOME:-$HOME/cognitive-telemetry-kit/web-runtime}"
TRACKER="$CHRONOS_HOME/cognitive-tracker.js"
SYNC_URL="${COGNITIVE_SYNC_URL:-http://localhost:3000}"

# Get latest state
LATEST_STATE=$(node "$TRACKER" latest 2>/dev/null)

# Sync to server (background, non-blocking)
if [ -n "$SYNC_URL" ] && [ -f "$TRACKER" ]; then
    (
        SESSION_ID=$(cat .cognitive/session.json | grep session_id | cut -d'"' -f4)
        STATES=$(cat .cognitive/states.json)

        curl -s -X POST "$SYNC_URL/api/states" \
            -H "Content-Type: application/json" \
            -d "$STATES" > /dev/null 2>&1 &
    ) &
fi

# Output CHRONOS stamp for git
echo "$LATEST_STATE"
```

### Step 7: Verify Installation

```bash
# Test sync server
curl http://localhost:3000/api/health

# Record a test state
cd ~/test-project
node $CHRONOS_HOME/cognitive-tracker.js init
node $CHRONOS_HOME/cognitive-tracker.js record "Testing" "test" "Global sync test"

# Check server stats
curl http://localhost:3000/api/stats

# View dashboard
open http://localhost:3000
```

## 🌐 Cloud Deployment for Global Sync

### Deploy to Vercel

```bash
cd ~/cognitive-telemetry-kit/web-runtime

# Create vercel.json
cat > vercel.json << 'EOF'
{
  "version": 2,
  "builds": [
    {
      "src": "sync-server.js",
      "use": "@vercel/node"
    }
  ],
  "routes": [
    {
      "src": "/(.*)",
      "dest": "/sync-server.js"
    }
  ]
}
EOF

# Deploy
npx vercel deploy --prod

# Get deployment URL (e.g., https://chronos-sync.vercel.app)
# Configure all agents:
export COGNITIVE_SYNC_URL=https://chronos-sync.vercel.app
```

### Deploy to AWS Lambda

```bash
# Install serverless framework
npm install -g serverless

# Create serverless.yml
cat > serverless.yml << 'EOF'
service: chronos-sync

provider:
  name: aws
  runtime: nodejs18.x
  region: us-east-1

functions:
  api:
    handler: sync-server.handler
    events:
      - http:
          path: /{proxy+}
          method: ANY
          cors: true
EOF

# Deploy
serverless deploy
```

### Deploy to Railway

```bash
# Install Railway CLI
npm install -g railway

# Login and deploy
railway login
railway init
railway up
```

## 📊 Monitoring and Analytics

### View Real-Time Stats

```bash
# Local server
curl http://localhost:3000/api/stats | jq

# Cloud server
curl https://your-sync-url.vercel.app/api/stats | jq
```

### Web Dashboard

Open in browser:
- Local: `http://localhost:3000`
- Cloud: `https://your-sync-url.vercel.app`

### Export All Agent Data

```bash
# Get all states
curl http://localhost:3000/api/states?limit=10000 > all-states.json

# Convert to CSV
node -e "
const data = require('./all-states.json');
const csv = data.states.map(s =>
  [s.tick, s.timestamp, s.cognitive_state, s.description].join(',')
).join('\n');
console.log('tick,timestamp,state,description\n' + csv);
" > all-states.csv
```

## 🔒 Security Considerations

### Local Network Only

```bash
# Bind to localhost only (default is 0.0.0.0)
node sync-server.js --host 127.0.0.1 --port 3000
```

### Add Authentication (Production)

Edit `sync-server.js` to add API key validation:

```javascript
// Add before handling requests
const API_KEY = process.env.CHRONOS_API_KEY || 'your-secret-key';

if (req.headers['x-api-key'] !== API_KEY) {
  res.writeHead(401, { 'Content-Type': 'application/json' });
  res.end(JSON.stringify({ error: 'Unauthorized' }));
  return;
}
```

Configure clients:

```bash
export CHRONOS_API_KEY=your-secret-key
```

### HTTPS for Cloud Deployment

Vercel, Railway, and AWS Lambda provide automatic HTTPS. For custom servers, use Let's Encrypt:

```bash
# Install certbot
sudo apt install certbot

# Get certificate
sudo certbot certonly --standalone -d sync.yourdomain.com

# Use in Node.js
const https = require('https');
const fs = require('fs');

const options = {
  key: fs.readFileSync('/etc/letsencrypt/live/sync.yourdomain.com/privkey.pem'),
  cert: fs.readFileSync('/etc/letsencrypt/live/sync.yourdomain.com/fullchain.pem')
};

https.createServer(options, app).listen(443);
```

## 🎨 Customization

### Custom Cognitive States

Add to `.cognitive/config.json`:

```json
{
  "custom_states": {
    "Deep Work": 1.0,
    "Code Review": 0.85,
    "Debugging": 0.75,
    "Research": 0.70,
    "Meeting": 0.40
  }
}
```

### Custom Actions

```json
{
  "custom_actions": [
    "feature-implementation",
    "bug-fix",
    "refactoring",
    "testing",
    "documentation"
  ]
}
```

## 📈 Usage Examples

### Scenario 1: Single Developer, Multiple Projects

```bash
# Start server once
node sync-server.js --data-dir ~/.chronos-global

# Work on project A
cd ~/projectA
# Claude records states automatically via hooks

# Work on project B
cd ~/projectB
# States sync to same server

# View combined stats
curl http://localhost:3000/api/stats
```

### Scenario 2: Team Collaboration

```bash
# Team lead deploys to cloud
vercel deploy

# Team members configure
export COGNITIVE_SYNC_URL=https://team-chronos.vercel.app

# All team members' states aggregate
# View team dashboard to see who's working on what
```

### Scenario 3: CI/CD Integration

```bash
# In CI pipeline (.github/workflows/ci.yml)
- name: Record CI State
  run: |
    export COGNITIVE_SYNC_URL=${{ secrets.CHRONOS_SYNC_URL }}
    node chronos-tracker.js record "CI Build" "ci-pipeline" "Build #${{ github.run_number }}"
```

## 🐛 Troubleshooting

### Server Won't Start

```bash
# Check port availability
lsof -i :3000

# Kill existing process
kill -9 $(lsof -t -i:3000)

# Use different port
node sync-server.js --port 8080
```

### States Not Syncing

```bash
# Test connectivity
curl http://localhost:3000/api/health

# Check logs
tail -f ~/.chronos-global/server.log

# Verify config
cat .cognitive/config.json
```

### High Memory Usage

```bash
# Limit state retention in config
{
  "max_states": 1000,
  "auto_prune": true,
  "prune_older_than_days": 30
}
```

## 📚 Next Steps

- [Main README](README.md) - Full documentation
- [Web Runtime Design](WEB_RUNTIME_DESIGN.md) - Architecture details
- [Contributing](../CONTRIBUTING.md) - How to contribute

---

**You now have a global cognitive telemetry system tracking all Claude agents!** 🎉

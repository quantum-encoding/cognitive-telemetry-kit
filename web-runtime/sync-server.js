#!/usr/bin/env node

/**
 * CHRONOS Sync Server - Web Runtime Version
 *
 * A simple HTTP server that aggregates cognitive states from multiple agents.
 * Provides REST API for state submission and retrieval.
 *
 * Can run locally or be deployed to cloud (Vercel, Netlify, AWS Lambda, etc.)
 */

const http = require('http');
const fs = require('fs');
const path = require('path');
const url = require('url');

class ChronosSyncServer {
  constructor(options = {}) {
    this.port = options.port || 3000;
    this.host = options.host || '0.0.0.0';
    this.dataDir = options.dataDir || path.join(process.cwd(), '.chronos-data');
    this.statesFile = path.join(this.dataDir, 'aggregated-states.json');
    this.server = null;

    // Create data directory
    if (!fs.existsSync(this.dataDir)) {
      fs.mkdirSync(this.dataDir, { recursive: true });
    }

    // Initialize states file
    if (!fs.existsSync(this.statesFile)) {
      this.saveData({
        created_at: new Date().toISOString(),
        agents: {},
        total_states: 0
      });
    }
  }

  /**
   * Load data from file
   */
  loadData() {
    try {
      const content = fs.readFileSync(this.statesFile, 'utf8');
      return JSON.parse(content);
    } catch (error) {
      return {
        created_at: new Date().toISOString(),
        agents: {},
        total_states: 0
      };
    }
  }

  /**
   * Save data to file
   */
  saveData(data) {
    fs.writeFileSync(this.statesFile, JSON.stringify(data, null, 2));
  }

  /**
   * Handle HTTP request
   */
  async handleRequest(req, res) {
    const parsedUrl = url.parse(req.url, true);
    const pathname = parsedUrl.pathname;
    const method = req.method;

    // CORS headers
    res.setHeader('Access-Control-Allow-Origin', '*');
    res.setHeader('Access-Control-Allow-Methods', 'GET, POST, OPTIONS');
    res.setHeader('Access-Control-Allow-Headers', 'Content-Type');

    if (method === 'OPTIONS') {
      res.writeHead(200);
      res.end();
      return;
    }

    try {
      // Routes
      if (pathname === '/api/health' && method === 'GET') {
        await this.handleHealth(req, res);
      } else if (pathname === '/api/states' && method === 'POST') {
        await this.handleSubmitStates(req, res);
      } else if (pathname === '/api/states' && method === 'GET') {
        await this.handleGetStates(req, res);
      } else if (pathname === '/api/stats' && method === 'GET') {
        await this.handleGetStats(req, res);
      } else if (pathname === '/api/agents' && method === 'GET') {
        await this.handleGetAgents(req, res);
      } else if (pathname === '/' && method === 'GET') {
        await this.handleRoot(req, res);
      } else {
        res.writeHead(404, { 'Content-Type': 'application/json' });
        res.end(JSON.stringify({ error: 'Not found' }));
      }
    } catch (error) {
      console.error('Error handling request:', error);
      res.writeHead(500, { 'Content-Type': 'application/json' });
      res.end(JSON.stringify({ error: error.message }));
    }
  }

  /**
   * Health check endpoint
   */
  async handleHealth(req, res) {
    res.writeHead(200, { 'Content-Type': 'application/json' });
    res.end(JSON.stringify({
      status: 'ok',
      version: '1.0.0',
      uptime: process.uptime()
    }));
  }

  /**
   * Submit states from an agent
   */
  async handleSubmitStates(req, res) {
    let body = '';
    req.on('data', chunk => body += chunk);
    req.on('end', () => {
      try {
        const payload = JSON.parse(body);
        const { session_id, agent, states } = payload;

        if (!session_id || !agent || !Array.isArray(states)) {
          res.writeHead(400, { 'Content-Type': 'application/json' });
          res.end(JSON.stringify({
            error: 'Invalid payload. Required: session_id, agent, states (array)'
          }));
          return;
        }

        // Load current data
        const data = this.loadData();

        // Create agent entry if it doesn't exist
        if (!data.agents[session_id]) {
          data.agents[session_id] = {
            session_id,
            agent,
            first_seen: new Date().toISOString(),
            last_seen: new Date().toISOString(),
            states: []
          };
        }

        // Add new states (with deduplication)
        const existingHashes = new Set(data.agents[session_id].states.map(s => s.hash));
        const newStates = states.filter(s => !existingHashes.has(s.hash));

        data.agents[session_id].states.push(...newStates);
        data.agents[session_id].last_seen = new Date().toISOString();
        data.total_states += newStates.length;

        // Save data
        this.saveData(data);

        res.writeHead(200, { 'Content-Type': 'application/json' });
        res.end(JSON.stringify({
          success: true,
          received: states.length,
          added: newStates.length,
          duplicates: states.length - newStates.length
        }));
      } catch (error) {
        res.writeHead(400, { 'Content-Type': 'application/json' });
        res.end(JSON.stringify({ error: error.message }));
      }
    });
  }

  /**
   * Get states (optionally filtered by agent/session)
   */
  async handleGetStates(req, res) {
    const parsedUrl = url.parse(req.url, true);
    const query = parsedUrl.query;

    const data = this.loadData();

    let states = [];

    if (query.session_id) {
      // Get states for specific session
      const agent = data.agents[query.session_id];
      if (agent) {
        states = agent.states;
      }
    } else {
      // Get all states from all agents
      Object.values(data.agents).forEach(agent => {
        states.push(...agent.states);
      });
    }

    // Apply limit
    const limit = parseInt(query.limit) || states.length;
    states = states.slice(-limit);

    res.writeHead(200, { 'Content-Type': 'application/json' });
    res.end(JSON.stringify({
      count: states.length,
      states
    }));
  }

  /**
   * Get statistics
   */
  async handleGetStats(req, res) {
    const data = this.loadData();

    const stats = {
      total_states: data.total_states,
      total_agents: Object.keys(data.agents).length,
      created_at: data.created_at,
      agents: Object.values(data.agents).map(agent => ({
        session_id: agent.session_id,
        agent: agent.agent,
        state_count: agent.states.length,
        first_seen: agent.first_seen,
        last_seen: agent.last_seen
      }))
    };

    res.writeHead(200, { 'Content-Type': 'application/json' });
    res.end(JSON.stringify(stats));
  }

  /**
   * Get list of agents
   */
  async handleGetAgents(req, res) {
    const data = this.loadData();

    const agents = Object.values(data.agents).map(agent => ({
      session_id: agent.session_id,
      agent: agent.agent,
      state_count: agent.states.length,
      first_seen: agent.first_seen,
      last_seen: agent.last_seen
    }));

    res.writeHead(200, { 'Content-Type': 'application/json' });
    res.end(JSON.stringify({
      count: agents.length,
      agents
    }));
  }

  /**
   * Root endpoint - API documentation
   */
  async handleRoot(req, res) {
    const html = `
<!DOCTYPE html>
<html>
<head>
  <title>CHRONOS Sync Server</title>
  <style>
    body { font-family: monospace; max-width: 800px; margin: 50px auto; padding: 20px; }
    h1 { color: #333; }
    code { background: #f4f4f4; padding: 2px 6px; border-radius: 3px; }
    pre { background: #f4f4f4; padding: 15px; border-radius: 5px; overflow-x: auto; }
    .endpoint { margin: 20px 0; padding: 15px; border-left: 3px solid #007acc; background: #f9f9f9; }
    .method { color: #007acc; font-weight: bold; }
  </style>
</head>
<body>
  <h1>CHRONOS Sync Server</h1>
  <p>Web Runtime Version - Cognitive Telemetry Aggregation</p>

  <h2>API Endpoints</h2>

  <div class="endpoint">
    <p><span class="method">GET</span> <code>/api/health</code></p>
    <p>Health check endpoint</p>
  </div>

  <div class="endpoint">
    <p><span class="method">POST</span> <code>/api/states</code></p>
    <p>Submit cognitive states from an agent</p>
    <pre>{
  "session_id": "uuid",
  "agent": "claude-code",
  "states": [...]
}</pre>
  </div>

  <div class="endpoint">
    <p><span class="method">GET</span> <code>/api/states?session_id=uuid&limit=100</code></p>
    <p>Retrieve cognitive states (optionally filtered)</p>
  </div>

  <div class="endpoint">
    <p><span class="method">GET</span> <code>/api/stats</code></p>
    <p>Get statistics about all agents and states</p>
  </div>

  <div class="endpoint">
    <p><span class="method">GET</span> <code>/api/agents</code></p>
    <p>List all registered agents</p>
  </div>

  <h2>Example Usage</h2>
  <pre># Submit states
curl -X POST http://localhost:3000/api/states \\
  -H "Content-Type: application/json" \\
  -d '{"session_id":"abc","agent":"claude-code","states":[...]}'

# Get stats
curl http://localhost:3000/api/stats

# Get states for specific agent
curl http://localhost:3000/api/states?session_id=abc</pre>
</body>
</html>
`;

    res.writeHead(200, { 'Content-Type': 'text/html' });
    res.end(html);
  }

  /**
   * Start the server
   */
  start() {
    this.server = http.createServer((req, res) => this.handleRequest(req, res));

    this.server.listen(this.port, this.host, () => {
      console.log(`
╔═══════════════════════════════════════════════════════════╗
║         CHRONOS Sync Server - Web Runtime Version        ║
╚═══════════════════════════════════════════════════════════╝

Server running at http://${this.host}:${this.port}/

API Endpoints:
  GET  /api/health              Health check
  POST /api/states              Submit states
  GET  /api/states              Get states
  GET  /api/stats               Get statistics
  GET  /api/agents              List agents

Data directory: ${this.dataDir}

Press Ctrl+C to stop
`);
    });

    return this.server;
  }

  /**
   * Stop the server
   */
  stop() {
    if (this.server) {
      this.server.close();
    }
  }
}

/**
 * CLI usage
 */
if (require.main === module) {
  const args = process.argv.slice(2);

  let port = 3000;
  let host = '0.0.0.0';
  let dataDir = path.join(process.cwd(), '.chronos-data');

  // Parse arguments
  for (let i = 0; i < args.length; i++) {
    if (args[i] === '--port' || args[i] === '-p') {
      port = parseInt(args[++i]);
    } else if (args[i] === '--host' || args[i] === '-h') {
      host = args[++i];
    } else if (args[i] === '--data-dir' || args[i] === '-d') {
      dataDir = args[++i];
    } else if (args[i] === '--help') {
      console.log(`
CHRONOS Sync Server - Web Runtime Version

Usage:
  sync-server [options]

Options:
  --port, -p <port>        Port to listen on (default: 3000)
  --host, -h <host>        Host to bind to (default: 0.0.0.0)
  --data-dir, -d <dir>     Data directory (default: .chronos-data)
  --help                   Show this help message

Examples:
  sync-server
  sync-server --port 8080
  sync-server --port 3000 --data-dir /var/chronos
`);
      process.exit(0);
    }
  }

  const server = new ChronosSyncServer({ port, host, dataDir });
  server.start();

  // Graceful shutdown
  process.on('SIGINT', () => {
    console.log('\nShutting down gracefully...');
    server.stop();
    process.exit(0);
  });
}

module.exports = ChronosSyncServer;

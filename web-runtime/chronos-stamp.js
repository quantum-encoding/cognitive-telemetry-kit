#!/usr/bin/env node

/**
 * CHRONOS Stamp Generator - Web Runtime Version
 *
 * Generates 4-dimensional timestamps for cognitive telemetry:
 * 1. Temporal precision (nanosecond-accurate)
 * 2. Cognitive state (agent's mental state)
 * 3. Event identity (sequential TICK counter)
 * 4. Contextual information (session, working directory)
 *
 * Format:
 * [CHRONOS] <timestamp>::<agent>::<cognitive-state>::TICK-<id>::[<session>]::[<pwd>] → <action> - <description>
 *
 * Example:
 * [CHRONOS] 2025-11-04T14:23:45.123456789Z::claude-code::Thinking::TICK-0000000042::[session-abc]::[/home/user] → tool-completion - Write file
 */

const fs = require('fs');
const path = require('path');
const crypto = require('crypto');

/**
 * Get high-resolution timestamp with nanosecond precision
 * @returns {Object} { iso8601: string, nanoseconds: bigint }
 */
function getHighResTimestamp() {
  // Use process.hrtime.bigint() for nanosecond precision
  const hrtime = process.hrtime.bigint();

  // Get current date for ISO8601 formatting
  const now = new Date();

  // Get milliseconds since epoch
  const msEpoch = now.getTime();

  // Calculate nanoseconds for the current second
  const nsInSecond = Number(hrtime % 1000000000n);

  // Format ISO8601 with nanosecond precision
  const year = now.getUTCFullYear();
  const month = String(now.getUTCMonth() + 1).padStart(2, '0');
  const day = String(now.getUTCDate()).padStart(2, '0');
  const hours = String(now.getUTCHours()).padStart(2, '0');
  const minutes = String(now.getUTCMinutes()).padStart(2, '0');
  const seconds = String(now.getUTCSeconds()).padStart(2, '0');
  const nanoseconds = String(nsInSecond).padStart(9, '0');

  const iso8601 = `${year}-${month}-${day}T${hours}:${minutes}:${seconds}.${nanoseconds}Z`;

  return {
    iso8601,
    nanoseconds: hrtime
  };
}

/**
 * Generate a CHRONOS stamp
 * @param {Object} options - Configuration options
 * @param {string} options.agent - Agent name (default: 'claude-code')
 * @param {string} options.cognitiveState - Current cognitive state
 * @param {number} options.tick - Tick counter (auto-increments if not provided)
 * @param {string} options.session - Session ID (auto-generated if not provided)
 * @param {string} options.workingDir - Working directory (auto-detected if not provided)
 * @param {string} options.action - Action type (e.g., 'tool-completion', 'git-commit')
 * @param {string} options.description - Action description
 * @returns {Object} { stamp: string, tick: number, timestamp: object }
 */
function generateChronosStamp(options = {}) {
  const {
    agent = 'claude-code',
    cognitiveState = 'Unknown',
    tick = null,
    session = null,
    workingDir = process.cwd(),
    action = 'event',
    description = ''
  } = options;

  // Get high-resolution timestamp
  const timestamp = getHighResTimestamp();

  // Auto-increment tick if not provided
  const tickValue = tick !== null ? tick : getNextTick();

  // Format tick as zero-padded 10-digit number
  const tickFormatted = `TICK-${String(tickValue).padStart(10, '0')}`;

  // Use session or generate one
  const sessionId = session || getOrCreateSession();

  // Get session path (could be different from current working dir)
  const sessionPath = workingDir;

  // Build the CHRONOS stamp
  const stamp = `[CHRONOS] ${timestamp.iso8601}::${agent}::${cognitiveState}::${tickFormatted}::[${sessionId}]::[${sessionPath}] → ${action} - ${description}`;

  return {
    stamp,
    tick: tickValue,
    timestamp: {
      iso8601: timestamp.iso8601,
      nanoseconds: timestamp.nanoseconds.toString()
    },
    agent,
    cognitiveState,
    session: sessionId,
    workingDir,
    action,
    description
  };
}

/**
 * Get or create session ID
 * Session ID is stored in .cognitive/session.json
 */
function getOrCreateSession() {
  try {
    const sessionFile = path.join(process.cwd(), '.cognitive', 'session.json');

    if (fs.existsSync(sessionFile)) {
      const data = JSON.parse(fs.readFileSync(sessionFile, 'utf8'));
      return data.session_id;
    }

    // Create new session
    const sessionId = generateSessionId();
    const sessionDir = path.join(process.cwd(), '.cognitive');

    if (!fs.existsSync(sessionDir)) {
      fs.mkdirSync(sessionDir, { recursive: true });
    }

    fs.writeFileSync(sessionFile, JSON.stringify({
      session_id: sessionId,
      created_at: new Date().toISOString(),
      agent: 'claude-code'
    }, null, 2));

    return sessionId;
  } catch (error) {
    // Fallback to temp session ID
    return `temp-${Date.now()}`;
  }
}

/**
 * Generate a unique session ID
 */
function generateSessionId() {
  // Generate UUID v4-like ID
  const bytes = crypto.randomBytes(16);
  bytes[6] = (bytes[6] & 0x0f) | 0x40; // Version 4
  bytes[8] = (bytes[8] & 0x3f) | 0x80; // Variant

  const hex = bytes.toString('hex');
  return `${hex.substr(0, 8)}-${hex.substr(8, 4)}-${hex.substr(12, 4)}-${hex.substr(16, 4)}-${hex.substr(20, 12)}`;
}

/**
 * Get next tick value (auto-increments)
 */
function getNextTick() {
  try {
    const tickFile = path.join(process.cwd(), '.cognitive', 'tick.json');

    let currentTick = 0;

    if (fs.existsSync(tickFile)) {
      const data = JSON.parse(fs.readFileSync(tickFile, 'utf8'));
      currentTick = data.tick || 0;
    }

    const nextTick = currentTick + 1;

    const tickDir = path.join(process.cwd(), '.cognitive');
    if (!fs.existsSync(tickDir)) {
      fs.mkdirSync(tickDir, { recursive: true });
    }

    fs.writeFileSync(tickFile, JSON.stringify({
      tick: nextTick,
      updated_at: new Date().toISOString()
    }, null, 2));

    return nextTick;
  } catch (error) {
    return 1;
  }
}

/**
 * CLI usage
 */
if (require.main === module) {
  const args = process.argv.slice(2);

  if (args.includes('--help') || args.includes('-h')) {
    console.log(`
CHRONOS Stamp Generator - Web Runtime Version

Usage:
  chronos-stamp [options]

Options:
  --agent <name>          Agent name (default: claude-code)
  --state <state>         Cognitive state (default: Unknown)
  --tick <number>         Tick counter (auto-increments if not provided)
  --session <id>          Session ID (auto-generated if not provided)
  --action <action>       Action type (default: event)
  --description <desc>    Action description
  --json                  Output as JSON instead of plain stamp
  --help, -h              Show this help message

Examples:
  chronos-stamp --state "Thinking" --action "tool-completion" --description "Read file: main.js"
  chronos-stamp --state "Executing" --action "git-commit" --description "Add feature" --json

Output Format:
  [CHRONOS] <timestamp>::<agent>::<state>::TICK-<id>::[<session>]::[<pwd>] → <action> - <description>
`);
    process.exit(0);
  }

  // Parse arguments
  const options = {};
  for (let i = 0; i < args.length; i++) {
    switch (args[i]) {
      case '--agent':
        options.agent = args[++i];
        break;
      case '--state':
        options.cognitiveState = args[++i];
        break;
      case '--tick':
        options.tick = parseInt(args[++i]);
        break;
      case '--session':
        options.session = args[++i];
        break;
      case '--action':
        options.action = args[++i];
        break;
      case '--description':
        options.description = args[++i];
        break;
    }
  }

  const result = generateChronosStamp(options);

  if (args.includes('--json')) {
    console.log(JSON.stringify(result, null, 2));
  } else {
    console.log(result.stamp);
  }
}

module.exports = {
  generateChronosStamp,
  getHighResTimestamp,
  getOrCreateSession,
  getNextTick
};

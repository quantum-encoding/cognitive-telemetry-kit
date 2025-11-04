#!/usr/bin/env node

/**
 * Cognitive State Tracker - Web Runtime Version
 *
 * Provides API for tracking cognitive states in Claude Code web runtime.
 * Stores states in JSON files and generates CHRONOS stamps for git integration.
 */

const fs = require('fs');
const path = require('path');
const crypto = require('crypto');
const chronos = require('./chronos-stamp');

class CognitiveTracker {
  constructor(options = {}) {
    this.workingDir = options.workingDir || process.cwd();
    this.cognitiveDir = path.join(this.workingDir, '.cognitive');
    this.statesFile = path.join(this.cognitiveDir, 'states.json');
    this.sessionId = null;
    this.agent = options.agent || 'claude-code';
    this.initialized = false;
  }

  /**
   * Initialize the tracker
   * Creates .cognitive directory and session
   */
  async init() {
    try {
      // Create .cognitive directory
      if (!fs.existsSync(this.cognitiveDir)) {
        fs.mkdirSync(this.cognitiveDir, { recursive: true });
      }

      // Get or create session
      this.sessionId = chronos.getOrCreateSession();

      // Initialize states file if it doesn't exist
      if (!fs.existsSync(this.statesFile)) {
        const initialData = {
          session_id: this.sessionId,
          agent: this.agent,
          created_at: new Date().toISOString(),
          working_dir: this.workingDir,
          states: []
        };
        fs.writeFileSync(this.statesFile, JSON.stringify(initialData, null, 2));
      }

      this.initialized = true;
      return { success: true, sessionId: this.sessionId };
    } catch (error) {
      return { success: false, error: error.message };
    }
  }

  /**
   * Record a cognitive state
   * @param {Object} options - State options
   * @param {string} options.cognitiveState - The cognitive state
   * @param {string} options.action - Action type
   * @param {string} options.description - Action description
   * @returns {Object} The recorded state with CHRONOS stamp
   */
  async recordState(options = {}) {
    if (!this.initialized) {
      await this.init();
    }

    const {
      cognitiveState = 'Unknown',
      action = 'event',
      description = ''
    } = options;

    try {
      // Generate CHRONOS stamp
      const chronosResult = chronos.generateChronosStamp({
        agent: this.agent,
        cognitiveState,
        workingDir: this.workingDir,
        action,
        description,
        session: this.sessionId
      });

      // Create state record
      const state = {
        tick: chronosResult.tick,
        timestamp: chronosResult.timestamp.iso8601,
        timestamp_ns: chronosResult.timestamp.nanoseconds,
        cognitive_state: cognitiveState,
        action,
        description,
        working_dir: this.workingDir,
        session_path: this.workingDir,
        chronos_stamp: chronosResult.stamp,
        hash: this.hashState(chronosResult.stamp)
      };

      // Load existing states
      const data = JSON.parse(fs.readFileSync(this.statesFile, 'utf8'));

      // Check for duplicate (by hash)
      const isDuplicate = data.states.some(s => s.hash === state.hash);
      if (isDuplicate) {
        return { success: true, duplicate: true, state };
      }

      // Add new state
      data.states.push(state);

      // Write back to file
      fs.writeFileSync(this.statesFile, JSON.stringify(data, null, 2));

      return { success: true, duplicate: false, state };
    } catch (error) {
      return { success: false, error: error.message };
    }
  }

  /**
   * Get the latest cognitive state
   * @returns {Object|null} Latest state or null
   */
  async getLatestState() {
    try {
      if (!fs.existsSync(this.statesFile)) {
        return null;
      }

      const data = JSON.parse(fs.readFileSync(this.statesFile, 'utf8'));
      if (data.states.length === 0) {
        return null;
      }

      return data.states[data.states.length - 1];
    } catch (error) {
      return null;
    }
  }

  /**
   * Get all states
   * @param {Object} filters - Optional filters
   * @returns {Array} Array of states
   */
  async getStates(filters = {}) {
    try {
      if (!fs.existsSync(this.statesFile)) {
        return [];
      }

      const data = JSON.parse(fs.readFileSync(this.statesFile, 'utf8'));
      let states = data.states;

      // Apply filters
      if (filters.cognitiveState) {
        states = states.filter(s =>
          s.cognitive_state.toLowerCase().includes(filters.cognitiveState.toLowerCase())
        );
      }

      if (filters.action) {
        states = states.filter(s => s.action === filters.action);
      }

      if (filters.limit) {
        states = states.slice(-filters.limit);
      }

      return states;
    } catch (error) {
      return [];
    }
  }

  /**
   * Get statistics
   * @returns {Object} Statistics about recorded states
   */
  async getStats() {
    try {
      if (!fs.existsSync(this.statesFile)) {
        return {
          total_states: 0,
          unique_states: 0,
          session_id: this.sessionId,
          working_dir: this.workingDir
        };
      }

      const data = JSON.parse(fs.readFileSync(this.statesFile, 'utf8'));
      const states = data.states;

      // Count unique cognitive states
      const uniqueStates = new Set(states.map(s => s.cognitive_state));

      // Count actions
      const actionCounts = {};
      states.forEach(s => {
        actionCounts[s.action] = (actionCounts[s.action] || 0) + 1;
      });

      // Get top cognitive states
      const stateCounts = {};
      states.forEach(s => {
        stateCounts[s.cognitive_state] = (stateCounts[s.cognitive_state] || 0) + 1;
      });

      const topStates = Object.entries(stateCounts)
        .sort((a, b) => b[1] - a[1])
        .slice(0, 10)
        .map(([state, count]) => ({ state, count }));

      // Time range
      let timeRange = null;
      if (states.length > 0) {
        timeRange = {
          first: states[0].timestamp,
          last: states[states.length - 1].timestamp
        };
      }

      return {
        total_states: states.length,
        unique_states: uniqueStates.size,
        session_id: data.session_id,
        working_dir: this.workingDir,
        created_at: data.created_at,
        time_range: timeRange,
        action_counts: actionCounts,
        top_states: topStates
      };
    } catch (error) {
      return { error: error.message };
    }
  }

  /**
   * Export states to CSV
   * @param {string} outputFile - Output file path
   * @returns {Object} Export result
   */
  async exportToCSV(outputFile) {
    try {
      const states = await this.getStates();

      if (states.length === 0) {
        return { success: false, error: 'No states to export' };
      }

      // CSV headers
      const headers = [
        'tick',
        'timestamp',
        'cognitive_state',
        'action',
        'description',
        'working_dir',
        'session_id',
        'chronos_stamp'
      ];

      // Build CSV
      let csv = headers.join(',') + '\n';

      states.forEach(state => {
        const row = [
          state.tick,
          `"${state.timestamp}"`,
          `"${state.cognitive_state}"`,
          `"${state.action}"`,
          `"${state.description.replace(/"/g, '""')}"`,
          `"${state.working_dir}"`,
          `"${this.sessionId}"`,
          `"${state.chronos_stamp.replace(/"/g, '""')}"`
        ];
        csv += row.join(',') + '\n';
      });

      fs.writeFileSync(outputFile, csv);

      return { success: true, file: outputFile, count: states.length };
    } catch (error) {
      return { success: false, error: error.message };
    }
  }

  /**
   * Sync states to remote server
   * @param {string} serverUrl - Server URL
   * @returns {Object} Sync result
   */
  async syncToServer(serverUrl) {
    try {
      const states = await this.getStates();

      // This is a placeholder - would use fetch/axios in real implementation
      console.log(`Would sync ${states.length} states to ${serverUrl}`);

      return {
        success: true,
        synced: states.length,
        server: serverUrl
      };
    } catch (error) {
      return { success: false, error: error.message };
    }
  }

  /**
   * Hash a state for deduplication
   * @param {string} content - Content to hash
   * @returns {string} SHA256 hash
   */
  hashState(content) {
    return crypto.createHash('sha256').update(content).digest('hex');
  }
}

/**
 * CLI usage
 */
if (require.main === module) {
  const args = process.argv.slice(2);
  const tracker = new CognitiveTracker();

  async function main() {
    const command = args[0];

    switch (command) {
      case 'init':
        const initResult = await tracker.init();
        console.log(JSON.stringify(initResult, null, 2));
        break;

      case 'record':
        await tracker.init();
        const state = args[1] || 'Unknown';
        const action = args[2] || 'event';
        const description = args.slice(3).join(' ') || '';
        const recordResult = await tracker.recordState({
          cognitiveState: state,
          action,
          description
        });
        console.log(JSON.stringify(recordResult, null, 2));
        break;

      case 'latest':
        const latest = await tracker.getLatestState();
        if (latest) {
          console.log(latest.chronos_stamp);
        } else {
          console.log('No states recorded');
        }
        break;

      case 'stats':
        const stats = await tracker.getStats();
        console.log(JSON.stringify(stats, null, 2));
        break;

      case 'export':
        const outputFile = args[1] || 'cognitive-states.csv';
        const exportResult = await tracker.exportToCSV(outputFile);
        console.log(JSON.stringify(exportResult, null, 2));
        break;

      case 'list':
        const limit = parseInt(args[1]) || 10;
        const states = await tracker.getStates({ limit });
        states.forEach(s => console.log(s.chronos_stamp));
        break;

      default:
        console.log(`
Cognitive Tracker - Web Runtime Version

Usage:
  cognitive-tracker <command> [options]

Commands:
  init                           Initialize tracker in current directory
  record <state> <action> <desc> Record a cognitive state
  latest                         Get latest recorded state
  stats                          Show statistics
  export [file]                  Export to CSV (default: cognitive-states.csv)
  list [limit]                   List recent states (default: 10)

Examples:
  cognitive-tracker init
  cognitive-tracker record "Thinking" "tool-completion" "Read file: main.js"
  cognitive-tracker latest
  cognitive-tracker stats
  cognitive-tracker export analysis.csv
  cognitive-tracker list 20
`);
    }
  }

  main().catch(console.error);
}

module.exports = CognitiveTracker;

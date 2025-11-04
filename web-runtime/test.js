#!/usr/bin/env node

/**
 * Test Suite for Cognitive Telemetry Kit - Web Runtime Version
 */

const chronos = require('./chronos-stamp');
const CognitiveTracker = require('./cognitive-tracker');
const fs = require('fs');
const path = require('path');

// ANSI color codes
const colors = {
  reset: '\x1b[0m',
  green: '\x1b[32m',
  red: '\x1b[31m',
  yellow: '\x1b[33m',
  blue: '\x1b[34m',
  bold: '\x1b[1m'
};

function log(msg, color = 'reset') {
  console.log(`${colors[color]}${msg}${colors.reset}`);
}

function logSection(title) {
  console.log('\n' + '='.repeat(60));
  log(title, 'bold');
  console.log('='.repeat(60));
}

async function test(name, fn) {
  try {
    await fn();
    log(`✓ ${name}`, 'green');
    return true;
  } catch (error) {
    log(`✗ ${name}`, 'red');
    log(`  Error: ${error.message}`, 'red');
    return false;
  }
}

async function runTests() {
  let passed = 0;
  let failed = 0;

  log('\n╔═══════════════════════════════════════════════════════════╗', 'blue');
  log('║    CHRONOS Cognitive Telemetry - Web Runtime Tests       ║', 'blue');
  log('╚═══════════════════════════════════════════════════════════╝', 'blue');

  // Test 1: High-resolution timestamp
  logSection('Test 1: High-Resolution Timestamp');
  if (await test('Generate high-resolution timestamp', async () => {
    const ts = chronos.getHighResTimestamp();
    if (!ts.iso8601 || !ts.nanoseconds) {
      throw new Error('Invalid timestamp format');
    }
    log(`  Timestamp: ${ts.iso8601}`, 'blue');
    log(`  Nanoseconds: ${ts.nanoseconds}`, 'blue');
  })) {
    passed++;
  } else {
    failed++;
  }

  // Test 2: CHRONOS stamp generation
  logSection('Test 2: CHRONOS Stamp Generation');
  if (await test('Generate CHRONOS stamp', async () => {
    const result = chronos.generateChronosStamp({
      agent: 'test-agent',
      cognitiveState: 'Testing',
      action: 'test-action',
      description: 'Unit test'
    });
    if (!result.stamp || !result.stamp.includes('[CHRONOS]')) {
      throw new Error('Invalid CHRONOS stamp');
    }
    log(`  Stamp: ${result.stamp}`, 'blue');
    log(`  Tick: ${result.tick}`, 'blue');
  })) {
    passed++;
  } else {
    failed++;
  }

  // Test 3: Session creation
  logSection('Test 3: Session Management');
  if (await test('Create session ID', async () => {
    const sessionId = chronos.getOrCreateSession();
    if (!sessionId || sessionId.length < 10) {
      throw new Error('Invalid session ID');
    }
    log(`  Session ID: ${sessionId}`, 'blue');
  })) {
    passed++;
  } else {
    failed++;
  }

  // Test 4: Cognitive tracker initialization
  logSection('Test 4: Cognitive Tracker Initialization');
  const tracker = new CognitiveTracker({ agent: 'test-agent' });
  if (await test('Initialize tracker', async () => {
    const result = await tracker.init();
    if (!result.success) {
      throw new Error('Failed to initialize tracker');
    }
    log(`  Session ID: ${result.sessionId}`, 'blue');
  })) {
    passed++;
  } else {
    failed++;
  }

  // Test 5: Record cognitive state
  logSection('Test 5: Record Cognitive State');
  if (await test('Record state', async () => {
    const result = await tracker.recordState({
      cognitiveState: 'Testing deeply',
      action: 'test-execution',
      description: 'Recording test state'
    });
    if (!result.success || !result.state) {
      throw new Error('Failed to record state');
    }
    log(`  State: ${result.state.cognitive_state}`, 'blue');
    log(`  Tick: ${result.state.tick}`, 'blue');
    log(`  CHRONOS: ${result.state.chronos_stamp}`, 'blue');
  })) {
    passed++;
  } else {
    failed++;
  }

  // Test 6: Get latest state
  logSection('Test 6: Retrieve Latest State');
  if (await test('Get latest state', async () => {
    const latest = await tracker.getLatestState();
    if (!latest || !latest.chronos_stamp) {
      throw new Error('Failed to get latest state');
    }
    log(`  Latest: ${latest.chronos_stamp}`, 'blue');
  })) {
    passed++;
  } else {
    failed++;
  }

  // Test 7: Record multiple states
  logSection('Test 7: Record Multiple States');
  if (await test('Record multiple states', async () => {
    const states = [
      { cognitiveState: 'Thinking', action: 'analysis', description: 'Analyzing code' },
      { cognitiveState: 'Executing', action: 'tool-use', description: 'Running tests' },
      { cognitiveState: 'Verifying', action: 'validation', description: 'Checking results' }
    ];

    for (const state of states) {
      await tracker.recordState(state);
    }

    const allStates = await tracker.getStates();
    if (allStates.length < 4) { // 1 from previous test + 3 new
      throw new Error('Not all states were recorded');
    }
    log(`  Total states recorded: ${allStates.length}`, 'blue');
  })) {
    passed++;
  } else {
    failed++;
  }

  // Test 8: Get statistics
  logSection('Test 8: Get Statistics');
  if (await test('Get statistics', async () => {
    const stats = await tracker.getStats();
    if (!stats || stats.total_states === 0) {
      throw new Error('Failed to get statistics');
    }
    log(`  Total states: ${stats.total_states}`, 'blue');
    log(`  Unique states: ${stats.unique_states}`, 'blue');
    log(`  Top states:`, 'blue');
    stats.top_states.slice(0, 5).forEach(s => {
      log(`    - ${s.state}: ${s.count}`, 'blue');
    });
  })) {
    passed++;
  } else {
    failed++;
  }

  // Test 9: Export to CSV
  logSection('Test 9: Export to CSV');
  if (await test('Export to CSV', async () => {
    const csvFile = path.join(process.cwd(), '.cognitive', 'test-export.csv');
    const result = await tracker.exportToCSV(csvFile);
    if (!result.success) {
      throw new Error('Failed to export to CSV');
    }
    if (!fs.existsSync(csvFile)) {
      throw new Error('CSV file was not created');
    }
    const csvContent = fs.readFileSync(csvFile, 'utf8');
    const lines = csvContent.split('\n').filter(l => l.trim());
    log(`  CSV file: ${csvFile}`, 'blue');
    log(`  Rows exported: ${result.count}`, 'blue');
    log(`  Lines in file: ${lines.length - 1} (excluding header)`, 'blue');
  })) {
    passed++;
  } else {
    failed++;
  }

  // Test 10: Deduplication
  logSection('Test 10: State Deduplication');
  if (await test('Prevent duplicate states', async () => {
    const beforeCount = (await tracker.getStates()).length;

    // Record same state twice
    await tracker.recordState({
      cognitiveState: 'Duplicate Test',
      action: 'test',
      description: 'Same state'
    });

    const result = await tracker.recordState({
      cognitiveState: 'Duplicate Test',
      action: 'test',
      description: 'Same state'
    });

    const afterCount = (await tracker.getStates()).length;

    if (!result.duplicate) {
      throw new Error('Duplicate was not detected');
    }

    if (afterCount !== beforeCount + 1) {
      throw new Error(`Expected ${beforeCount + 1} states, got ${afterCount}`);
    }

    log(`  Duplicate detected: ${result.duplicate}`, 'blue');
    log(`  States before: ${beforeCount}`, 'blue');
    log(`  States after: ${afterCount}`, 'blue');
  })) {
    passed++;
  } else {
    failed++;
  }

  // Test 11: Tick auto-increment
  logSection('Test 11: Tick Auto-Increment');
  if (await test('Tick auto-increments', async () => {
    const state1 = await tracker.recordState({
      cognitiveState: 'First',
      action: 'test',
      description: 'First'
    });

    const state2 = await tracker.recordState({
      cognitiveState: 'Second',
      action: 'test',
      description: 'Second'
    });

    if (state2.state.tick <= state1.state.tick) {
      throw new Error('Tick did not auto-increment');
    }

    log(`  State 1 tick: ${state1.state.tick}`, 'blue');
    log(`  State 2 tick: ${state2.state.tick}`, 'blue');
  })) {
    passed++;
  } else {
    failed++;
  }

  // Summary
  logSection('Test Summary');
  const total = passed + failed;
  log(`Total tests: ${total}`, 'bold');
  log(`Passed: ${passed}`, 'green');
  log(`Failed: ${failed}`, failed > 0 ? 'red' : 'green');
  log(`Success rate: ${((passed / total) * 100).toFixed(1)}%`, failed > 0 ? 'yellow' : 'green');

  console.log('\n');

  if (failed === 0) {
    log('🎉 All tests passed!', 'green');
    return 0;
  } else {
    log('⚠️  Some tests failed', 'red');
    return 1;
  }
}

// Run tests
runTests()
  .then(exitCode => process.exit(exitCode))
  .catch(error => {
    log(`Fatal error: ${error.message}`, 'red');
    process.exit(1);
  });

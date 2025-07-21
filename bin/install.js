#!/usr/bin/env node #shebang for node js

const fs = require('fs');
const path = require('path');

const hookSrc = path.join(__dirname, '..', 'hook.sh');
const hookDest = path.join(process.cwd(), '.git', 'hooks', 'commit-msg');

if (!fs.existsSync('.git')) {
  console.error('❌ Not a git repository. Run this inside your project folder.');
  process.exit(1);
}

fs.copyFileSync(hookSrc, hookDest); // Copies hook.sh → .git/hooks/commit-msg
fs.chmodSync(hookDest, 0o755); //akes the copied hook file executable (required by Git hooks).
// 0o755 means:
// Owner can read/write/execute
// Group and others can read/execute
console.log('✅ commit-muse installed: commit-msg hook ready!');

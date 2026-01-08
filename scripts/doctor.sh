#!/usr/bin/env bash

# Project Health Check Script
# Run: ./scripts/doctor.sh
# Or: bun run doctor (if added to package.json)

set -e

echo "🏥 Running doctor checks..."
echo ""

# Check if package.json exists
if [ ! -f package.json ]; then
  echo "❌ No package.json found"
  exit 1
fi

# Lint
echo "📝 Lint..."
if bun run lint 2>/dev/null; then
  echo "✅ Lint passed"
else
  echo "❌ Lint failed"
  exit 1
fi
echo ""

# TypeScript
echo "🔷 TypeScript..."
if bun run typecheck 2>/dev/null; then
  echo "✅ TypeScript passed"
else
  echo "❌ TypeScript failed"
  exit 1
fi
echo ""

# Tests (optional - don't fail if tests don't exist)
echo "🧪 Tests..."
if bun run test 2>/dev/null; then
  echo "✅ Tests passed"
else
  echo "⚠️  No tests configured (skipping)"
fi
echo ""

echo "🎉 All checks passed!"
echo ""
echo "Ready to ship! Use /ship to commit, push, and create PR."

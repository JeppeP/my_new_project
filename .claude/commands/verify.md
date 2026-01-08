# Verify Code Quality

Run all checks to ensure code quality and correctness.

## Workflow

Run each check in order and show clear status:

1. **Lint** - Check code style and quality
   ```bash
   bun run lint
   ```

2. **TypeScript** - Check type safety
   ```bash
   bun run typecheck
   ```

3. **Tests** - Run tests (optional)
   ```bash
   bun run test 2>/dev/null || echo "No tests configured"
   ```

## Output Format

Show clear status for each check with emojis:

```
🔍 Running verification...

📝 Lint:
✅ Lint passed

🔷 TypeScript:
✅ TypeScript passed

🧪 Tests:
✅ Tests passed (or "No tests configured")

✅ All checks passed!
```

## On Failure

If any check fails:

1. Show the error clearly with line numbers and details
2. Explain what the error means
3. STOP - do not continue
4. Suggest how to fix it

Example:
```
❌ Lint check failed!

Error in src/components/Button.tsx:42
  no-unused-vars: 'isLoading' is defined but never used

Fix: Remove the variable or use it in the component
```

## When to Run

Run `/verify`:
- Before committing major changes
- Before running `/ship`
- After making significant refactoring
- Anytime you want to check code quality

## Rules

- Show status for each check even if it passes
- STOP immediately if any critical check fails
- Tests are optional (don't fail if no test script exists)
- Use clear, human-readable error messages
- Suggest fixes when possible

## Tips

- Run this before `/ship` to catch issues early
- Fix errors immediately - don't let them pile up
- All checks should pass before pushing to remote

# Ship Changes

Verify, commit, push, and create a PR - all in one seamless workflow.

## Workflow

1. **Verify quality first:**
   - Run `bun run lint`
   - Run `bun run typecheck`
   - Run `bun run test` (optional, skip if no test script)
   - If any check fails → STOP and show errors clearly
   - If all pass → continue

2. **Prepare commit:**
   - Run `git status` to see changes
   - Run `git diff --stat` for summary
   - Generate descriptive commit message (conventional commits format)
   - Show proposed message and ask for confirmation

3. **Commit locally:**
   - Run `git add .`
   - Run `git commit -m "message"`

4. **Push to remote:**
   - Run `git push -u origin HEAD`

5. **Create pull request:**
   - Use `gh pr create --title "..." --body "..."`
   - Title = commit message
   - Body = summary of changes + what to test
   - Default to `main` branch as base

6. **Show result:**
   - Return PR URL
   - Show success message

## Verification Commands

```bash
bun run lint          # Code quality
bun run typecheck     # TypeScript checks
bun run test          # Tests (optional)
```

## Commit Message Format

Follow conventional commits:
- `feat(scope): description`
- `fix(scope): description`
- `refactor(scope): description`

Examples:
- `feat(auth): add login form validation`
- `fix(convex): handle realtime errors`
- `refactor: simplify button component`

## On Verification Failure

If lint or typecheck fails:
1. Show the error clearly
2. Explain what needs fixing
3. STOP - do not continue
4. Suggest how to fix

Example:
```
❌ Lint check failed!

Error: src/components/Button.tsx:42
  Unused variable 'isLoading'

Fix by removing the variable or using it.
```

## PR Body Template

```markdown
## Summary
[1-2 sentences describing what this PR does]

## Changes
- [What changed]
- [What changed]

## Testing
- [ ] Manual testing: [how to test]
- [ ] Related tests pass
- [ ] No lint/type errors

## References
- Task: [link to task if applicable]
```

## Rules

- ALWAYS run verification first
- STOP if any check fails
- Only push after all checks pass
- Use task ID in commit message when working on a task
- PR title should be clear and descriptive
- Include testing instructions in PR body

## Success Output

When everything succeeds, show:
```
✅ All checks passed!
✅ Committed: feat(auth): add login form validation
✅ Pushed to origin
🚀 Pull Request created: https://github.com/.../pull/123
```

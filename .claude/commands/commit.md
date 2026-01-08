# Commit Changes

Create a well-crafted commit for current changes.

## Workflow

1. Run `git status` to see what files have changed
2. Run `git diff --stat` to show summary of changes
3. Analyze the changes and generate a descriptive commit message
4. Follow conventional commits format: `type(scope): description`
5. Show me the proposed commit message and ask for confirmation
6. If confirmed, run `git add .` and `git commit -m "your message"`
7. Show the commit hash and confirm success

## Commit Message Format

Use conventional commits:

- **feat**: New feature
- **fix**: Bug fix
- **refactor**: Code refactoring
- **docs**: Documentation
- **style**: Formatting/code style
- **test**: Test changes
- **chore**: Maintenance/dependencies

**Example:**
```
feat(auth): add login form validation
fix(convex): handle realtime subscription errors
refactor(components): simplify button component
```

## Rules

- Keep first line under 72 characters
- Be specific about what changed and why
- Reference task ID if working on a task (e.g., "feat: add dark mode (2025-01-08_dark-mode)")
- Do NOT push to remote (use `/ship` for that)
- Do NOT create PR (use `/ship` for that)

## After Commit

Show:
- Commit hash
- Commit message
- Success message

Example output:
```
✅ Committed!
📝 b3f2a8c - feat(auth): add login form validation
```

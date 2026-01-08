# Agent Permissions

This file defines which Bash commands AI agents are allowed to execute in this repository.

## Permission Levels

### `allow` - Auto-execute without confirmation

These commands run automatically and are safe for the agent to execute without user intervention.

#### Testing & Validation
- `npm run test:*` - Run tests (essential for verification)
- `npm run typecheck:*` - Type checking (find bugs early)
- `npm run lint:*` - Linting (code quality checks)
- `npm run lint:fix:*` - Auto-fix linting issues
- `bun run test:*` - Bun test runner
- `bun run typecheck:*` - Bun type checking
- `bun run lint:*` - Bun linting
- `bun run lint:fix:*` - Bun auto-fix linting

#### Building
- `npm run build:*` - Build the project (safe, creates artifacts)
- `npm run format:*` - Format code (prettier/beautifier)
- `bun run build:*` - Bun build runner
- `bun run format:*` - Bun formatting

#### Development
- `npm run dev:*` - Run dev server (local only, safe)
- `bun run dev:*` - Bun dev server
- `./scripts/:*` - Project-specific scripts

#### Git (Safe, Read-Only)
- `git add:*` - Stage files (doesn't commit or push)
- `git commit:*` - Commit changes (local only, safe)
- `git diff:*` - View changes without affecting repo
- `git status:*` - Check repo status
- `git log:*` - View commit history

#### Docker (Inspection Only)
- `docker ps:*` - List running containers (read-only)
- `docker logs:*` - View container logs (read-only)

#### File Operations
- `find:*` - Search for files (read-only)
- `grep:*` - Search file contents (read-only)
- `cat:*` - Display file contents (read-only)
- `comm:*` - Compare files (read-only)

---

### `ask` - Require confirmation before executing

These commands need user confirmation because they make changes to the repository or access sensitive data.

#### Git (Mutations)
- `git push:*` - Push changes to remote (critical operation)
- `git pull:*` - Pull from remote (can cause conflicts)
- `git rebase:*` - Rebase commits (complex operation)
- `git reset:*` - Reset commits (can lose work)
- `git branch:*` - Create/delete branches

#### Package Management
- `npm install:*` - Install/update dependencies (modifies package.json)
- `npm ci:*` - Clean install (modifies node_modules)
- `npm publish:*` - Publish to npm registry (public action)
- `npm run migrate:*` - Database migrations (modifies data)
- `npm run seed:*` - Database seeding (modifies data)
- `bun install:*` - Bun package installation
- `bun run migrate:*` - Bun migrations
- `bun run seed:*` - Bun database seeding

#### Docker (Mutations)
- `docker build:*` - Build Docker image (time-consuming, resource-heavy)
- `docker run:*` - Run Docker container (starts processes)
- `docker-compose up:*` - Start docker-compose services (complex)
- `docker-compose down:*` - Stop docker-compose services (stops running services)

#### Secrets & Environment
- `Read(.env*)` - Read environment variables (may contain secrets)
- `Read(convex/.env*)` - Read Convex backend secrets (sensitive data)

---

### `deny` - Block completely

These commands are never allowed. They are safety-critical and can cause irreversible damage.

#### Destructive Git Operations
- `Bash(git checkout .)` - Discard all uncommitted changes (data loss)
- `Bash(git clean:*)` - Remove untracked files (irreversible)
- `Bash(git branch -D:*)` - Force-delete branch (lose commits)
- `Bash(git reset --hard:*)` - Hard reset (lose all changes)

#### Destructive File Operations
- `Bash(rm -rf:*)` - Recursive delete (catastrophic, irreversible)
- `Bash(rm -f:*)` - Force delete (irreversible)
- `Bash(rm :*)` - Base remove command (prevent accidents)

#### Compilation & Binaries
- `Bash(cc:*)` - C compiler (executing arbitrary code)
- `Bash(gcc:*)` - GNU C compiler (executing arbitrary code)
- `Bash(g++:*)` - GNU C++ compiler (executing arbitrary code)

#### Privilege Escalation
- `Bash(sudo:*)` - Elevated privileges (dangerous access)

#### System Operations
- `Bash(kill:*)` - Kill processes (can break dev environment)
- `Bash(killall:*)` - Kill all matching processes (dangerous)
- `Bash(npx kill-port:*)` - Kill by port (can break dev setup)

#### Secrets (Strict)
- `Read(.env.local)` - Local secrets (machine-specific, must protect)
- `Read(.env.production)` - Production secrets (critical, must protect)

---

## Security Philosophy

### Why This Design?

✅ **Fast iteration without friction**
- Tests, linting, building happen automatically
- No unnecessary confirmations for safe operations
- File inspection (grep, find, cat) is instant

✅ **Control over critical operations**
- Git push requires confirmation (prevents accidents)
- Package installation requires confirmation (prevents supply chain issues)
- Docker operations require confirmation (resource-intensive)
- Data mutations (migrations, seeds) require confirmation

✅ **Maximum protection for secrets**
- All .env files are blocked unless explicitly needed
- Production secrets are strictly forbidden
- No arbitrary code execution (cc/gcc blocked)
- No privilege escalation (sudo blocked)

✅ **Destructive operations are impossible**
- No recursive deletes
- No force git operations
- No hard resets
- Agent cannot accidentally ruin the repository

---

## Adding New Permissions

If you need to allow additional commands, add them to the appropriate section:

```json
"allow": {
  "custom_category": [
    "Bash(npm run custom-command:*)"
  ]
}
```

Or for ask-level permissions:

```json
"ask": {
  "custom_category": [
    "Bash(npm run risky-command:*)"
  ]
}
```

Then commit `.claude/permissions.json` to git.

---

## Common Patterns

### Running Tests
All test commands are ALLOW:
- `npm run test` - ✅ Auto-runs
- `bun run test` - ✅ Auto-runs
- Agent can verify changes instantly

### Code Quality
All quality checks are ALLOW:
- `npm run lint` - ✅ Auto-runs
- `npm run typecheck` - ✅ Auto-runs
- `npm run format` - ✅ Auto-runs
- Agent ensures code quality automatically

### Git Workflow
Safe git operations are ALLOW, mutations are ASK:
- `git add` - ✅ Auto-runs (staging)
- `git commit` - ✅ Auto-runs (local commit)
- `git push` - ❓ Requires confirmation (remote change)
- `git pull` - ❓ Requires confirmation (can cause conflicts)

### Docker Operations
Inspection is ALLOW, changes are ASK:
- `docker ps` - ✅ Auto-runs (status check)
- `docker logs` - ✅ Auto-runs (debugging)
- `docker build` - ❓ Requires confirmation (resource-heavy)
- `docker run` - ❓ Requires confirmation (starts services)

---

## Customization by Project

This is a safe default configuration. Customize based on your needs:

**Stricter:** Move more commands to `ask` or `deny`  
**Looser:** Move more commands from `ask` to `allow`

Example: If you trust agents completely with database migrations:
```json
"allow": {
  "database": [
    "Bash(npm run migrate:*)",
    "Bash(npm run seed:*)"
  ]
}
```

---

## Questions?

- **Want to understand the workflow?** Read `CLAUDE.md`
- **Want to know the contract?** Read `AGENTS.md`
- **Creating a new project from template?** Read `TEMPLATE.md`

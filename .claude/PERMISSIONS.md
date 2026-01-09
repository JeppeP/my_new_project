# Agent Permissions

This file defines which Bash commands AI agents are allowed to execute in this repository.

## Permission Levels

### `allow` - Auto-execute without confirmation

These commands run automatically and are safe for the agent to execute without user intervention.

#### Testing & Validation
- `bun run test:*` - Bun test runner (essential for verification)
- `bun run typecheck:*` - Bun type checking (find bugs early)
- `bun run lint:*` - Bun linting (code quality checks)
- `bun run lint:fix:*` - Bun auto-fix linting
- `npm run test:*` - npm test runner (fallback for compatibility)
- `npm run typecheck:*` - npm type checking (fallback)
- `npm run lint:*` - npm linting (fallback)
- `npm run lint:fix:*` - npm auto-fix (fallback)

#### Building
- `bun run build:*` - Bun build runner (safe, creates artifacts)
- `bun run format:*` - Bun formatting (code beautifier)
- `bun run preview:*` - Preview production build locally (safe, read-only)
- `npm run build:*` - npm build (fallback for compatibility)
- `npm run format:*` - npm format (fallback for compatibility)

#### Development
- `bun run dev:*` - Bun dev server (local only, safe)
- `bunx convex dev:*` - Convex backend (required for development)
- `npm run dev:*` - npm dev server (fallback for compatibility)
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
- `docker-compose logs:*` - View docker-compose service logs (read-only)

#### File Operations
- `find:*` - Search for files (read-only)
- `grep:*` - Search file contents (read-only)
- `cat:*` - Display file contents (read-only)
- `comm:*` - Compare files (read-only)
- `lsof:*` - List open files (troubleshooting port conflicts, read-only)

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
- `bun install:*` - Bun package installation (modifies dependencies)
- `bun run migrate:*` - Bun database migrations (modifies data)
- `bun run seed:*` - Bun database seeding (modifies data)
- `npm install:*` - npm installation (fallback, modifies package.json)
- `npm ci:*` - npm clean install (fallback, modifies node_modules)
- `npm publish:*` - Publish to npm registry (public action)
- `npm run migrate:*` - npm migrations (fallback)
- `npm run seed:*` - npm seeding (fallback)

#### Docker (Mutations)
- `docker build:*` - Build Docker image (time-consuming, resource-heavy)
- `docker run:*` - Run Docker container (starts processes)
- `docker-compose up:*` - Start docker-compose services (complex state change)
- `docker-compose down:*` - Stop docker-compose services (stops running services)
- `docker-compose build:*` - Build docker-compose images (resource-heavy)
- `docker-compose exec:*` - Execute command in running container (arbitrary execution)
- `docker-compose restart:*` - Restart docker-compose services (service mutation)

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
- `bun run test` - ✅ Auto-runs (primary)
- `npm run test` - ✅ Auto-runs (compatibility)
- Agent can verify changes instantly

### Code Quality
All quality checks are ALLOW:
- `bun run lint` - ✅ Auto-runs
- `bun run typecheck` - ✅ Auto-runs
- `bun run format` - ✅ Auto-runs
- Agent ensures code quality automatically

### Convex Backend
- `bunx convex dev` - ✅ Auto-runs (required for development)
- Starts the Convex backend for realtime database access

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
- `docker-compose logs` - ✅ Auto-runs (view service logs)
- `lsof -i :5173` - ✅ Auto-runs (troubleshoot port conflicts)
- `docker build` - ❓ Requires confirmation (resource-heavy)
- `docker run` - ❓ Requires confirmation (starts services)
- `docker-compose up` - ❓ Requires confirmation (complex state change)
- `docker-compose exec` - ❓ Requires confirmation (arbitrary execution)

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

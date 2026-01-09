# CLAUDE.md

This project uses **AGENTS.md** as the single source of truth for all rules, tech stack, and workflow instructions.

**→ Read AGENTS.md before starting any task.**

---

## Quick Reference

### Essential Commands

```bash
bun install       # Install dependencies
bun run dev       # Start dev server (http://localhost:5173)
bunx convex dev   # Start Convex backend (separate terminal)
bun run build     # Build for production
bun run lint      # Check code quality
bun run test      # Run tests
```

### Docker Commands

```bash
# Development (with Docker)
docker-compose up          # Start frontend in Docker
bunx convex dev            # Start Convex backend (separate terminal)

# Stop containers
docker-compose down

# Rebuild after dependency changes
docker-compose build --no-cache

# View logs
docker-compose logs -f frontend

# Production preview
docker-compose -f docker-compose.prod.yml up
```

**Full Docker guide:** See `docs/DOCKER.md` for detailed setup, troubleshooting, and best practices.

---

## Core Workflow Principles

These principles ensure we build great software efficiently. See **AGENTS.md** for full details.

### Before Any Task
- **Read first** - Always read relevant files before proposing changes
- **Never speculate** - Don't make claims about code you haven't seen
- **Plan in plan mode** - For non-trivial tasks, use shift+tab twice

### During Implementation
- **Simplicity first** - Smallest possible change that works
  - Touch fewest files
  - Change fewest lines
  - No "while we're here" refactors
- **Check major changes** - Propose plan before implementing significant changes
- **High-level summaries** - Explain what changed, not just how

### After Each Session
- **Self-review** - Check code for quality, security, efficiency
- **Update docs** - Keep ARCHITECTURE.md current with structural changes
- **Never speculate** - Back up claims with actual code

### Model
- **Recommended:** Claude Opus 4.5 for everything
- Run `claude model` to verify
- It's faster and more cost-efficient than smaller models

---

### Hard Rules (Do NOT)

- Change the tech stack (React + Vite + Bun + Convex are fixed)
- Add new libraries without asking
- Propose switching frameworks (Next.js, Remix, SvelteKit, etc.)
- Make large refactors unless explicitly asked

### Always Include

Every feature needs:
- Loading state (skeletons for lists)
- Empty state (helpful copy + action)
- Error state (clear message + recovery)
- Success feedback (subtle toast)

---

## Getting Started

1. **New to this project?** Read AGENTS.md for full context
2. **Setting up from template?** See SETUP_NEW_PROJECT.md
3. **Creating a feature?** Propose a plan first (use AGENTS.md workflow)

---

## Convex (Backend)

**Key concept:** Convex is both database and backend.

- **Queries** (`/convex/queries/`) read data, auto-update in realtime
- **Mutations** (`/convex/mutations/`) write/modify data
- **Schema** (`/convex/schema.ts`) defines database structure

```typescript
// Example: Using a Convex query in React
const tasks = useQuery(api.queries.getTasks);
```

---

## Agent Permissions

See `.claude/permissions.json` for detailed command allowlist.

**Quick version:**
- ✅ Auto-run: npm/bun run (test, lint, build, dev), git read-only, file inspection
- ❓ Ask first: git push/pull, npm/bun install, docker ops, env reads
- 🚫 Blocked: rm -rf, git checkout ., sudo, secrets, compilation

---

## File References

- **AGENTS.md** - Master rules (source of truth)
- **README.md** - Quick start for humans
- **SETUP_NEW_PROJECT.md** - Template guide
- **docs/PLAN.md** - Project plan/roadmap
- **docs/DECISIONS.md** - Architecture decisions
- **docs/FEATURE_SPEC.md** - Feature specifications
- **docs/ARCHITECTURE.md** - Technical structure and patterns
- **.claude/permissions.json** - Safety rules
- **.claude/PERMISSIONS.md** - Why each rule exists

---

## Advanced Workflows

For maximum productivity, you can run multiple Claude Code sessions in parallel (inspired by Boris Churney's workflow):

- **Terminal Sessions (5+):** Use a terminal wrapper like Ghosty to split terminals. Run multiple Claude Code instances, each on a different task.
- **Web Agents (5-10):** Use claude.ai Claude Code section to spin up agents that work on tasks while you're away (perfect before bed or when at the gym).
- **Result:** Always building. Your app improves even when you're not working.

See Boris Churney's workflow thread for more details on scaling your development process.

---

## Questions?

Everything is in AGENTS.md. If something is unclear, the answer is almost certainly there.

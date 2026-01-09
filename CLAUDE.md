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
- **.claude/permissions.json** - Safety rules
- **.claude/PERMISSIONS.md** - Why each rule exists

---

## Questions?

Everything is in AGENTS.md. If something is unclear, the answer is almost certainly there.

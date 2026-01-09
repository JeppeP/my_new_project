# Project Template

A modern, optimized template for building web apps with React, Vite, Bun, and Convex.

## Quick Start

```bash
# 1. Install dependencies
bun install

# 2. In one terminal: Start Convex backend
bunx convex dev

# 3. In another terminal: Start Vite dev server
bun run dev
```

Open http://localhost:5173

## Quick Start (with Docker)

For project isolation and consistency across team members, use Docker:

```bash
# 1. Copy environment template
cp .env.example .env.local

# 2. Initialize Convex and update .env.local with values
bunx convex dev

# 3. Terminal 1: Start Convex backend (on host machine)
bunx convex dev

# 4. Terminal 2: Start Docker frontend
docker-compose up
```

Open http://localhost:5173

**Full Docker guide:** See `docs/DOCKER.md` for detailed setup, troubleshooting, and best practices.

## Tech Stack

- **Frontend:** React + TypeScript + Tailwind CSS + Vite
- **Backend:** Convex (database + realtime + backend logic)
- **Tooling:** Bun

## Key Features

- ⚡ **Instant feel** - Optimistic updates, real-time sync
- 🔄 **Live updates** - Convex reactive queries
- 🎨 **Beautiful UI** - Tailwind CSS + design system
- 📦 **Zero config** - Convex + Vite = minimal setup
- ♿ **Accessible** - WCAG minimum standards

## Convex Basics

Convex handles both database and backend logic:

- **Queries** - Read data, auto-updates in realtime
  ```typescript
  const tasks = useQuery(api.queries.getTasks);
  ```

- **Mutations** - Write/modify data
  ```typescript
  const createTask = useMutation(api.mutations.createTask);
  ```

- **Schema** - Database structure in `/convex/schema.ts`

## Development

```bash
bun run lint       # Check code quality
bun run typecheck  # Run TypeScript checker
bun run test       # Run tests
bun run build      # Build for production
```

## Project Rules

See **AGENTS.md** for complete rules, tech stack details, and working process.

Key principles:
- Small, incremental changes
- Every feature includes loading/empty/error/success states
- Simple, readable code over clever abstractions
- Always include UI feedback (loading, errors, success)

## AI-Assisted Workflow

This project is optimized for Claude Code / OpenCode:

- **START_PROJECT_GUIDE.md** - Step-by-step guide to start a new project (read this first!)
- **AGENTS.md** - Source of truth (tech stack, rules, workflow)
- **CLAUDE.md** - Quick reference for Claude Code
- **.claude/** - Permissions, prompts, checklists

### For Long-Running Projects

- **EPIC_QUICKSTART.md** - 5-minute intro to epic harness mode
- **EPIC_COMPLETE_GUIDE.md** - 15-minute detailed epic workflow guide
- **docs/epics/2026-01_example-realtime-sync/** - Complete example epic

## Creating a Feature

1. Create a task folder: `tasks/YYYY-MM-DD_task-name/`
2. Add `task.md` with description and acceptance criteria
3. Add `JOURNAL.md` to track progress
4. Reference task in your requests to Claude/OpenCode

See AGENTS.md for detailed workflow.

## Documentation

- **AGENTS.md** - Master rules and source of truth
- **CLAUDE.md** - Quick reference
- **docs/PLAN.md** - Project plan (when ready)
- **docs/DECISIONS.md** - Architecture decisions
- **docs/FEATURE_SPEC.md** - Feature specifications

## Questions?

See AGENTS.md for comprehensive project guidance.

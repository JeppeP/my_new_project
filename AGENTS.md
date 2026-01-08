# AGENTS.md

Master rules and source of truth for this project. All AI agents (Claude, OpenCode, Codex) should read this file first.

---

## IMPORTANT — Source of Truth

This file is the single source of truth for:
- Tech stack (fixed, do not change)
- Architectural decisions
- Hard rules
- Working process
- Commands

If anything conflicts with other suggestions, THIS FILE WINS.

---

## Project Goal

Build a modern web app with a fast, responsive feel.

**Responsibility:**
- I (Jesper) define product, UX, flow, and "feel"
- You (AI model) implement everything in code

Assume I am non-technical unless stated otherwise.

---

## Fixed Tech Stack (do not change)

### Frontend
- React
- TypeScript
- Tailwind CSS
- Vite (as the React build tool / dev server)

### Tooling
- Bun (package manager + runtime for local dev)

### Backend
- Convex (database + backend logic + realtime)
- Use Convex reactive queries for live updates
- Use Convex mutations for writes
- Use Convex scheduled/cron functions when needed

---

## Hard Rules

- **Do NOT** propose switching to Next.js, Remix, SvelteKit, Supabase, Firebase, etc.
- **Do NOT** add new libraries without asking first
- Prefer boring, simple, readable code over clever abstractions
- Keep everything working at all times (small, incremental changes)

---

## Project Structure (preferred)

```
src/
  components/        # Shared UI components
  features/          # Feature folders: ui + hooks + helpers
  lib/               # Shared utilities, api clients
  routes/            # Route-level pages (if using routing)
convex/
  schema.ts          # Database schema, single source of truth
  queries/           # Read-only data fetching
  mutations/         # Data modifications
  actions/           # External API calls, side effects
  crons/             # Scheduled jobs, if needed
```

---

## Convex Structure

**Rules:**
- Keep queries small and focused (one purpose per query)
- Mutations should validate input with Zod
- Use actions only for external integrations

---

## Routing

- **Default:** Single-page layout with conditional views
- **Add React Router when:**
  - App needs shareable URLs for different views
  - App needs browser back/forward navigation
  - App has 3+ distinct "pages"
- **Do NOT** add routing "just in case"

---

## Data + State Rules

- Prefer Convex as the source of truth (reactive queries)
- Use local React state for purely UI state (open/close, tabs, input drafts)
- Avoid global state libraries unless explicitly requested

---

## Forms & Validation

- Zod for schema validation (forms + API boundaries)
- React Hook Form for complex forms (only if needed)
- Clear error states and messages

---

## UI/UX Quality Bar (always)

Every feature must include:
- **Loading state** (prefer skeletons for lists/cards)
- **Empty state** (with helpful copy + next action)
- **Error state** (clear message + recovery action)
- **Success feedback** (subtle toast/inline confirmation)

**Feel:**
- UI should feel instant
- Use optimistic updates where safe and easy

---

## Styling

- Tailwind utility-first
- Keep a simple design system:
  - Consistent spacing scale
  - Consistent typography hierarchy
  - Consistent border radius and shadows
- No heavy UI frameworks unless explicitly requested

---

## Accessibility (minimum)

- Semantic HTML
- Visible focus states
- Keyboard-friendly interactions
- Proper labels for inputs
- Respect reduced-motion preferences for animations

---

## Auth

- Do not implement auth unless explicitly requested
- If auth is requested: propose the simplest Convex-compatible approach and explain tradeoffs briefly

---

## Working Process for Each Task

When implementing a feature, follow these steps:

1. **Read this file** (AGENTS.md)
2. **Identify relevant files** and list them
3. **Propose a short plan** (3–8 bullets)
4. **Execute with small diffs** - minimal, incremental changes
5. **Run checks** - propose exact commands
6. **Summarize** - changes + what to test

### Output Format
- Plan (bullets)
- Diffs by file (or brief per-file summary)
- Commands to run
- Risks / edge cases (only if relevant)

### Code Style
- Follow existing lint/prettier settings
- No large refactors unless asked
- Prefer explicit types over clever inference

### When Implementing Features
1. Implement the smallest working version first
2. Add required states (loading/empty/error/success)
3. Add edge cases
4. Keep files small and understandable
5. At the end, list:
   - Assumptions made
   - What to test manually (short checklist)

### Questions
- Only ask questions if truly blocking
- Otherwise make reasonable assumptions and list them

---

## Local Commands (Bun)

```bash
bun install       # Install dependencies
bun run dev       # Start Vite dev server
bunx convex dev   # Start Convex backend (run in separate terminal)
bun run build     # Build for production
bun run preview   # Preview production build locally
bun run lint      # Run linter
bun run lint:fix  # Auto-fix linting issues
bun run typecheck # Run TypeScript type checker
bun run test      # Run tests
```

---

## Slash Commands

Use these commands for common workflows. They automate repetitive tasks and ensure consistency.

### Available Commands

| Command | Description | When to Use |
|---------|-------------|------------|
| `/commit` | Create a local commit with smart message | After making changes, before pushing |
| `/ship` | Verify + Commit + Push + Create PR | When feature is complete and ready to merge |
| `/verify` | Run lint, typecheck, and tests | Before committing to catch errors early |
| `/new-task [name]` | Create new task folder with templates | Before starting work on a new feature |

### Quick Workflow

1. **Start work**
   ```
   /new-task add-dark-mode
   ```
   Creates: `tasks/2025-01-08_add-dark-mode/`

2. **Work on feature** (with Claude)
   - Edit files, make changes
   - Update task.md and JOURNAL.md

3. **Check quality**
   ```
   /verify
   ```
   Runs lint, typecheck, tests. Shows errors if any.

4. **Save locally**
   ```
   /commit
   ```
   Creates local commit (doesn't push yet)

5. **Ship it**
   ```
   /ship
   ```
   Automatically: verify → commit → push → create PR

### Command Details

#### `/commit`
- Analyzes your changes
- Generates a smart commit message (conventional commits format)
- Asks for confirmation
- Creates local commit (doesn't push)

**Use when:** Making progress and want to save locally

#### `/ship`
- Runs `/verify` first (lint, typecheck, test)
- STOPS if any check fails
- If all pass: commits, pushes, creates PR
- Returns PR URL

**Use when:** Feature is complete and tested

#### `/verify`
- Checks code quality (`bun run lint`)
- Checks types (`bun run typecheck`)
- Runs tests (`bun run test`, optional)
- Shows clear status for each check

**Use when:** Before committing or after major changes

#### `/new-task [name]`
- Creates task folder with date prefix
- Fills task.md with template
- Fills JOURNAL.md with template
- Creates artifacts/ folder

**Use when:** Starting work on a new feature

### Commit Message Format

All commands use **conventional commits** format:

- `feat(scope): description` - New feature
- `fix(scope): description` - Bug fix
- `refactor(scope): description` - Code refactoring
- `docs: description` - Documentation
- `test: description` - Test changes

**Examples:**
```
feat(auth): add login form validation
fix(convex): handle realtime subscription errors
refactor(components): simplify button component
docs: update README with setup instructions
```

### Important Rules

- **Always run `/verify` before `/ship`** - Catches errors early
- **Task names use hyphens** - `/new-task add-dark-mode` ✅
- **Tasks in git** - Commit task folders when creating them
- **Reference task ID** - Use in commit messages: `feat: add dark mode (2025-01-08_add-dark-mode)`
- **Update JOURNAL.md** - Keep it updated as you work

### Tips for Best Results

1. Create task with `/new-task` before starting work
2. Update JOURNAL.md with progress regularly
3. Run `/verify` frequently during development
4. Use `/commit` to save progress locally
5. Run `/ship` when feature is complete

The goal: **Fast, verified, well-documented development with zero friction.**

---

## Long-Running Epic Harness (Optional)

For large initiatives spanning multiple days/weeks and many features, use the **epic harness** system. This prevents agents from losing context between sessions, declaring victory too early, or building the wrong things.

### What Is It?

Instead of just working task-by-task, the epic harness provides:

- **A "What's Active" pointer** (`ACTIVE.md`) — which epic is currently in focus?
- **A structured feature list** (JSON) — what does "done" mean, with test steps for each feature?
- **A progress log** (per epic) — what was done last session, what's next, any blockers?

This mimics how experienced engineers hand off work between shifts: they leave clear notes, a checklist, and a known-good state.

### When to Use Epic Mode

- Building a major feature over 3+ days
- Complex work with 10+ sub-features
- When you want to minimize "context loss" between sessions
- When "done" is ambiguous (epic defines it clearly)

For small tasks (hours), use standard `tasks/` workflow.

### How Epic Mode Works

1. **Trigger B (Default):** Update `ACTIVE.md` to point to your epic folder
   ```
   **Current Active Epic:** docs/epics/2026-01_epic-slug/
   ```
   Claude automatically reads this at session start.

2. **Trigger A (Override):** Ignore ACTIVE.md and say "work on epic X" or "don't use epic mode"
   - Always works, lets you override the default

3. **Claude's Ritual (Every Session)**
   - Reads `ACTIVE.md`
   - Reads `docs/epics/<epic>/epic.md` (understanding)
   - Reads `docs/epics/<epic>/feature_list.json` (what needs doing)
   - Reads `docs/epics/<epic>/progress.md` (what happened last time)
   - Chooses ONE feature that's `passes: false` and implements it
   - Verifies (runs `/verify`)
   - Updates `passes: true` for that feature + writes progress note
   - Commits with clear message referencing the feature

### Epic Structure

```
docs/epics/<YYYY-MM_epic-slug>/
  epic.md              # Non-technical: what, why, feel, scope
  feature_list.json    # Structured: features with test steps & status
  progress.md          # Session log: what was done, what's next
```

### Files (Templates)

- `docs/epics/TEMPLATE_epic.md` — copy to create new epic
- `docs/epics/TEMPLATE_feature_list.json` — structure for features
- `docs/epics/TEMPLATE_progress.md` — session log format

### Epic.md (Plain Language)

Write in simple, non-technical language:
- "What are we building?" (1-2 sentences)
- User flows (how should it feel?)
- In scope / out of scope (prevents scope creep)
- Success criteria (how do we know it's done?)
- Related tasks & links

### Feature_list.json (Structured)

Each feature has:
- `id` — unique ID (FEAT-001)
- `description` — what the user does/sees
- `test_steps` — how to verify it works end-to-end
- `passes: true/false` — status (Claude updates this)
- `dependencies` — what must be done first

Claude is instructed: "Only change the `passes` field. Do not rewrite descriptions or test steps." (JSON is harder to "accidentally edit" than Markdown.)

### Progress.md (Session Log)

After each session, Claude writes:
- What was implemented
- What passed
- What failed and why
- Next steps
- Blockers
- Links to related tasks

This is how the next session knows where to start.

### Key Rules

- **One feature per session** — focus, not chaos
- **Always verify** — `/verify` before marking `passes: true`
- **Update progress** — leave clear notes for next session
- **No declaring victory** — feature is only "done" when `passes: true` and tests pass
- **Merge-ready code** — each session leaves a clean, working state

### Slash Commands for Epic Mode

- `/epic-start <epic-name>` — Initialize new epic (creates folder + template files)
- `/epic-next` — Show next failing feature to work on

### Example Flow

```
You: "We're building realtime note collaboration. Update ACTIVE.md to docs/epics/2026-01_realtime-notes/"

Claude (Session 1):
- Reads ACTIVE.md → finds the epic
- Reads epic.md → understands scope/feel
- Reads feature_list.json → sees FEAT-001 is next
- Implements FEAT-001
- Runs /verify
- Updates passes: true
- Writes progress.md: "Implemented FEAT-001, next is FEAT-002"
- Commits with message

[You take a break or work on something else]

Claude (Session 2):
- Reads ACTIVE.md → same epic
- Reads progress.md → "next is FEAT-002"
- Implements FEAT-002
- Verifies
- Updates progress + JSON
- Commits
[...pattern repeats until epic is done]
```

### Tips

- **Start small:** begin with 5-10 features per epic, not 200
- **Test steps matter:** write them clearly so Claude knows exactly what "done" means
- **Update progress after each session:** it's your memory bridge
- **Use it for big things:** small tasks don't need the full harness

---

## Agent Permissions

See `.claude/permissions.json` for which Bash commands are allowed/blocked.
Review `.claude/PERMISSIONS.md` for detailed rationale.

**Key principles:**
- Auto-execute: tests, linting, building, git read-only
- Ask confirmation: git push/pull, package installs, docker ops
- Block completely: destructive ops, secrets, compilation, sudo

---

## Task Management

Each task gets its own folder:
```
tasks/YYYY-MM-DD_task-name/
  task.md           # Task description, goals, acceptance criteria
  JOURNAL.md        # Work log, decisions, blockers, iterations
  artifacts/        # Generated files, sketches, screenshots
```

See task.md format in `tasks/` for examples.

---

## Questions or Need Help?

- **Understanding the workflow:** See CLAUDE.md
- **Setting up from template:** See SETUP_NEW_PROJECT.md
- **Creating new project from this template:** See SETUP_NEW_PROJECT.md

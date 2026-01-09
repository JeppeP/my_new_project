# Architecture Overview

This document describes the technical structure of the application. Keep this updated when making significant structural changes.

## System Design

### Frontend
- **Framework:** React with TypeScript
- **Styling:** Tailwind CSS
- **Build Tool:** Vite
- **Package Manager:** Bun
- **Development Server:** `bun run dev` (http://localhost:5173)

### Backend
- **Platform:** Convex (database + backend + realtime)
- **Queries:** Read-only data fetching with automatic live updates
- **Mutations:** Serverless functions for data modifications
- **Actions:** Integration points for external APIs or side effects
- **Database:** Convex-managed, defined in `convex/schema.ts`

---

## Key Patterns

### Data Flow
[Describe how data flows through your app]

Example: User interaction → Mutation call → Database update → Query re-evaluation → UI update

### State Management
[Describe your state approach]

Example: Convex queries for server state, React state for UI-only state (open/close modals, form inputs)

### Component Structure
[Describe component organization patterns]

Example: Feature folders with co-located components, hooks, and utilities

---

## Critical Files

### Frontend Structure
```
src/
  App.tsx                    # Main app component
  components/                # Shared UI components
  features/                  # Feature-specific code (grouped by feature)
  lib/                       # Shared utilities and API clients
```

### Backend Structure
```
convex/
  schema.ts                  # Database schema (source of truth)
  queries/                   # Read operations
  mutations/                 # Write operations
  actions/                   # External integrations and side effects
```

---

## External Dependencies

### Required Services
- **Convex** - Backend, database, and realtime sync
  - Dashboard: [your-convex-dashboard-url]
  - Dev: Run `bunx convex dev` in separate terminal

### Optional Services
[List any optional services: Auth, analytics, payment processing, etc.]

---

## Development Workflow

### Local Setup
```bash
# Terminal 1: Start Convex backend
bunx convex dev

# Terminal 2: Start frontend dev server
bun run dev
```

### Viewing the App
- Frontend: http://localhost:5173
- Convex Dashboard: Visit your Convex account

### Code Quality
```bash
bun run lint       # Check code quality
bun run typecheck  # Check TypeScript types
bun run test       # Run tests
```

---

## Deployment

[Describe your deployment strategy]

Example:
- Frontend: Deployed to Vercel/Netlify
- Backend: Automatically deployed with Convex
- Environment variables: Managed in Convex settings

---

## Key Decisions

[Optional: Document major architectural decisions and why they were made]

Example:
- Using Convex instead of separate backend/database for simplicity and realtime
- Grouping code by feature rather than by type (features/ instead of components/, pages/)

---

## Recent Changes

[Keep track of structural changes over time]

- **Last Updated:** [Date]
- **Updated By:** [Your name]
- **Change:** [What changed and why]

---

**Tip:** Update this file whenever you:
- Add a new major feature or module
- Change the project structure
- Introduce a new pattern or dependency
- Make significant changes to data flow

# Architecture Decisions

Record important architectural decisions here. This helps prevent different AI models from "re-inventing" solutions.

---

## Decision 1: Why React + Vite + Bun

**Context:**  
We needed a fast, modern frontend setup with minimal boilerplate.

**Decision:**  
Use React + TypeScript + Vite (build tool) + Bun (runtime).

**Rationale:**
- React: familiar, large ecosystem, component-based
- Vite: instant dev reload, fast builds
- Bun: faster than npm, includes runtime

**Consequences:**
- Team learns Bun (new for some)
- Limited Bun ecosystem compared to Node
- Excellent DX and performance

**Status:** Decided

---

## Decision 2: Why Convex

**Context:**  
We need a backend that handles database, realtime updates, and backend logic.

**Decision:**  
Use Convex as the backend platform.

**Rationale:**
- Built-in realtime (Convex reactive queries)
- Database included (no separate DB to manage)
- Easy integration with React (useQuery, useMutation)
- Handles auth/validation/actions natively

**Consequences:**
- All backend logic in TypeScript (consistent)
- Small cold starts (acceptable for our use case)
- Vendor lock-in to Convex (acceptable trade-off)

**Status:** Decided

---

## Decision 3: No Global State Management

**Context:**  
How do we manage state in React?

**Decision:**  
Prefer Convex reactive queries (server state) + local React state (UI state).

**Rationale:**
- Convex handles server state (source of truth)
- React state handles UI state (open/close, tabs, drafts)
- Simpler than Redux/Zustand for our scale

**Consequences:**
- No Redux boilerplate
- Props drilling might increase (acceptable)
- If we hit scale limits, add Redux later

**Status:** Decided

---

## Decision 4: Routing (On-Demand)

**Context:**  
Do we use React Router by default?

**Decision:**  
Start with single-page layout. Add React Router only when needed (3+ pages, shareable URLs).

**Rationale:**
- Simpler to start with conditional rendering
- React Router adds build size
- Easy to add later if needed

**Consequences:**
- No URL sharing in early versions
- Fewer files to manage initially
- Will need refactor if routing needed later

**Status:** Decided

---

## Decision 5: Forms & Validation

**Context:**  
How do we handle forms and validation?

**Decision:**  
Zod for validation + React Hook Form for complex forms (optional).

**Rationale:**
- Zod: type-safe, works with TypeScript
- React Hook Form: only if form is complex/multi-step
- Simple forms: vanilla React state + Zod

**Consequences:**
- Single source of truth for validation (Zod schema)
- Shared validation between client + server

**Status:** Decided

---

## Decision 6: No New Dependencies Without Asking

**Context:**  
How do we manage dependencies?

**Decision:**  
Hard rule: do not add libraries without explicit approval.

**Rationale:**
- Keep bundle size minimal
- Reduce maintenance burden
- Force solutions within existing stack

**Consequences:**
- Sometimes requires creative solutions
- Fewer external dependencies
- Faster builds

**Status:** Decided

---

## Decision 7: Docker for Development

**Context:**
How do we ensure consistent development environments across team members and support working with multiple projects simultaneously?

**Decision:**
Containerize the frontend (Vite dev server) with Docker. Keep Convex CLI running on the host machine (it's a cloud service).

**Rationale:**
- **Project isolation:** Each project runs in its own container, preventing dependency conflicts
- **Clean development machine:** No global npm/node installs; dependencies live in containers
- **Team consistency:** All developers work in identical environments (same Node version, packages, etc.)
- **Multi-project friendly:** Switch between projects without uninstalling/reinstalling dependencies
- **Convex stays on host:** Simpler authentication flow, cleaner developer experience

**Alternatives Considered:**
- **No Docker:** Simpler setup but causes "works on my machine" problems with multiple projects
- **Full containerization:** Docker for Convex too, but adds unnecessary network complexity since Convex is cloud-hosted
- **Containers for deployment only:** Misses benefits of consistency during development

**Consequences:**
- Docker knowledge required (minor learning curve)
- ~5-10% performance overhead vs. native (acceptable trade-off)
- Hot Module Reload (HMR) requires polling-based file watching (~1-2s latency, imperceptible to users)
- Two terminals required: one for Convex, one for Docker frontend
- Docker is optional—developers can still use `bun run dev` natively if preferred

**Configuration:**
- `Dockerfile` - Multi-stage build (dev, build, production)
- `docker-compose.yml` - Development orchestration
- `docker-compose.prod.yml` - Production preview
- `vite.config.ts` - Docker-compatible HMR settings

**Status:** Decided

---

## Template

### Decision N: [Title]

**Context:**  
[What was the situation?]

**Decision:**  
[What did we decide?]

**Rationale:**
- [Why this choice?]
- [What alternatives did we consider?]

**Consequences:**
- [What changed because of this?]
- [What do we gain/lose?]

**Status:** [Decided / Pending / Superseded]

---

## See Also

- **AGENTS.md** - Tech stack (fixed)
- **docs/PLAN.md** - Project plan
- **docs/FEATURE_SPEC.md** - Feature specifications

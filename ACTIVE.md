# Active Epic

This file points Claude/OpenCode to the currently active epic. Update this when you start work on a new major initiative.

**Current Active Epic:** (none)

When you want to work in long-running mode on an epic, update this file to point to it:

```
**Current Active Epic:** docs/epics/YYYY-MM_epic-slug/
```

Example:
```
**Current Active Epic:** docs/epics/2026-01_realtime-notes/
```

When no epic is active, Claude will work with standard `tasks/` workflow.

---

## How Claude Uses This
1. At the start of each session, Claude reads this file
2. If an active epic is set → follows long-running harness mode
3. If no active epic → uses standard task-driven workflow

## Trigger A Override
Even with an active epic set, you can override:
- "Don't use epic mode, just work on this task"
- "Run epic mode for a different epic than ACTIVE.md says"

These overrides always work.

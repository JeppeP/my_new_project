# Create New Task

Create a new task folder with all boilerplate files and templates.

## Arguments

`$ARGUMENTS` = task name (short description, use hyphens for spaces)

Examples:
- `/new-task add-dark-mode`
- `/new-task fix-login-validation`
- `/new-task implement-convex-mutations`

## Workflow

1. Get today's date in format `YYYY-MM-DD`
2. Create folder structure:
   ```
   tasks/{date}_{task-name}/
     task.md
     JOURNAL.md
     artifacts/
       .gitkeep
   ```
3. Fill `task.md` with template
4. Fill `JOURNAL.md` with template
5. Show created structure and confirm

## task.md Template

```markdown
# Feature: [Your Feature Name]

## Goal
[What we're building and why]

## Acceptance Criteria
- [ ] [Criterion 1]
- [ ] [Criterion 2]
- [ ] [Criterion 3]

## Constraints
- [Any limitations or requirements]

## Relevant Files
- [List files that will be modified]
- Example: src/components/Auth.tsx
- Example: convex/mutations/login.ts

## Notes
[Any additional context]
```

## JOURNAL.md Template

```markdown
# Work Journal: [Your Feature Name]

## Overview
- **Task ID**: {YYYY-MM-DD}_{task-name}
- **Status**: Not started
- **Started**: -
- **Completed**: -

## Key Decisions
[Important decisions made during implementation]

## Progress Log

### Session 1
- [ ] Task initiated
- [ ] Read AGENTS.md
- [ ] Identified relevant files
- [ ] Proposed plan

**Notes:**

**Changes made:**

## Blockers & Issues
[Any blockers or problems encountered]

## Testing Notes
[How to manually test this feature]

## Learnings & Reflections
[Optional: anything useful learned]
```

## Rules

- Task name should be short and descriptive
- Use hyphens, not underscores: `add-dark-mode` ✅ not `add_dark_mode`
- Date is automatically generated as today
- Create the task folder before starting work
- Update JOURNAL.md as you make progress
- Commit the task folder to git with initial template

## Example Output

```
✅ Task created!

📁 tasks/2025-01-08_add-dark-mode/
   ├── task.md
   ├── JOURNAL.md
   └── artifacts/
       └── .gitkeep

Next: Edit task.md with your feature description, then start working!
```

## Tips

- Create task BEFORE asking Claude to implement it
- Reference task ID in commit messages: `feat: add dark mode (2025-01-08_add-dark-mode)`
- Keep JOURNAL.md updated with progress
- Use artifacts/ folder for sketches, screenshots, etc

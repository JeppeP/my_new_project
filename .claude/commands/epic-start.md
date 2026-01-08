# Start New Epic

Create a new epic folder with all boilerplate files for long-running mode.

## Arguments

`$ARGUMENTS` = epic name (short description, use hyphens for spaces)

Examples:
- `/epic-start realtime-collaboration`
- `/epic-start user-authentication`
- `/epic-start payment-flow`

## Workflow

1. Get today's date in format `YYYY-MM`
2. Create folder structure:
   ```
   docs/epics/{date}_{epic-slug}/
     epic.md
     feature_list.json
     progress.md
   ```
3. Copy templates into new epic
4. Update ACTIVE.md to point to new epic
5. Show created structure and next steps

## What Gets Created

- **epic.md** - Non-technical specification (goals, scope, feel, success criteria)
- **feature_list.json** - Structured feature list with passes: false/true
- **progress.md** - Progress log template

## After Creation

You need to:
1. Edit `epic.md` with your vision (non-technical language)
2. Edit `feature_list.json` with actual features + test steps
3. ACTIVE.md is automatically updated
4. Next session, Claude will automatically use long-running harness mode

## Example Output

```
✅ Epic created!

📁 docs/epics/2026-01_realtime-notes/
   ├── epic.md
   ├── feature_list.json
   └── progress.md

✅ ACTIVE.md updated to point to this epic

Next: Edit epic.md and feature_list.json with your vision, then start work!
```

## Tips

- Epic name should describe the major feature
- Use hyphens: `/epic-start user-auth` ✅ not `user_auth`
- Keep epics focused: 5-20 features per epic (not 100)
- Remember: epics are for big, multi-day work
- Use `tasks/` for smaller, daily work instead

## Files to Reference

- See `docs/epics/TEMPLATE_epic.md` for how to write epic.md
- See `docs/epics/TEMPLATE_feature_list.json` for feature structure
- See `docs/epics/TEMPLATE_progress.md` for progress log format

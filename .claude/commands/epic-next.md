# Show Next Epic Feature

Show the next feature to work on in the active epic.

## How It Works

1. Read ACTIVE.md to find current epic
2. Read the epic's feature_list.json
3. Find the first feature where `passes: false`
4. Show that feature's details (description, test steps, dependencies)
5. Suggest starting to implement it

## Output Example

```
✅ Active epic: docs/epics/2026-01_realtime-notes/

📋 Next feature to implement:

**FEAT-003: User can edit a note in real-time with another user**

Description:
When two users are editing the same note, they should see each other's changes appear instantly without needing to refresh.

Test Steps:
1. Open a note with User A
2. Open same note with User B (in different browser/incognito)
3. User A types in the note
4. User B sees the changes appear within 1 second
5. User B types back
6. User A sees those changes
7. Both users can type simultaneously without conflicts

Dependencies:
- FEAT-001 (basic note editing)
- FEAT-002 (real-time sync setup)

Suggested Approach:
- Implement WebSocket connection for real-time updates
- Use operational transform or CRDT for conflict resolution
- Add optimistic UI updates

Notes:
- This is the trickiest feature in the epic
- Take time to get the sync logic right
- Write good tests for concurrent edits

Ready to implement? Use /verify to check quality and /ship to commit when done.
```

## When You Finish a Feature

1. Run `/verify` to test your work
2. Mark the feature as `passes: true` in feature_list.json
3. Write a progress note in progress.md
4. Commit with a clear message
5. Run `/epic-next` again to see what's next

## If Current Epic Is Done

If all features pass:
```
✅ All features in this epic are complete!

Next steps:
- Review epic.md "Definition of Done" checklist
- Ensure all features work together (full E2E test)
- Update progress.md with final notes
- Consider marking epic as "Complete"
- If there's another epic, update ACTIVE.md and start fresh
```

## Related Commands

- `/epic-start` - Create a new epic
- `/verify` - Check code quality
- `/ship` - Commit, push, create PR

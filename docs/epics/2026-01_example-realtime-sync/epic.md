# Epic: Real-time Data Synchronization

**Epic ID:** 2026-01_example-realtime-sync  
**Status:** Planning  
**Owner/Champion:** [Your name]  
**Started:** [Date]  
**Target Completion:** [Date]

---

## What Are We Building?

Users should be able to collaborate in real-time on their data (notes, tasks, etc). Right now, changes are saved locally and don't sync until a page refresh. We want changes to appear instantly across all users, making collaboration feel seamless and natural.

---

## User Flows & Feel

### Flow 1: Live Editing
1. User A opens a note
2. User B opens the same note (in another tab/window)
3. User A starts typing
4. User B sees the text appear in real-time, character by character
5. User B types back → User A sees it immediately
6. **Feel:** Instant, responsive, like "magic"

### Flow 2: Handling Conflicts
1. User A and User B type at the exact same time
2. Both see both edits correctly (no data loss, no confusion)
3. The app automatically figures out the right order
4. **Feel:** Effortless, never awkward

---

## What's In Scope (This Epic)

- [ ] Set up real-time connection between client and server (WebSockets)
- [ ] Sync note edits instantly across all users
- [ ] Handle concurrent edits (when users type at same time)
- [ ] Show which user is editing (visual indicator)
- [ ] Persist all changes to database
- [ ] Handle network disconnections gracefully

---

## What's Out of Scope (For Later)

- Offline-first sync (can't edit while disconnected)
- Conflict resolution with complex undo/redo
- Comments or annotations on shared docs
- Video/audio collaboration

---

## Success Criteria (How Do We Know It's Done?)

- [ ] All features in feature_list.json pass their tests
- [ ] Users can edit concurrently without losing data
- [ ] Changes appear within 1 second (latency target)
- [ ] Network disconnections don't cause data loss
- [ ] Two or more users can collaborate simultaneously
- [ ] No console errors or warnings

---

## Known Constraints & Considerations

- Convex has built-in real-time subscriptions (we should use this)
- Server connection might be slow in some regions (design for latency)
- We can't use external libraries for conflict resolution (keep it simple)
- Test with actual concurrent users, not just mock data

---

## Related Tasks & Links

When you create tasks, link them back here:
- `tasks/2026-01-XX_setup-websockets/` - Basic real-time infrastructure
- `tasks/2026-01-XX_implement-sync/` - Core sync logic
- `tasks/2026-01-XX_conflict-resolution/` - Handle concurrent edits

---

## Progress Notes

**[To be filled in as work progresses]**

---

## Definition of Done (For This Epic)

- [ ] All features in feature_list.json pass their E2E tests
- [ ] Two or more users can edit simultaneously
- [ ] No data loss on network interruptions
- [ ] Performance is acceptable (< 1 second latency)
- [ ] Code is reviewed and merged
- [ ] No critical bugs

---

## Next Steps

1. Review feature_list.json to understand all features
2. Start with FEAT-001 (basic WebSocket connection)
3. Run `/epic-next` to see detailed instructions for each feature
4. Follow the test steps carefully for each feature
5. Update progress.md after each session

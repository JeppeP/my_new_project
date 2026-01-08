# Epic Complete Guide (15 Minutes)

This is the full guide. It explains *why* the system exists, *how* it works, and *how* to use it well.

Start here if you want to understand the system deeply. If you just want the quick steps, read `EPIC_QUICKSTART.md` instead.

---

## The Problem This Solves

When Claude/AI agents work on big projects, they tend to:

1. **Forget context between sessions** — "What did I do last time? Where was I?"
2. **Try to do too much at once** — Attempt to build the whole feature in one go, run out of context, leave things half-done
3. **Declare victory too early** — "Oh, I see code was written, the epic must be done!" (But it wasn't tested)
4. **Build the wrong things** — Without a clear spec, they guess and sometimes guess wrong

The **Epic Harness** solves all of these by providing:
- A **clear written vision** (epic.md) so Claude understands what you want
- A **checklist of features** (feature_list.json) so it can't declare victory early
- A **work log** (progress.md) so next session knows exactly where to start
- **Test steps** for each feature so "done" is unambiguous

This is based on how experienced engineers actually hand off work between shifts: clear notes, a checklist, and a known-good state.

---

## Core Concepts

### What's an Epic?

An **epic** is a unit of work that:
- Takes **multiple days or weeks** (not hours)
- Has **many features** (5-20+)
- Needs **multiple sessions** to complete
- Has a clear **definition of done**

Examples:
- ✅ "Real-time collaboration on notes"
- ✅ "User payment system with invoicing"
- ✅ "Mobile-responsive redesign"
- ❌ "Fix button styling" (too small, use tasks/)
- ❌ "Add dark mode" (probably a single task)

### What's NOT an Epic?

Use `tasks/` instead for:
- Work that takes **a few hours**
- Single features with **clear scope**
- Bug fixes
- Refactoring tasks

Epics are for when you need Claude to remember context across multiple sessions.

---

## The Three Files (Deep Dive)

### epic.md — Your Vision

This is **you** talking to Claude. Write it like you'd explain to a smart friend.

**What to include:**

1. **What are we building?** (1-2 sentences)
   - Focus on the user benefit, not the tech
   - Example: "Users should be able to edit notes together in real-time instead of seeing stale data"

2. **User flows** (how should it feel?)
   - Describe the ideal experience
   - "When User A types, User B sees it within 1 second"
   - "When both type at once, no data is lost"

3. **In scope** (what IS part of this epic?)
   - Bullet list of features
   - This prevents scope creep (Claude won't add random stuff)
   - Example: "Real-time sync, show who's editing, handle disconnections"

4. **Out of scope** (what's NOT, for clarity?)
   - Things related but explicitly NOT in this epic
   - Example: "Offline-first editing (future epic), comments (future epic)"

5. **Success criteria** (how do we know it's REALLY done?)
   - Checkboxes of what must be true
   - Example: "All features pass tests, two users can edit simultaneously, changes persist"

6. **Known constraints** (anything Claude should know?)
   - Tech limitations, timeline pressure, team limitations
   - Example: "We can't use external sync libraries, keep it simple"

**Why epic.md is important:**
- Claude reads it at the start of every session
- Prevents misunderstanding of your intent
- Gives context for decisions Claude makes
- Non-technical, so you control the message

### feature_list.json — The Checklist

This is **the contract** between you and Claude. It says: "Here's what done looks like."

**Structure (each feature has):**

```json
{
  "id": "FEAT-001",
  "description": "User can edit a note (what the user does/sees)",
  "user_value": "Why does the user care?",
  "test_steps": [
    "Step 1 (very specific)",
    "Step 2",
    "Step 3 (verify the outcome)"
  ],
  "dependencies": ["FEAT-something-else-if-needed"],
  "passes": false,
  "notes": "Any implementation tips"
}
```

**Important details:**

- **description:** What the *user* does, not how the code works
  - ✅ "User can click 'Share' and see a link"
  - ❌ "Implement URL generation function"

- **test_steps:** So explicit that a human could follow them
  - ✅ "Click button. Verify link appears in 2 seconds."
  - ❌ "Test sharing works"

- **passes:** Claude updates this (false → true when done)
  - Only Claude touches this field
  - You only write the other fields

- **dependencies:** If Feature B depends on Feature A, list it
  - Claude will implement in the right order
  - Prevents "this feature doesn't work yet because we haven't built the foundation"

**Why JSON, not Markdown?**
- JSON is harder for Claude to "accidentally rewrite"
- You can say "only change the `passes` field" and Claude tends to obey
- Markdown gets edited too freely

**Why test steps are critical:**
- They prevent Claude from claiming features are "done" without real verification
- They make "done" objective, not subjective
- You can copy them into a manual test checklist later

### progress.md — The Memory Bridge

This is **how one session tells the next session what happened.**

**What to include:**

1. **Overall status** (features done / total, blockers)
2. **Session log** (what happened each session)
   - What was implemented
   - What passed
   - What failed and why
   - Next steps
   - Blockers
3. **Key decisions** (so you remember why you chose X over Y)
4. **Known issues** (anything Claude should watch out for)
5. **Quick reference** (% complete, next session should do...)

**Why it matters:**
- Claude reads this first thing in the next session
- Prevents "lost context" between sessions
- You can see progress and what's next without reading code
- Helps you spot blockers early

**How Claude updates it:**
- After implementing a feature, Claude writes a short note
- Example: "Implemented FEAT-001, all tests pass. Next: FEAT-002 (depends on FEAT-001 but should be straightforward)"

---

## The Full Workflow (Step-by-Step)

### Session 1: Setup

1. **Create epic folder:**
   ```
   docs/epics/2026-02_your-epic-name/
   ```

2. **Fill in epic.md** (your responsibility)
   - Write what you want to build
   - Describe the feel you want
   - List scope in/out
   - Define success

3. **Fill in feature_list.json** (your responsibility)
   - List every feature
   - Write test steps for each
   - Mark dependencies
   - Leave `passes: false` for all (initially)

4. **Update ACTIVE.md** (your responsibility)
   ```
   **Current Active Epic:** docs/epics/2026-02_your-epic-name/
   ```

5. **Tell Claude to start** (you)
   ```
   "I've created an epic at docs/epics/2026-02_your-epic-name/. 
    Please start implementing features. Use /epic-next to see the first one."
   ```

### Claude's Session 1: First Feature

1. **Reads ACTIVE.md** → finds the epic
2. **Reads epic.md** → understands your vision
3. **Reads feature_list.json** → sees features
4. **Picks first `passes: false`** → FEAT-001
5. **Implements it** (writes code, creates tasks, etc)
6. **Runs `/verify`** → lint, typecheck, test
7. **Follows test_steps** → manually verifies FEAT-001 works
8. **Updates feature_list.json** → marks `passes: true` for FEAT-001
9. **Updates progress.md** → "Implemented FEAT-001, all tests pass. Next: FEAT-002"
10. **Commits** → clear message with feature ID

### Session 2+: Continue

1. **Claude reads ACTIVE.md** → same epic
2. **Claude reads progress.md** → "we did FEAT-001, next is FEAT-002"
3. **Claude picks FEAT-002** → implements, verifies, marks done
4. **Repeat until all pass**

### When Epic is Done

1. **All features have `passes: true`**
2. **Final verification:** Full end-to-end test of everything together
3. **Update progress.md:** "Epic complete, all features pass, ready to ship"
4. **Update ACTIVE.md:** Back to "(none)" or point to next epic
5. **Celebrate!** 🎉

---

## Best Practices

### Writing Good Features

**Test steps should be:**
- ✅ Specific and detailed
- ✅ Repeatable (same steps always produce same result)
- ✅ Verifiable (clear how to know if it passed)
- ✅ Short (5-10 steps max)

**Bad example:**
```
"Test that sharing works"
```

**Good example:**
```
1. Open a note
2. Click the "Share" button
3. Verify a dialog appears with a shareable link
4. Copy the link
5. Open it in a new incognito window
6. Verify the note is readable
7. Verify the user cannot edit
```

### Organizing Features

**Group by category:**
- `core` — must have
- `nice_to_have` — would be great
- `edge_case` — error handling
- `performance` — optimization

**Order matters:**
- Dependencies first (B depends on A → implement A first)
- Core before nice-to-have
- Foundation before polish

### Epic Size

**Good epic size:**
- 5-20 features
- Takes 1-4 weeks
- Fits in one epic folder

**Too small:**
- 1-2 features → use `tasks/` instead

**Too big:**
- 50+ features → break into multiple epics
- Each epic should ship independently

---

## Triggers: When Epic Mode Activates

### Trigger B (Default)

If `ACTIVE.md` points to an epic → Claude automatically uses epic mode:
- Reads epic.md first
- Reads feature_list.json
- Follows the ritual

### Trigger A (Override)

You can override even if ACTIVE.md is set:
- "Don't use epic mode, just work on this task"
- "Work on a different epic than ACTIVE.md says"
- "Skip epic mode for this one session"

Claude respects explicit overrides.

---

## Troubleshooting

### "Claude forgot where it was"

- **Solution:** Check progress.md
- If it's empty or vague, write it better
- Progress.md is the memory bridge — make it clear

### "Claude implemented something weird"

- **Solution:** Check epic.md
- Did you describe it clearly?
- Or check feature_list.json — did you give clear test steps?
- Add clarification and update ACTIVE.md, then tell Claude to re-read

### "A feature takes longer than expected"

- **Solution:** Keep it in `passes: false` and update progress.md
- Note that it's taking longer, why, and when you expect it done
- Next session, Claude continues

### "I want to change a feature mid-epic"

- **Solution:** Update feature_list.json
- Add a note in progress.md about why
- Tell Claude: "Feature FEAT-003 has been updated, here's why..."

### "A feature should be split into two features"

- **Solution:** Delete the old one, add two new ones to feature_list.json
- Mark old as skipped/deleted in progress.md
- Claude will implement the split versions next

---

## Examples

### Example Epic: Real-time Notes

See `docs/epics/2026-01_example-realtime-sync/`:
- `epic.md` — describes building real-time collaboration
- `feature_list.json` — lists 6 features with test steps
- `progress.md` — shows how to log work

Copy these templates when creating a new epic.

### Real Workflow Example

**You (Day 1):**
1. Create epic folder
2. Write epic.md: "Users can collaborate on notes in real-time"
3. Write feature_list.json: List 8 features
4. Update ACTIVE.md
5. Tell Claude: "Please implement the first feature"

**Claude (Session 1):**
- Reads your epic.md
- Sees FEAT-001: "User can open a note"
- Implements it
- Marks passes: true
- Updates progress.md

**You (Day 2):**
- Check progress.md: "FEAT-001 done, next is FEAT-002"
- Tell Claude: "Continue"

**Claude (Session 2):**
- Reads progress.md
- Knows FEAT-002 is next
- Implements FEAT-002
- Marks passes: true
- Updates progress.md: "FEAT-002 done, next is FEAT-003 (depends on FEAT-002)"

**...repeat for FEAT-003 through FEAT-008...**

**You (Week 2):**
- Check progress.md
- All 8 features have `passes: true`
- Run final verification
- Epic done!

---

## Key Takeaways

1. **Epic = big project**. Tasks = daily work.
2. **epic.md = your vision** (non-technical, written by you)
3. **feature_list.json = the contract** (what "done" means)
4. **progress.md = memory bridge** (what happened, what's next)
5. **ACTIVE.md = switch** (which epic is currently active)
6. **Claude's job** = implement one feature per session, update status, repeat
7. **Your job** = write clear specs, read progress, guide as needed

---

## Next Steps

1. **Read EPIC_QUICKSTART.md** for the step-by-step how-to
2. **Look at example epic** in `docs/epics/2026-01_example-realtime-sync/`
3. **Create your first epic** using `/epic-start` or manual template copy
4. **Tell Claude to start**
5. **Watch the magic happen** ✨

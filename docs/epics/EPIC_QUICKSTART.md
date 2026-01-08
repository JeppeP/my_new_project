# Epic Quick Start (5 Minutes)

This is the fast version. If you want to understand *why* this system exists, read `EPIC_COMPLETE_GUIDE.md` instead.

---

## What's an Epic?

A big piece of work that takes **days or weeks** and has many features. Examples:
- "Real-time collaboration"
- "Payment system"
- "User authentication"

For small stuff (a few hours), just use `tasks/` as usual.

---

## The 3 Files You Need (Per Epic)

Every epic folder has these:

1. **epic.md** — What you're building (plain language, like you'd explain to a friend)
2. **feature_list.json** — List of features with test steps (so Claude knows what "done" means)
3. **progress.md** — Work log (what was done, what's next)

---

## How to Start an Epic (Step-by-Step)

### Step 1: Create the Epic Folder

Copy the templates into a new folder:

```
docs/epics/2026-02_your-epic-name/
  ├── epic.md (copy from TEMPLATE_epic.md)
  ├── feature_list.json (copy from TEMPLATE_feature_list.json)
  └── progress.md (copy from TEMPLATE_progress.md)
```

Or use the slash command (when ready): `/epic-start your-epic-name`

### Step 2: Write epic.md

Open `epic.md` and fill it out in plain language:

- **What are we building?** (1-2 sentences)
- **User flows** (how should it feel?)
- **In scope** (what IS part of this epic)
- **Out of scope** (what's NOT, to prevent scope creep)
- **Success criteria** (how do we know it's done?)

Example: See `docs/epics/2026-01_example-realtime-sync/epic.md`

### Step 3: Write feature_list.json

Open `feature_list.json` and list every feature:

For each feature, write:
- `description` — what the user does
- `test_steps` — exact steps to verify it works
- `dependencies` — what must be done first

Example: See `docs/epics/2026-01_example-realtime-sync/feature_list.json`

**Important:** Keep descriptions simple. Test steps should be so clear that Claude (or a human) could follow them exactly.

### Step 4: Update ACTIVE.md

This file tells Claude which epic is currently active.

Open `ACTIVE.md` (in project root) and change:

```
**Current Active Epic:** (none)
```

To:

```
**Current Active Epic:** docs/epics/2026-02_your-epic-name/
```

That's it. Claude will now automatically use "epic mode" for this project.

### Step 5: Tell Claude to Start

Say something like:

> "I've created a new epic: `docs/epics/2026-02_your-epic-name/`. Start with the first failing feature in feature_list.json."

Or run: `/epic-next`

Claude will:
1. Read your epic.md (understand the vision)
2. Read feature_list.json (see what needs doing)
3. Pick the first feature with `passes: false`
4. Implement it
5. Run `/verify` to test
6. Mark it as `passes: true`
7. Update progress.md with notes
8. Commit with a clear message

### Step 6: Each New Session

Claude automatically:
1. Reads ACTIVE.md (finds active epic)
2. Reads progress.md (remembers what happened last time)
3. Reads feature_list.json (picks next failing feature)
4. Continues where it left off

You don't need to explain the context again.

---

## That's It!

The rest is automatic. Claude follows this ritual every session:

```
1. Read epic.md (understand vision)
2. Read progress.md (remember last session)
3. Read feature_list.json (pick next feature)
4. Implement ONE feature
5. /verify (test it)
6. Update passes: true
7. Update progress.md
8. /commit
```

---

## When Epic is Done

When all features have `passes: true`:
- Review epic.md's "Definition of Done" checklist
- Run a final full test
- Update progress.md: "Epic complete"
- Update ACTIVE.md: set back to "(none)"
- Start next epic

---

## Common Questions

**Q: Can I have multiple epics active?**  
A: Only one ACTIVE.md at a time. But you can work on different epics in different "modes" by overriding (see EPIC_COMPLETE_GUIDE.md).

**Q: What if a feature takes more than one session?**  
A: That's fine. Just leave it as `passes: false` and update progress.md. Next session, Claude continues on the same feature.

**Q: Can I change a feature's test steps mid-epic?**  
A: Yes, but do it rarely. Update the JSON and add a note in progress.md about why.

**Q: What if I realize a feature shouldn't be in this epic?**  
A: Delete it from feature_list.json and note it in progress.md. Keep epic focused.

---

## Next: Full Guide

For deeper understanding of *why* this system exists and troubleshooting, read `EPIC_COMPLETE_GUIDE.md`.

For the example epic, see `docs/epics/2026-01_example-realtime-sync/`.

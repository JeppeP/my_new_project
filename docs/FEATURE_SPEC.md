# Feature Specifications

Template for detailed feature specs. Use this when planning a complex feature.

---

## Feature Template

### Feature: [Feature Name]

**Status:** [Planning / In Progress / Done]

---

#### Outcome & User Flow

**Goal:**  
[What should happen? Why?]

**User Flow:**
1. User does X
2. System responds with Y
3. User sees Z

[Or draw/paste a quick storyboard]

---

#### UI Structure

**Layout:**
```
[Header]
  [Navigation]
  [Search/Filter]
[Main Content]
  [Item List / Form / Details]
  [Actions]
[Footer / Sidebar]
```

**Components involved:**
- [Component 1] - for [purpose]
- [Component 2] - for [purpose]

---

#### States

Every feature must handle these states:

- **Loading**
  - Show skeleton or spinner
  - Why: users need feedback that something is happening

- **Empty**
  - Show helpful message (e.g., "No tasks yet")
  - Show next action (e.g., "Create your first task")

- **Error**
  - Show clear error message (what went wrong)
  - Show recovery action (how to fix)

- **Success**
  - Show subtle confirmation (toast, inline message)
  - Next step: what should user do?

---

#### Data Model (Convex)

**Entity: [Name]**

```typescript
// In convex/schema.ts
export const table = defineSchema({
  _id: v.id("table"),
  field1: v.string(),
  field2: v.number(),
  field3: v.optional(v.array(v.string())),
  createdAt: v.number(),
  updatedAt: v.number(),
});
```

**Queries needed:**
- `getTable(id)` - fetch single item
- `listTable()` - fetch all items

**Mutations needed:**
- `createTable(data)` - create new
- `updateTable(id, data)` - update existing
- `deleteTable(id)` - delete

---

#### Realtime & Optimistic Updates

**Realtime behavior:**
- When user creates item, all clients see it immediately (Convex reactive query)
- When user updates item, changes broadcast to all connected clients

**Optimistic updates:**
- On submit, update UI immediately (don't wait for server)
- If server rejects, roll back UI changes
- Example: checking a checkbox should feel instant

**Implementation:**
```typescript
// React component
const createTask = useMutation(api.mutations.createTask);

const handleCreate = async (title: string) => {
  // Optimistic: show new task immediately
  setTasks([...tasks, { id: 'temp', title, done: false }]);
  
  // Then actually create
  const result = await createTask({ title });
  
  // If error, rollback
  if (!result.ok) {
    setTasks(tasks.filter(t => t.id !== 'temp'));
  }
};
```

---

#### Microcopy

Small text that guides users:

| Element | Text |
|---------|------|
| Empty state | "No tasks yet. Create one to get started." |
| Button | "Create Task" |
| Error (network) | "Connection lost. Check your network." |
| Error (validation) | "Title is required." |
| Success | "Task created!" |
| Loading | "Creating task..." |

---

#### Manual Test Checklist

Test this feature by hand:

- [ ] Create new item
- [ ] See loading state
- [ ] See success message
- [ ] List refreshes with new item
- [ ] Update item
- [ ] Delete item
- [ ] Try invalid input → see error
- [ ] Refresh page → data persists
- [ ] Open in two tabs → changes sync
- [ ] Test on mobile/tablet
- [ ] Test keyboard navigation
- [ ] Test on slow network

---

## Quick Reference

When implementing, remember:

1. **Start with smallest working version**
2. **Add loading/empty/error/success states**
3. **Make it feel instant (optimistic updates)**
4. **Keep Convex queries small and focused**
5. **List assumptions and test checklist**

---

## See Also

- **AGENTS.md** - Quality bar and rules
- **docs/PLAN.md** - Overall project plan
- **docs/DECISIONS.md** - Why we made certain choices

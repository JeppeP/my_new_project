# 🚀 START PROJECT GUIDE

**Denna guide samlar allt du behöver för att starta ett nytt projekt och ge Claude all information för att komma igång.**

---

## STEG 1: Kopiera Template (5 minuter)

```bash
# Kopiera template-mappen till ditt nya projekt
cp -r my_new_project my_actual_project_name
cd my_actual_project_name

# Initialisera git
git init
git add .
git commit -m "Initial: project scaffold from template"
```

**Vad som skapades:**
- ✅ `AGENTS.md` - Regler & tech stack
- ✅ `README.md` - Projektöversikt
- ✅ `.claude/` - Permissions, prompts, commands
- ✅ `docs/epics/` - Epic templates
- ✅ `tasks/` - Task structure
- ✅ All other necessary folders

---

## STEG 2: Uppdatera AGENTS.md (10 minuter)

Öppna `AGENTS.md` och uppdatera dessa sekvioner för DITT projekt:

### Section: "Project Goal"
**Innan:**
```
Build a modern web app with a fast, responsive feel.
```

**Efter (DITT PROJEKT):**
```
Build a real-time chat application where users can create channels,
send messages instantly, and see who's online.
```

### Section: "Fixed Tech Stack"
**Uppdatera BARA om du vill ändra från React + Vite + Bun + Convex**

Default stack (redan rätt för de flesta projekt):
```
### Frontend
- React
- TypeScript
- Tailwind CSS
- Vite

### Backend
- Convex (database + realtime + backend logic)
```

Exempel om du vill använda en annan stack:
```
### Frontend
- Next.js (App Router)
- TypeScript
- Tailwind CSS

### Backend
- Supabase (PostgreSQL + realtime)
```

**Börja alltid med default-stacken om du är osäker!**

### Section: "Hard Rules"
**Lägg till regler som är viktiga för DITT projekt:**

Exempel:
```
## Hard Rules

1. No external auth libraries - use Convex auth only
2. Mobile-first design (all UI must work on iPhone SE)
3. Max 3-second load time for any page
4. All mutations must be optimistic with rollback
5. No storing sensitive data on client
```

### Section: "Local Commands"
**Lägg till custom slash commands om du behöver:**

Exempel:
```
/seed-db          - Fill dev database with test data
/export-chat      - Export all messages to JSON
/performance-test - Run speed benchmarks
```

---

## STEG 3: Uppdatera README.md (5 minuter)

```bash
# Ändra titel och beskrivning
Project Template → Your Actual Project Name
```

**Uppdatera dessa sekvioner:**

```markdown
# Real-Time Chat App

A modern chat application built with React, Vite, Bun, and Convex.

## Quick Start

```bash
bun install
bunx convex dev     # Terminal 1
bun run dev         # Terminal 2
```

## Key Features

- 💬 Real-time messaging
- 👥 User presence (who's online)
- 🔔 Channel notifications
- 📱 Mobile responsive
```

---

## STEG 4: Skapa Din Första Epic (eller Task) (15 minuter)

### **Option A: Långsiktigt projekt (2+ veckor)?**
Använd EPIC-läge.

**Säg till Claude:**
```
I need to build a real-time chat app with these features:
1. User authentication (sign up / login)
2. Create and join channels
3. Send/receive messages in real-time
4. See who's online
5. Delete messages (own only)
6. Search message history

Can you create an epic with a feature list and implementation plan?
```

Claude kommer att:
- Skapa `docs/epics/YYYY-MM-DD_your-epic-name/`
- Skapa `epic.md` (vision), `feature_list.json` (checklist), `progress.md` (log)
- Uppdatera `ACTIVE.md` så epics auto-aktiveras
- Guida dig genom alla features

Se **EPIC_QUICKSTART.md** för snabb intro eller **EPIC_COMPLETE_GUIDE.md** för detaljerad guide.

### **Option B: Kort projekt (1-2 dagar)?**
Använd TASK-läge (snabbare).

**Säg till Claude:**
```
Create a task for: "User authentication with email/password"

Acceptance criteria:
- User can sign up with email
- User can login with credentials
- Session persists after refresh
- Password reset works
```

Claude kommer att:
- Skapa `tasks/YYYY-MM-DD_task-name/`
- Skapa `task.md` och `JOURNAL.md`
- Implementera & uppdatera progress

---

## STEG 5: Ge Claude All Information (kopiera-och-klistra)

**Kopiera ALLT här under och skicka till Claude:**

```
---START HERE---

I'm starting a new project. Here's what I'm building:

### PROJECT INFO
- **Name:** [Your Project Name]
- **Goal:** [What should it do?]
- **Timeline:** [2 weeks / 3 months / ongoing?]
- **Users:** [Who will use it? What's their level?]

### TECH STACK
[Leave as default OR paste your custom AGENTS.md tech stack section]

### KEY FEATURES (prioritized)
1. [Feature 1]
2. [Feature 2]
3. [Feature 3]
... (list all core features)

### HARD RULES (from AGENTS.md)
[Paste relevant rules from your updated AGENTS.md]

### NEXT STEP
I want you to: [Choose ONE]
- Create an epic with feature list and implementation plan (for 2+ week projects)
- Create a task for the first feature (for 1-2 day projects)
- Start implementing immediately (I've already planned everything)

### CONTEXT FILES
All my project rules are in AGENTS.md. Read that file first.
My goals and hard rules are documented there.

---END HERE---
```

**Vad Claude gör med denna info:**
- ✅ Läser AGENTS.md
- ✅ Förstår tech stack
- ✅ Vet vilka features som ska byggas
- ✅ Vet prioritetsordning
- ✅ Vet dina hard rules
- ✅ Skapar epic/task med rätt struktur
- ✅ Börjar implementera eller guida nästa steg

---

## STEG 6: Börja Arbeta (iterativt)

### **Om du använder EPIC-läge:**

**Varje dag/session:**
```
I'm continuing the [epic-name] epic in long-running mode.
What's the next feature to tackle?
```

Claude kommer att:
- Läsa `progress.md` från senaste sessionen
- Kolla `feature_list.json` för nästa feature
- Implementera & uppdatera progress
- Markera feature som done/failed

### **Om du använder TASK-läge:**

**Varje feature:**
```
Here's the next task: [paste task.md content]
Please implement this.
```

Claude kommer att:
- Skapa task-mappen
- Implementera
- Uppdatera JOURNAL.md
- Säga när det är klart

---

## CHECKLISTA FÖRE DU STARTAR

- [ ] Kör `cp -r my_new_project my_actual_project_name`
- [ ] Uppdaterat `AGENTS.md` med ditt projekt
  - [ ] Project Goal
  - [ ] Tech Stack (eller använd default)
  - [ ] Hard Rules (om du har några)
- [ ] Uppdaterat `README.md` med ditt projektnamn
- [ ] Läst **EPIC_QUICKSTART.md** (om 2+ veckor) eller **README.md** (om 1-2 dagar)
- [ ] Kopierat "Give Claude All Information" texten ovan
- [ ] Kört `git init && git add . && git commit -m "Initial: project scaffold"`
- [ ] Startat din första session med Claude

---

## VANLIGA FRÅGOR

### Q: Ska jag redigera AGENTS.md innan eller efter jag talar med Claude?
**A:** INNAN. Claude läser det, så det måste innehålla din info första gången.

### Q: Kan jag ändra features senare?
**A:** Ja! Du kan uppdatera `feature_list.json` eller `task.md` när som helst. Claude läser senaste versionen.

### Q: Vad gör jag om jag behöver en custom slash command?
**A:** Lägg till den i AGENTS.md under "Local Commands" och Claude kommer att skapa den nästa session.

### Q: Hur många features ska ett epic ha?
**A:** 3-10 features fungerar bra. Om det är >10, dela upp i två epics.

### Q: Kan jag använda TASK-läge för stora projekt?
**A:** Ja, men EPIC-läge är bättre för 2+ veckor. TASK-läge är snabbare för små features.

### Q: Hur länge sparas progress?
**A:** `progress.md` sparar allt. Du kan gå tillbaka månader senare och Claude läser din historia.

---

## NÄSTA STEG

1. ✅ Kopiera template
2. ✅ Uppdatera AGENTS.md
3. ✅ Skapa ditt första epic/task
4. ✅ Ge Claude all info från "STEG 5"
5. ✅ Säg: "Use long-running mode for this epic" (eller task-mode om kort projekt)
6. ✅ Claude börjar implementera

---

**Du är nu redo att starta! 🚀**

Se även:
- **EPIC_QUICKSTART.md** - 5-min intro om du använder epics
- **EPIC_COMPLETE_GUIDE.md** - 15-min detaljerad guide
- **AGENTS.md** - Source of truth för ditt projekt
- **CLAUDE.md** - Quick reference för Claude

---
description: Capture session learnings in documentation (Meta-Loop Step 4)
---

# Meta-Loop: Learning Retention

Capture session learnings in documentation before clearing context.

**Modes:** Plan Mode → Agent Mode

## Prerequisites

This skill implements **Step 4** of the Meta-Loop process defined in `skills/meta-loop-methodology/SKILL.md`.

Use this after a successful implementation pass (`/ml-impl` review passed).

---

## Phase 1: Plan (Plan Mode)

**Enter plan mode** and create a plan for documentation updates.

### 1.1 Review Session Changes

Analyze what happened in this session:

1. **Check git status and diff:**
   - What files were created?
   - What files were modified?
   - What's the scope of changes?

2. **Read the feature's `notes.md`** (if this session followed the Meta-Loop):
   - Located in the spec directory (e.g., `specs/views/{name}/notes.md`)
   - Contains decisions from wireframe, spec, and implementation phases
   - Review for learnings that should be promoted to CLAUDE.md or doc/

3. **Identify learnings:**
   - What patterns emerged?
   - What decisions were made?
   - What documentation gaps were discovered?
   - What issues required workarounds?

4. **Check current documentation state:**
   - Read TODO.md for task tracking
   - Read CLAUDE.md for current context
   - Note any outdated information

### 1.2 Create Documentation Plan

Plan updates to these files:

**TODO.md Updates:**
- Tasks completed this session
- New tasks discovered
- Phase/milestone status changes

**CLAUDE.md Updates (keep concise!):**
- New patterns that should be quick-reference
- Updated file references if structure changed
- Removed outdated content
- ⚠️ Keep under 40k characters total

**New doc/ Files (if detailed knowledge needed):**
- Complex patterns that need explanation
- Architectural decisions with rationale
- Anti-patterns with examples
- Guides that would bloat CLAUDE.md

### 1.3 Present Plan to Developer

```
## Learning Retention Plan

### Session Summary
[1-2 sentence summary of what was accomplished]

### TODO.md Updates
**Move to Completed:**
- [ ] [Task that was completed]

**Add to Next Up:**
- [ ] [New task discovered]

**Milestone Update:**
- [Any phase/milestone status change]

### CLAUDE.md Updates
**Add:**
- [New section or entry]

**Update:**
- [Section to modify]

**Remove:**
- [Outdated content to delete]

### New Documentation Files
| File | Purpose |
|------|---------|
| `doc/[name].md` | [What it documents] |

### Git Commit
**Suggested message:**
> [Descriptive commit message]

Ready to proceed?
```

### 1.4 Developer Approval

**If plan rejected:** Revise based on feedback.

**If plan approved:** Proceed to Phase 2.

---

## Phase 2: Execute (Agent Mode)

**Exit plan mode** and execute the documentation updates.

### 2.1 Update TODO.md

1. Move completed tasks from "Next Up" to "Completed" section
2. Add new tasks discovered during the session
3. Update phase/milestone status if applicable
4. Add today's date to completed items

### 2.2 Update CLAUDE.md

Follow these guidelines:

**DO:**
- Keep entries concise (1-3 lines per item)
- Use tables for structured information
- Reference `doc/` files for detailed knowledge
- Remove outdated content when adding new
- Maintain the existing structure

**DON'T:**
- Add verbose explanations (put those in `doc/`)
- Include full code examples (put those in `doc/`)
- Duplicate information already in specs
- Let the file grow beyond ~40k characters

### 2.3 Finalize notes.md

If this session followed the Meta-Loop, finalize the feature's `notes.md`:

```markdown
---

## Learning Retention ({date})

### Promoted to Documentation
- [Pattern/learning added to CLAUDE.md]
- [New doc file created: doc/{name}.md]

### Feature Status
✅ Complete - implementation passes review

### Future Considerations
- [Any notes for future iterations]
```

### 2.4 Create New doc/ Files (if planned)

For detailed knowledge that doesn't belong in CLAUDE.md:
- Create in `doc/` directory
- Use descriptive filenames
- Include examples and rationale
- Reference from CLAUDE.md with a brief pointer

### 2.5 Commit Changes

Stage and commit with a descriptive message:

```bash
git add -A
git commit -m "docs: [summary of documentation updates]

- [Specific update 1]
- [Specific update 2]

Co-Authored-By: Claude Opus 4.5 <noreply@anthropic.com>"
```

### 2.6 Push to Remote

```bash
git push
```

### 2.7 Final Reminders

```
## ✅ Learning Retention Complete

### Documentation Updated
- TODO.md: [summary of changes]
- CLAUDE.md: [summary of changes]
- New files: [list if any]

### Git Status
- Committed: [commit hash]
- Pushed: ✅

---

## Important Reminders

### Before Your Next Feature:
1. **Clear your context** - Start fresh for the next feature
2. **Return to wireframe** - Begin with `/ml-wireframe` for the next task

### Context Clearing Options:
- Exit and restart Claude Code
- Use `/clear` command
- Start a new conversation

### The Meta-Loop Continues:
```
/ml-wireframe [new-wireframe-path]
     ↓
/ml-spec [wireframe-path]
     ↓
/ml-impl [spec-path]
     ↓
/ml-retain  ← You are here
     ↓
[Clear context, repeat]
```
```

---

## Key Constraints

- **Keep CLAUDE.md concise** - It's re-read every session; bloat hurts performance
- **Detailed knowledge goes in doc/** - Reference from CLAUDE.md, don't inline
- **Always commit** - Documentation is only valuable if it persists
- **Clear context after** - Don't carry stale context to the next feature

## What NOT to Capture

Don't add to documentation:
- **One-off fixes** that don't represent patterns
- **Temporary workarounds** that will be removed
- **Obvious conventions** that any Swift developer knows
- **Spec details** that already exist in the spec files
- **Implementation details** that are clear from the code

## Context Window Management

From the meta-loop document:

> ⚠️ **Context Window Warning:** Make sure the AI doesn't put too much specific project knowledge in its agent file because these files eat up context window and get rewritten.

CLAUDE.md should contain:
- Build commands
- Project structure overview
- Key patterns (referenced, not explained)
- File organization
- Important conventions

CLAUDE.md should NOT contain:
- Full component documentation
- Detailed architectural explanations
- Complete code examples
- Historical decisions (put in ADRs)

# Claude Code Memory Architecture & Meta-Loop Workflow Insights

> Conversation summary — Claude.ai, February 10, 2026

## Context

This document captures key discoveries, insights, and action items from a conversation exploring Claude Code's memory and session management systems, and how they relate to an existing externalization-first development workflow built around the Meta-Loop methodology.

---

## Claude Code's Four Memory Layers

Claude Code has four distinct memory systems, built incrementally and never clearly explained in one place by Anthropic. They operate at different levels of persistence and priority.

### 1. User Memory (`~/.claude/CLAUDE.md`)

- Created and maintained manually by the user
- Applies globally across all projects
- Contains personal preferences, coding style, tool choices
- Highest persistence — always loaded at session start

### 2. Project Memory (`CLAUDE.md` in repo root + `.claude/rules/*.md`)

- Created and maintained manually (or via custom commands like `/done`)
- Scoped to a single project
- Contains architecture decisions, conventions, custom commands
- `CLAUDE.local.md` for personal project preferences excluded from git
- Loaded with high priority at session start

### 3. Session Memory (`~/.claude/projects/<hash>/<session>/session-memory/summary.md`)

- Created automatically by Claude in the background
- Per-session snapshots: decisions made, outcomes, work log
- First extraction after ~10,000 tokens; updates every ~5,000 tokens or 3 tool calls
- Recalled as low-priority background context when starting new sessions
- Terminal displays "Recalled X memories" (session start) and "Wrote X memories" (during work)
- Press `ctrl+o` to inspect what was recalled or written
- The `/remember` command promotes recurring patterns from Session Memory into Project Memory (`CLAUDE.local.md`)

### 4. Conversation History (`~/.claude/projects/<hash>/*.jsonl`)

- Full transcript of every turn: prompts, responses, tool use, file edits
- Saved automatically on `/exit` or terminal close
- What `/resume`, `/rewind`, and `/fork` operate on
- Not "memory" in the intelligent sense — raw logs that Claude re-reads
- No explicit save step required; every session is persisted by default

### Persistence Hierarchy

```
User Memory      → always loaded, all projects (most persistent)
Project Memory   → always loaded, one project
Session Memory   → selectively recalled, background priority
Conversation     → only loaded on /resume, full fidelity (most ephemeral)
```

---

## Session Management Commands

### `/resume`

Picks up a previous session with full conversation history intact.

- From terminal: `claude --resume` (interactive picker) or `claude --continue` (most recent)
- From inside a session: `/resume`
- Sessions are scoped to the project directory
- Use `/rename` early to make sessions findable later

### `/rewind`

Rolls back to a previous point in the current conversation. Conversational equivalent of `git revert` — useful when Claude goes down a wrong path.

### `/fork`

Creates a branch of the current conversation. The original session stays intact; the new session shares history up to the fork point. Enables exploring two implementation approaches from the same starting context.

### Practical Combo Pattern

1. Get Claude Code to a good understanding of the codebase and task
2. `/fork` before a risky refactor
3. If the fork goes sideways, `/resume` back to the original
4. If the fork succeeds, continue there

---

## What `/exit` Does and Doesn't Save

**Saves:** Full conversation transcript as JSONL (prompts, responses, tool use, file edits)

**Does not save:**
- Working memory or "understanding" — on resume, Claude re-reads the transcript to reconstruct context; subtle drift is possible on long sessions
- File state — stores the conversation, not a codebase snapshot; Claude picks up current file state on resume
- Environment state — running processes, terminal state, environment variables are all gone

**Best practice:** Drop a brief summary comment at the end of a session before `/exit` to give resumed-Claude a clear anchor point.

---

## The Externalization-First Workflow

### Core Principle

Rather than chasing continuity (wanting Claude to remember everything), pursue externalization — forcing knowledge out of ephemeral conversation context into durable, human-readable artifacts. This approach scales; memory dependence doesn't.

### The `/done` Close-Out Protocol

A custom command that enforces discipline at session end:

1. **Update TODO.md** — Captures what's done and what's next (persistent save file)
2. **Update CLAUDE.md** — Maintains Claude's onboarding document for any new instance
3. **Commit changes** — Forces atomic, meaningful save points
4. **Push to remote** — Makes everything available across machines

This operates at the project layer, complementing (not duplicating) Claude's session-layer tools.

### Why This Is Better Than Memory Dependence

- **TODO.md** survives across machines, is human-readable, git-trackable, and works regardless of `/resume` or fresh start
- **CLAUDE.md** is legible to the user without launching Claude Code
- **Specs, how-tos, readmes** work without Claude entirely
- **Context clearing as discipline** forces externalization rather than relying on memory as a crutch

### The Conversation/Action Split

- **Claude.ai** for conversation: thinking, reasoning, learning, exploring ideas
- **Claude Code** for action: writing, coding, executing against well-defined specs

This separation prevents the common failure mode of philosophical discussions burning tokens on tool calls inside Claude Code, or production code being written inline in chat.

---

## How Session Memory Complements the Existing Workflow

The manual `/done` workflow maintains layers 1 (User Memory) and 2 (Project Memory). The TODO.md pattern effectively serves as a human-readable alternative to layer 3 (Session Memory).

Session Memory adds value as an automatic safety net that catches things you might not think to document. The `/remember` command is the interesting bridge — it lets Claude propose CLAUDE.md updates based on patterns it has observed, inverting the authorship from human-curated to AI-suggested (with human approval).

**Recommendation:** Keep the manual `/done` workflow as the authoritative path. Use Session Memory as a complementary safety net, and periodically run `/remember` to see if Claude surfaces patterns worth promoting to permanent Project Memory.

---

## Meta-Loop Methodology: Assessment and Next Steps

### What's Strong

- **"Delete and regenerate, don't patch"** — The key insight that most AI coding agent users haven't internalized. When code is cheap to regenerate, documentation becomes the persistent value.
- **Three nested loops with review gates** — Wireframe → Spec → Implementation with explicit mode designations (Human Action, Plan, Ask, Agent) prevents the common failure mode of jumping straight to "just build it."
- **Wireframe verification step** — Confirming Claude understands the intent before generating saves more rework than any other single practice.
- **`/ml-retain` closing the learning loop** — Knowledge doesn't leak out the bottom of the process.

### What Needs Work

**Generalization:** The iOS/SwiftUI specificity is both a strength and a limitation. The methodology itself is platform-agnostic. The core should be extracted into a platform-neutral repo (`meta-loop`) with `meta-loop-ios`, `meta-loop-react`, etc. as thin specializations.

**Universal elements (the real methodology):**
- Wireframe → spec → implement → retain loop
- Delete and regenerate, don't patch
- Documentation is the persistent value, code is disposable
- Explicit review gates between phases
- Context clearing as discipline
- Externalization over memory dependence
- The four modes (Human Action, Plan, Ask, Agent)

**Platform-specific elements (belong in specialization plugins):**
- SwiftUI view structure conventions
- Xcode project layout
- iOS testing patterns
- Apple-specific wireframe conventions

**README storytelling:** The README is structured as a reference manual. It's missing a compelling opening narrative showing the before/after workflow difference and the concrete outcome improvement.

**Adoption friction:** The process needs to be the path of least resistance, not an extra step people skip. Consider encoding close-out protocols into triggers (git hooks, wrapper scripts) rather than requiring manual invocation.

**Feedback sources:** Testing with mid-level engineers who are skeptical about AI coding agents will surface gaps that validation from like-minded senior engineers won't.

---

## Additional Considerations

### Commit Message Quality

When Claude auto-commits (as in the `/done` workflow), commit messages can range from excellent to generic. Consider adding explicit instructions about commit message format — conventional commits, ticket references, or whatever the team standard is. These messages become team-visible artifacts when pushed to remote.

### Tests Before Commit

Consider adding a test-running gate to the `/done` command before committing and pushing. A quick sanity check keeps the remote branch clean.

### Repo-Stored Sessions

The idea of storing Claude Code sessions in the repo (instead of `~/.claude/`) for team sharing introduces design challenges beyond the simple path change: secret scrubbing, git bloat from large JSONL files, merge conflicts, and changed trust models. The question is whether this should be a first-class Anthropic feature or a personal hack — very different scopes.

---

## Key Takeaway

The most effective Claude Code workflow combines deliberate externalization (manually maintained docs, specs, and CLAUDE.md) with automatic safety nets (Session Memory) and explicit session management (`/resume`, `/fork`, `/rewind`). Memory systems are conveniences; externalized documentation is the durable asset. The Meta-Loop methodology encodes this insight into a repeatable, shareable process — the next step is generalizing it beyond iOS and testing it with users who didn't design it.

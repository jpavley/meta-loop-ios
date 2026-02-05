# Meta-Loop User Guide

> A practical guide for developers new to AI coding agents

## What You'll Learn

This guide teaches you how to use the meta-loop commands (`/ml-wireframe`, `/ml-spec`, `/ml-impl`, `/ml-retain`) to build features with AI assistance. After reading, you'll understand the "delete and regenerate" workflow and be able to deliver production-ready features in single-shot attempts.

**For the theory behind this process**, see [ml-development-process.md](./ml-development-process.md).

Note: *We use Claude Code as the AI Coding Agent in this document but this process will work for any frontier AI coding assistant.*

---

## Before You Begin

### The Mindset Shift

- Traditional development: *Code is expensive, documentation is nice-to-have.*
- AI-assisted development: **Code is  and easy, documentation is the valuable asset.**

Your learning lives in the documentation (wireframes, specs, supporting docs), not in accumulated patches. When something goes wrong, you update the source docs and regenerate—you don't fix the output.

### What the AI Needs From You

| You Provide                    | AI Uses It To                   |
| ------------------------------ | ------------------------------- |
| Clear wireframes               | Understand your intent visually |
| Curated documentation          | Follow your project's patterns  |
| Oversight and verification     | Catch deviations                |
| Domain knowledge               | Answer clarifying questions     |

### What You DON'T Need To Do

- Write detailed implementation instructions
- Fix AI-generated code by hand
- Explain concepts the AI should already know

---

## The Four Commands

| Command         | Input                | Output                  | When to Use                   |
| --------------- | -------------------- | ----------------------- | ----------------------------- |
| `/ml-wireframe` | Wireframe image path | PASS/FAIL with feedback | After drawing a wireframe     |
| `/ml-spec`      | Wireframe path       | Specification document  | After wireframe passes review |
| `/ml-impl`      | Spec path            | Working code            | After spec passes review      |
| `/ml-retain`    | **                   | Updated docs + commit   | After code passes review      |

** The input to `/ml-retain` is the AI's current context

### The Flow

```ascii
┌─────────────────┐     ┌─────────────────┐
│   Draw          │     │  Verify AI      │
│   Wireframe     │ ──▶ │  Understands    │
│   (You)         │     │  /ml-wireframe  │
└─────────────────┘     └─────────────────┘
                                 │
                                 ▼
                        ┌─────────────────┐     ┌─────────────────┐
                        │   Create        │     │   Implement     │
                        │   Spec          │ ──▶ │   Code          │
                        │  /ml-spec       │     │  /ml-impl       │
                        └─────────────────┘     └─────────────────┘  
                                                          │ 
                                                          ▼
                                                ┌─────────────────┐     ┌─────────────────┐
                                                │  Capture        │     │     Clear       |
                                                │  Learnings      │ ──▶ │     Context     |
                                                │  /ml-retain     │     │     & Repeat    |
                                                └─────────────────┘     └─────────────────┘
```

---

## Step-by-Step: Your First Feature

### Step 1: Draw Your Wireframe

Create a simple sketch of what you want to build. This doesn't need to be pixel-perfect—think whiteboard quality.

**Good wireframes:**

- Show layout structure (what goes where)
- Indicate interactive elements (buttons, inputs)
- Use simple boxes and labels
- Save as PNG in `specs/views/<feature>/wireframe.png`

**Avoid:**

- Exact dimensions or spacing
- Color specifications
- Implementation details (APIs, data structures)

Note: *In this example we're using a wireframe for a UX design but this method works just as easily work flow charts and system diagrams.*

### Step 2: Verify Understanding (`/ml-wireframe`)

```bash
/ml-wireframe specs/views/my-feature/wireframe.png
```

The AI will describe what it sees and ask clarifying questions.

**If PASS:** You'll see a summary of understanding. Proceed to Step 3.

**If FAIL:** You'll see specific issues. Ask that AI *why* it didn't understand the wireframe. Update your wireframe to clarify the design-—don't fix issue in chat; Re-run the command to discover if the AI can read the improved wireframe and understand your intent.

### Step 3: Create the Spec (`/ml-spec`)

First, clear your context. Then:

```bash
/ml-spec specs/views/my-feature/wireframe.png
```

This runs three phases:

1. **Plan** — AI proposes spec structure; you approve or ask for changes
2. **Write** — AI writes the specification
3. **Review** — AI checks its own work against the wireframe

**If PASS:** Proceed to Step 4.

**If FAIL:** Delete the generated spec, ask the AI clarifying questions, ask the AI to create supporting documentation, improve the wireframe based on the feedback, and re-run `/ml-spec`.

### Step 4: Implement (`/ml-impl`)

Clear your context again. Then:

```bash
/ml-impl specs/views/my-feature/spec.md
```

Same three-phase pattern: Plan → Write → Review.

**If PASS:** Proceed to Step 5.

**If FAIL:** Delete the generated code, improve the spec or docs, and re-run `/ml-impl`.

### Step 5: Capture Learnings (`/ml-retain`)

```bash
/ml-retain
```

This updates TODO.md, CLAUDE.md (AGENTS.md), and any new `doc/` files with patterns discovered during the session. It commits and pushes your changes.

### Step 6: Clear Context and Repeat

Exit the AI CLI and start a new instance. You're ready for the next feature.

---

## The "Delete and Regenerate" Rule

**When something goes wrong, don't patch—delete and regenerate.**

Note: *Ask any experienced engineer why there are bugs in the code and one of core causes of bugs in unclear requirements (besides not enough time or resource to do the job right)*

This feels counterintuitive, but it's the key to single-shot repeatability:

1. Patches fix symptoms, not causes
2. The *cause* is unclear documentation
3. Fix the source (wireframe, spec, supporting documentation)
4. Regenerate from the improved source
5. Now anyone (including future-you) can reproduce it

**Learning is preserved in the docs, not in the code.**

---

## Troubleshooting

| Problem                             | Solution                                                    |
| ----------------------------------- | ----------------------------------------------------------- |
| AI misunderstands wireframe         | Simplify the wireframe, remove ambiguous elements           |
| Spec doesn't match project patterns | Update supporting documentation, then re-run `/ml-spec`     |
| Code deviates from spec             | Fix the spec first (make it clearer), then regenerate code  |
| AI asks too many questions          | Add more context to CLAUDE.md or annotate the wireframe     |
| Same mistake keeps happening        | Add an anti-pattern entry to your project's documentation |

---

## Tips for Success

- **Keep wireframes simple** — Whiteboard quality is perfect
- **Clear context between loops** — Fresh context = clean generation
- **Trust the process** — Deletion is cheap; knowledge is preserved in docs
- **Update supporting documentation early and often** — When you discover a pattern, document it immediately
- **Answer questions briefly** — The AI will incorporate your answers; don't over-explain
- **Suggested supporting documentation** - TODO.md, SHARED-PATTERNS.md, NOTEBOOK.md, DECISIONS.md
- **Curate your agents memory file** - make sure project knowledge that needs to be preserved between instances is in supporting documentation not only CLAUDE.md or AGENTS.md

---

## Next Steps

- **Full theory**: [ml-development-process.md](./ml-development-process.md)
- **Wireframe guide**: [how-to-create-a-wireframe.md](./how-to-create-a-wireframe.md)
- **Spec writing guide**: [how-to-write-a-view-spec.md](./how-to-write-a-view-spec.md)

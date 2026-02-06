---
description: Full implementation loop - plan, write, and review code (Meta-Loop Steps 3.1-3.4)
argument-hint: spec_path
---

# Meta-Loop: Implementation Loop

Complete the implementation loop: plan the implementation, write code, and review for correctness.

**Modes:** Plan Mode → Agent Mode → Ask Mode

## Arguments

- `$ARGUMENTS`: Path to the specification to implement
  - Examples: `specs/views/my-feature/spec.md`

## Prerequisites

This skill implements **Steps 3.1-3.4** of the Meta-Loop process defined in `skills/meta-loop-methodology/SKILL.md`.

The specification should have already passed `/ml-spec` review before invoking this skill.

---

## Phase 1: Plan (Plan Mode)

**Enter plan mode** and create a plan for implementing the specification.

### 1.1 Load Context

1. **Load the specification** from `$ARGUMENTS`
2. **Load associated wireframes** from the same directory
3. **Load `notes.md`** from the same directory (if it exists)
   - This file contains decisions from wireframe and spec phases
   - Clarifying questions and their answers
   - Key decisions and technical notes
4. **Read CLAUDE.md** for codebase patterns and conventions
5. **Load referenced view specs** (follow links in the spec)
6. **Explore relevant existing code:**
   - Similar views for patterns
   - Shared utilities and helpers
   - Theme and styling configuration

### 1.2 Create the Plan

The plan should outline:

**Files to Create:**
- Full paths for new files
- Purpose of each file

**Files to Modify:**
- Full paths for existing files
- Summary of changes to each

**Implementation Order:**
1. [First step - usually models/types]
2. [Second step - usually core logic]
3. [Third step - usually UI components]
4. [Fourth step - usually integration]
5. [Fifth step - usually tests]

**Testing Strategy:**
- Unit tests for logic
- Preview support for UI components
- Integration points to verify

**Build Verification:**
- How to verify the build succeeds
- What to test manually

### 1.3 Present Plan to Developer

Present the plan clearly and wait for developer feedback.

```
## Implementation Plan

### Specification
`$ARGUMENTS`

### Files to Create
| Path | Purpose |
|------|---------|
| `path/to/NewFile.swift` | [Purpose] |
| ... | ... |

### Files to Modify
| Path | Changes |
|------|---------|
| `path/to/ExistingFile.swift` | [Brief summary] |
| ... | ... |

### Implementation Order
1. **[Step]:** [Details]
2. **[Step]:** [Details]
...

### Testing Strategy
- [ ] [Test approach 1]
- [ ] [Test approach 2]

### Questions for Developer
- [Any clarifications needed before implementing]
```

### 1.4 Interrogation

Answer developer questions. Refine the plan based on feedback.

Questions to consider during review:
- Does the plan follow the specification exactly?
- Are the implementation steps in the right order?
- Is the testing strategy adequate?
- Are all the right files identified?

**If plan rejected:** Revise and repeat Phase 1.

**If plan approved:** Proceed to Phase 2.

---

## Phase 2: Write (Agent Mode)

**Exit plan mode** and execute the implementation plan.

### 2.1 Implement Following the Plan

Execute each step in the approved order:

1. **Create new files** as specified
2. **Modify existing files** as specified
3. **Follow codebase conventions** from CLAUDE.md
4. **Use existing components** where referenced in spec

### 2.2 Build Verification

After implementation:

1. **Run build check:**
   Use your project's build command (see CLAUDE.md), or XcodeBuild MCP: `mcp__xcodebuild__build_sim`

2. **Fix any compilation errors** (these are NOT deviations, just typos)

3. **Verify no warnings** introduced (or document acceptable ones)

### 2.3 Test Execution

If applicable:

1. **Run unit tests** to verify logic
2. **Check previews** render correctly
3. **Test in simulator** for interactive features

### 2.4 Update notes.md

Append the implementation phase notes to `notes.md`:

```markdown
---

## Implementation Phase ({date})

### Files Created
- `path/to/NewFile.swift` - [Brief description]

### Files Modified
- `path/to/ExistingFile.swift` - [What changed]

### Implementation Decisions
- [Any decisions made during implementation]
- [Deviations from spec (if any, with justification)]

### Issues Encountered
- [Any challenges and how they were resolved]
```

### 2.5 Output Summary

After implementation, provide a summary:

```
## Implementation Complete

### Specification Implemented
`$ARGUMENTS`

### Files Created
- `path/to/NewFile.swift` - [Brief description]
- ...

### Files Modified
- `path/to/ExistingFile.swift` - [What changed]
- ...

### Build Status
✅ Build succeeded / ❌ Build failed (details)

### Test Status
✅ Tests passing / ⚠️ Tests need attention / N/A

### notes.md Updated: ✅

### Proceeding to Review Phase...
```

---

## Phase 3: Review (Ask Mode)

Review the generated implementation for correctness.

### 3.1 Load for Review

1. Re-read the specification
2. Re-read the implementation files created/modified
3. Load wireframes for visual reference

### 3.2 Check for Deviations

**Specification Match:**
- [ ] Implementation matches spec exactly
- [ ] All specified features are present
- [ ] No features added beyond spec
- [ ] UI matches wireframe layout

**Codebase Patterns:**
- [ ] Follows conventions from CLAUDE.md
- [ ] Uses existing components correctly
- [ ] Styling matches theme system
- [ ] Proper environment usage

**Code Quality:**
- [ ] No unnecessary complexity
- [ ] Proper error handling
- [ ] Accessibility support included
- [ ] Preview support for SwiftUI views

**Testing:**
- [ ] Unit tests cover key logic
- [ ] Previews work correctly
- [ ] No test failures

### 3.3 Verdict

---

**If PASS:**

```
## ✅ Implementation Review: PASS

The implementation correctly follows the specification and codebase patterns.

### Implementation Location
[List of key files]

### Verification Summary
- [Key verification point]
- [Another point]

### Manual Testing Suggested
- [ ] [Specific thing to test in simulator]
- [ ] [Another test]

### Next Steps
1. **Clear your context** (important for clean learning retention)
2. Capture learnings:
   > /ml-retain
```

---

**If FAIL:**

```
## ❌ Implementation Review: FAIL

The implementation has deviations from the specification.

### Deviations Found
1. **[Deviation type]:** [Description]
   - **Source to update:** [Spec / Wireframe / CLAUDE.md]
   - **Suggested fix:** [What to change in source]

2. **[Another deviation]**
   ...

### Required Actions

**DO NOT patch the implementation.** Instead:

1. Identify which source document needs updating:
   - **Spec unclear?** → Update spec, may need to re-run `/ml-spec`
   - **Wireframe ambiguous?** → Update wireframe
   - **Codebase pattern missing?** → Update CLAUDE.md or pattern docs

2. **Delete the implementation:**
   - Revert new files: `git checkout -- [files]` or delete them
   - Revert modified files: `git checkout -- [files]`

3. **Re-run this skill:**
   > /ml-impl $ARGUMENTS

### Why Delete?
Learning is preserved in the updated source documents (spec, wireframe, CLAUDE.md), not in patches to the code. A clean regeneration ensures single-shot reproducibility.
```

---

## Key Constraints

- **Never patch implementation** - Delete and regenerate from improved source docs
- **Spec is truth** - Implementation derives from spec, not the other way around
- **Build must succeed** - Fix compilation errors before review (these aren't deviations)
- **Tests must pass** - Failing tests indicate deviation
- **Clear context between phases** if the process spans multiple sessions

## Related Steps

| Step | Skill/Action |
|------|--------------|
| 2.1-2.4 Spec Loop | `/ml-spec` (prerequisite) |
| **3.1-3.4 Implementation Loop (This Skill)** | `/ml-impl` |
| 3.5 Implementation Complete | Developer confirms, clears context |
| 4. Learning Retention | `/ml-retain` |

## Build Verification Commands

During Phase 2, verify compilation using your project's build tools:
- **Xcode**: Cmd+B or use the XcodeBuild MCP tools
- **Command line**: `xcodebuild` or `swift build` for SPM projects

Your CLAUDE.md should document the specific build commands for your project.

## Build Failure Handling

If the build fails during Phase 2:

1. **Compilation errors are NOT deviations** - Fix them directly
2. Use your project's build diagnostics (Xcode errors, compiler output)
3. Only proceed to Phase 3 review after build succeeds
4. **Runtime issues discovered in review ARE deviations** - Follow the fail path

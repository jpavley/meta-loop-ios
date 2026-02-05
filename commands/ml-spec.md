---
description: Full specification loop - plan, write, and review spec (Meta-Loop Steps 2.1-2.4)
arguments: wireframe_path
---

# Meta-Loop: Specification Loop

Complete the specification loop: plan the spec, write it, and review for correctness.

**Modes:** Plan Mode → Agent Mode → Ask Mode

## Arguments

- `$ARGUMENTS`: Path to wireframe(s) that will drive the specification
  - Examples: `specs/screens/my-feature/wireframe.png` or `specs/screens/my-feature/`

## Prerequisites

This skill implements **Steps 2.1-2.4** of the Meta-Loop process defined in `specs/sw-development-process.md`.

The wireframe should have already passed `/ml-wireframe` review before invoking this skill.

---

## Phase 1: Plan (Plan Mode)

**Enter plan mode** and create a plan for writing the specification.

### 1.1 Load Context

1. **Load wireframe(s)** from `$ARGUMENTS`
2. **Load `notes.md`** from the same directory (if it exists)
   - This file contains decisions from the `/ml-wireframe` phase
   - Clarifying questions and answers
   - Understanding summary and key components
   - Technical notes and references
3. **Read CLAUDE.md** for codebase patterns and conventions
4. **Check for existing specs** in `specs/` directory that might be referenced
5. **Identify spec category:**
   - `specs/screens/` for screen-level features
   - `specs/components/` for reusable UI components
   - `specs/services/` for backend services
   - `specs/utilities/` for helper utilities

### 1.2 Create the Plan

The plan should outline:

**Spec Location:**
- Target path: `specs/{category}/{name}/spec.md`
- Wireframe copy location (wireframes live with spec)

**Sections to Include:**
- Overview/Purpose
- Layout/Structure
- Components (with references to existing component specs)
- Interactive Elements
- States and Transitions
- Data Requirements
- Accessibility Considerations

**Existing Patterns to Reference:**
- Which components from `specs/components/` to reference
- Which shared patterns from `specs/screens/shared-screen-patterns/` apply
- Architecture patterns from CLAUDE.md

**Architectural Decisions:**
- Any decisions needed for this feature
- Trade-offs to document

### 1.3 Present Plan to Developer

Present the plan clearly and wait for developer feedback.

```
## Specification Plan

### Target Location
`specs/{category}/{name}/spec.md`

### Sections
1. [Section name] - [Brief purpose]
2. [Section name] - [Brief purpose]
...

### Existing Patterns Referenced
- [Component/pattern] - [How it applies]
...

### Architectural Decisions
- [Decision] - [Rationale]
...

### Questions for Developer
- [Any clarifications needed before writing]
```

### 1.4 Interrogation

Answer developer questions. Refine the plan based on feedback.

**If plan rejected:** Revise and repeat Phase 1.

**If plan approved:** Proceed to Phase 2.

---

## Phase 2: Write (Agent Mode)

**Exit plan mode** and execute the specification plan.

### 2.1 Create Spec Directory

Create the spec directory if it doesn't exist:
```
specs/{category}/{name}/
```

### 2.2 Copy Wireframes

Copy wireframe images to the spec directory so they live together:
```
specs/{category}/{name}/wireframe.png
specs/{category}/{name}/portrait.png (if multiple)
specs/{category}/{name}/landscape.png (if multiple)
```

### 2.3 Write Specification

Write `specs/{category}/{name}/spec.md` following the approved plan.

**Spec Structure Template:**

> **Code Placement Rule:** Requirement sections (everything above Implementation Reference) must be **platform-agnostic** — use prose, tables, and diagrams instead of platform-specific code. This ensures the spec is portable: a developer building the same feature in SwiftUI, Kotlin, React, or Godot should be able to read the requirements and understand WHAT to build. Platform-specific code belongs exclusively in the **Implementation Reference** section, which translates requirements into the target codebase.

```markdown
# [Feature Name]

## Overview
[Brief description of purpose and scope]

## Wireframe
![Wireframe](./wireframe.png)

## Layout
[Description of arrangement, spacing, sections — use tables and prose, not code]

## Components
[List components with links to component specs]
- [ComponentName](../../components/{name}/spec.md)

## Interactive Elements
| Element | Action | Result |
|---------|--------|--------|
| ... | ... | ... |

## States
[Different states the feature can be in]

## Data Requirements
[Data needed, sources, formats — describe inputs/outputs in prose]

## Accessibility
[VoiceOver labels, Dynamic Type support, etc.]

## Implementation Reference
[Platform-specific code goes HERE — struct signatures, code skeleton, usage examples.
This is the ONLY section where Swift/platform code belongs.]
```

**Writing platform-agnostic requirements:**

| Instead of... | Write... |
|---------------|----------|
| `struct MyScreen: View { let id: String; let onDismiss: () -> Void }` | **Inputs:** `id` (string) and `onDismiss` (callback) |
| Swift code showing an algorithm | Numbered prose steps describing the logic |
| `.toolbarButtons(dismiss: onDismiss)` | Dismiss button only, top-left placement |
| A SwiftUI modifier chain | A table mapping style properties to values |
| `VStack` / `HStack` | "vertical stack" / "horizontal stack" |
| `.pageBackground()` | "within Page Background" |
| `@State private var x: Type` | Screen State table with name, type, description |
| `ScrollView` | "scrollable area" |
| `ForEach(items) { ... }` | "For each item in the collection" |
| `Content VStack` | "Content column" |
| `.cancellationAction` / `.bottomBar` | "top-left" / "bottom bar" |

**Requirements describe visual behavior, not implementation strategy.** A requirement should describe what the user sees (from the wireframe), not how the developer achieves it. If a sizing or layout directive could be wrong for a different content type, it's an implementation detail — not a requirement. For guidance on what wireframes should annotate, see `specs/how-to-create-a-wireframe.md`.

| Instead of... | Write... |
|---------------|----------|
| "Hugs content width (`.fixedSize`)" | "Content fills available width; text wraps within the area" |
| "Use `.frame(maxWidth: .infinity)`" | "Centers horizontally in available space" |
| "ScrollView with `.fixedSize(horizontal: true)`" | "Scrollable area; content wraps to fill width" |
| Describing HOW a component sizes itself | Describing WHAT the user sees in the wireframe |

### 2.4 Update notes.md

Append the specification phase decisions to `notes.md`:

```markdown
---

## Specification Phase ({date})

### Spec Location
`specs/{category}/{name}/spec.md`

### Key Decisions Made
- [Any decisions made during spec writing]
- [Deviations from wireframe review understanding (if any)]

### Components Used
- [List components referenced in spec]

### Open Questions for Implementation
- [Any questions that emerged during spec writing]
```

### 2.5 Output Summary

After writing, provide a summary:
```
## Specification Created

**Location:** `specs/{category}/{name}/spec.md`

**Files Created:**
- spec.md
- wireframe.png
- [other files]

**Components Referenced:**
- [List of existing components used]

**notes.md Updated:** ✅

**Proceeding to Review Phase...**
```

---

## Phase 3: Review (Ask Mode)

Review the generated specification for correctness.

### 3.1 Load for Review

1. Re-read the specification just created
2. Re-load the source wireframe(s)
3. Load any referenced component specs

### 3.2 Check for Deviations

**Wireframe Match:**
- [ ] Spec accurately represents wireframe intent
- [ ] All wireframe elements are documented
- [ ] No elements added that aren't in wireframe
- [ ] Layout description matches visual

**Codebase Patterns:**
- [ ] Follows conventions from CLAUDE.md
- [ ] Uses existing components where appropriate
- [ ] Architectural patterns are correct

**Scope:**
- [ ] Single feature/screen/service (not overloaded)
- [ ] Appropriate level of detail

**Code Placement:**
- [ ] Requirement sections (above Implementation Reference) are platform-agnostic — prose, tables, diagrams only
- [ ] No platform-specific code (Swift, Kotlin, etc.) outside Implementation Reference section
- [ ] No `VStack`, `HStack`, `ScrollView`, or other UI framework types in requirement sections
- [ ] No `.modifier()` syntax outside Implementation Reference
- [ ] No `struct X: View` signatures outside Implementation Reference
- [ ] No `@State`, `@Environment`, or framework annotations outside Implementation Reference
- [ ] Data models described with field tables, not language-specific type declarations
- [ ] Implementation Reference contains the platform-specific translation (struct signatures, code skeleton)

**Requirements vs Implementation:**
- [ ] Layout/sizing descriptions match the VISUAL BEHAVIOR shown in the wireframe
- [ ] No sizing strategy prescribed (e.g., "hugs content", "fixed size") — only visual outcome described
- [ ] When a component is reused from another screen, any sizing/behavior differences are explicitly called out
- [ ] Requirement sections could be implemented on any platform — no framework-specific sizing concepts

**Reproducibility:**
- [ ] Could another session regenerate this spec from the wireframe?
- [ ] Are all decisions explicit, not implicit?

### 3.3 Verdict

---

**If PASS:**

```
## ✅ Specification Review: PASS

The specification accurately captures the wireframe intent and follows codebase patterns.

### Spec Location
`specs/{category}/{name}/spec.md`

### Verification Summary
- [Key verification point]
- [Another point]

### Next Steps
1. **Clear your context** (important for clean implementation)
2. Run implementation:
   > /ml-impl specs/{category}/{name}/spec.md
```

---

**If FAIL:**

```
## ❌ Specification Review: FAIL

The specification has deviations that need correction.

### Deviations Found
1. **[Deviation type]:** [Description]
   - **Source to update:** [Wireframe / CLAUDE.md / other doc]
   - **Suggested fix:** [What to change in source]

2. **[Another deviation]**
   ...

### Required Actions

**DO NOT patch the spec.** Instead:

1. Update the source documentation:
   - [ ] [Specific update to wireframe or docs]
   - [ ] [Another update]

2. **Delete the spec:**
   > rm -rf specs/{category}/{name}/

3. **Re-run this skill:**
   > /ml-spec $ARGUMENTS

### Why Delete?
Learning is preserved in the updated source documents (wireframe, CLAUDE.md), not in the spec itself. A clean regeneration ensures single-shot reproducibility.
```

---

## Key Constraints

- **Never patch specs** - Delete and regenerate from improved source docs
- **Keep specs focused** - Single feature/screen/service per spec
- **Reference, don't duplicate** - Link to component specs instead of re-describing
- **Wireframes are truth** - Spec derives from wireframe, not the other way around
- **Requirements are platform-agnostic** - Use prose, tables, and diagrams for all sections above Implementation Reference. Platform-specific code (Swift, Kotlin, etc.) belongs only in the Implementation Reference section
- **Clear context between phases** if the process spans multiple sessions

## Related Steps

| Step | Skill/Action |
|------|--------------|
| 1.2 Wireframe Review | `/ml-wireframe` (prerequisite) |
| **2.1-2.4 Spec Loop (This Skill)** | `/ml-spec` |
| 2.5 Spec Complete | Developer confirms, clears context |
| 3.1-3.4 Implementation Loop | `/ml-impl` |

## File Organization

```
specs/
├── screens/                    ← Screen-level specs
│   └── {screen-name}/
│       ├── spec.md
│       ├── wireframe.png
│       └── *.png (variants)
├── components/                 ← Reusable components
│   └── {component-name}/
│       ├── spec.md
│       └── *.png
├── services/                   ← Backend services
└── utilities/                  ← Helper utilities
```

---
description: Review wireframe to ensure AI understanding before spec creation (Meta-Loop Step 1.2)
argument-hint: wireframe_path
---

# Meta-Loop: Wireframe Review

Review a wireframe to ensure mutual understanding between developer and AI before specification creation.

**Mode:** Ask Mode (questions and feedback only, no generation)

## Arguments

- `$ARGUMENTS`: Path to wireframe image(s) to review
  - Can be a single image path or a directory containing multiple wireframes
  - Examples: `specs/views/my-feature/wireframe.png` or `specs/views/my-feature/`

## Prerequisites

This skill implements **Step 1.2** of the Meta-Loop process defined in `skills/meta-loop-methodology/SKILL.md`.

The developer should have already drawn the wireframe (Step 1.1) before invoking this review.

## Workflow

### Phase 1: Load Wireframes

1. **Resolve the path:**
   - If `$ARGUMENTS` is a directory, glob for `*.png`, `*.jpg`, `*.jpeg` files
   - If `$ARGUMENTS` is a file, load that single image
   - If no argument provided, ask the developer for the wireframe path

2. **Load each wireframe image** using the Read tool

3. **Check for reusable view wireframes:**
   - Scan for any elements that appear multiple times
   - Note if separate view wireframes exist for reusable patterns

### Phase 2: Analyze

Describe your understanding of the wireframe. Cover:

1. **Layout Structure:**
   - Overall arrangement (vertical, horizontal, grid, etc.)
   - Major sections and their relationships
   - Spacing and alignment patterns

2. **Views Identified:**
   - UI elements visible (buttons, text fields, lists, etc.)
   - Reusable patterns that could be extracted as views
   - Data display areas

3. **Data Flow:**
   - What data is being displayed?
   - What user inputs are expected?
   - What state changes might occur?

4. **Interactions:**
   - Tappable/clickable elements
   - Navigation triggers
   - Gestures implied

5. **Codebase Patterns:**
   - Reference existing patterns from CLAUDE.md that apply
   - Note any existing views that could be reused
   - Identify architectural patterns that fit

### Phase 3: Clarify

**Only ask questions if the wireframe has genuine ambiguities.** If the wireframe and its annotations answer everything, skip this phase and say so — do not invent questions to fill a quota.

If there ARE ambiguities, ask **specific** clarifying questions (up to 5). Do NOT ask general questions like "What else should I know?"

Good questions address things the wireframe leaves unclear:
- "Should the header scroll with content or stay fixed?"
- "Is this button enabled/disabled based on form state?"
- "Does tapping this row navigate or expand inline?"

Bad questions restate what the wireframe already shows, or are generic:
- "What do you want this to do?"
- "Is there anything else?"
- "Where does the data come from?" (when the wireframe annotation already says)

Implementation questions ask HOW a requirement will be achieved rather than WHAT the wireframe intends. These belong to the implementor, not the spec:
- "How will this overlay be layered?" (wireframe shows layering — that's a clear requirement, not an open question)
- "Should this use a ZStack or overlay?" (implementation choice)
- "What SwiftUI modifier achieves this?" (implementation detail)

**The test:** If the wireframe annotation states a requirement clearly, capture it as a requirement in the verdict — don't convert it into a question. Only ask when the wireframe's **intent** is unclear, not when the **implementation path** is unclear.

### Phase 4: Verdict

Evaluate whether the wireframe is clear enough to drive specification creation.

**PASS Criteria:**
- Layout intent is unambiguous
- All interactive elements have clear purpose
- Data sources are identifiable
- Navigation flow is understandable
- No major gaps in understanding

**FAIL Criteria:**
- Ambiguous element relationships
- Unclear interaction patterns
- Missing critical sections
- Conflicting visual signals

### Phase 5: Learn View Spec Format (PASS only)

**If the wireframe passes review**, before providing the verdict:

1. **Read the view spec guide:** Use the Read tool to load `skills/view-specifications/SKILL.md`
2. **Review the template:** The template is included in the view-specifications skill
3. **Note key patterns:** Identify which sections from the guide apply to this view

This ensures you understand the spec format before the developer runs `/ml-spec`.

### Phase 6: Persist Decisions (PASS only)

**Create or update `notes.md`** in the spec directory to preserve decisions for the next phase:

1. **Create file:** `{spec-directory}/notes.md`
2. **Include:**
   - Date of wireframe review
   - All clarifying questions and their answers
   - Understanding summary (1-2 sentences)
   - Key components identified
   - Error states and edge cases
   - Technical notes (references to design docs, algorithms, etc.)

**Template:**
```markdown
# {View Name} Design Decisions

> Decisions captured during Meta-Loop phases. Each phase appends its findings.

---

## Wireframe Review ({date})

### Clarifying Questions Resolved

| Question | Decision |
|----------|----------|
| [Question 1] | [Answer] |
| ... | ... |

### Understanding Summary

[1-2 sentence summary of what will be built]

### Key Views

- [View 1]
- [View 2]

### Error States

- [Error state 1]
- [Error state 2]

### Technical Notes

- [Reference to design doc, algorithm, etc.]
```

**Why persist?** When the developer clears context and runs `/ml-spec`, the new session has no memory of this conversation. The `notes.md` file carries decisions forward.

---

**If PASS:**

```
## ✅ Wireframe Review: PASS

The wireframe is clear enough to proceed with specification creation.

### Understanding Summary
[1-2 sentence summary of what will be built]

### Key Decisions Captured
- [Decision 1 from clarifying questions, OR "No open questions — wireframe annotations covered all design decisions."]

### View Spec Sections Identified
Based on `skills/view-specifications/SKILL.md`, this view will need:
- [List the spec sections that apply, e.g., "Child views table"]
- [E.g., "Data Model section"]
- [E.g., "No Error Handling section needed (read-only display)"]

### Next Step
Clear your context and run:
> /ml-spec $ARGUMENTS

**Note:** The `notes.md` file has been created/updated with decisions from this review. The `/ml-spec` phase will read it automatically.
```

---

**If FAIL:**

```
## ❌ Wireframe Review: NEEDS IMPROVEMENT

The wireframe needs updates before specification can begin.

### Issues Found
1. [Specific issue requiring wireframe update]
2. [Another issue]

### Suggested Improvements
- [Specific change to make to wireframe]
- [Another change]

### Next Step
Update the wireframe to address these issues, then re-run:
> /ml-wireframe $ARGUMENTS
```

## Key Constraints

- **Do NOT generate code or specs** - This is Ask Mode only
- **Do NOT add implementation details** - Feedback should be about clarity, not implementation
- **Focus on understanding** - Your job is to verify the wireframe communicates intent
- **Keep questions specific** - Generic questions waste the developer's time
- **Reference the codebase** - Ground feedback in this project's patterns

## Related Steps

| Step | Document Location |
|------|-------------------|
| 1.1 Wireframe (Human) | Developer draws manually |
| **1.2 Wireframe Review (This Skill)** | `/ml-wireframe` |
| 1.3 Wireframe Complete (Human) | Developer confirms and clears context |
| 2.1-2.4 Specification Loop | `/ml-spec` |

---
name: wireframe-design
description: Tips and guidelines for creating wireframes that drive accurate specifications via the Meta-Loop process
---

# How to Create a Wireframe

> Tips for creating wireframes that drive accurate specs via `/ml-spec`

## Purpose

Wireframes are the primary input to the Meta-Loop specification process. The AI reads your wireframe and generates a specification document from it. There are two types: **screen wireframes** (what the user sees) and **logic wireframes** (what happens behind the scenes). These tips help you create both types of wireframes that communicate your intent clearly — especially the parts the AI is likely to misunderstand.

**For the full Meta-Loop process**, see the [meta-loop-methodology](../meta-loop-methodology/SKILL.md) skill.

---

## Wireframe Principles

1. **Whiteboard quality is fine.** Wireframes don't need to be pixel-perfect. Rough sketches with clear annotations work better than polished mockups with no annotations.

2. **Annotations are the real content.** The sketch shows layout; the annotations communicate intent. When in doubt, add an annotation.

3. **Wireframes communicate intent, not pixels.** The AI doesn't need exact dimensions or colors — it needs to understand *what you want the user to experience*.

---

## Wireframe Types

### Screen Wireframes

Screen wireframes show **what the user sees** — layout, UI elements, and visual states. These are the classic wireframes: boxes representing views, labels indicating content, and annotations explaining behavior.

- Show layout structure, spacing, and element arrangement
- Can show multiple states side-by-side on one image (e.g., populated list and empty state)
- Name with a descriptive suffix: `main-view-wireframe.png`, `edit-wireframe.png`

### Logic Wireframes

Logic wireframes show **what happens behind the scenes** — data flow, processing steps, derived values, and decision points. These look like flowcharts or data-flow diagrams, not screen layouts.

- Show how data enters, transforms, and flows through the feature
- No UI chrome needed — boxes represent processes, not views
- Use for paste capture logic, validation pipelines, rating calculations, etc.
- Name with a descriptive suffix: `paste-logic-wireframe.png`, `search-logic-wireframe.png`

### When to Use Each

| Situation | Wireframe Type | Example |
|-----------|---------------|---------|
| New screen or view | Screen | `bookmark-main-view-wireframe.png` |
| Complex data processing | Logic | `paste-logic-wireframe.png` |
| Feature with both UI and logic | Both | Screen wireframe + logic wireframe |
| Simple CRUD with no special logic | Screen only | One screen wireframe covers it |
| Background process with no UI | Logic only | Data sync, cleanup routines |

Most features need at least one screen wireframe. Add logic wireframes when the feature involves non-trivial processing that the AI needs to understand to write a correct spec.

---

## What to Annotate

| Category | What to Call Out | Example |
|----------|-----------------|---------|
| Component identification | What each visual element IS | `← Modal Title component` |
| Data flow | Where content comes from | `← loaded from app bundle` |
| Behavioral requirements | Scrolling, error states, CRT exclusion | `← scrollable, NO barrel distortion` |
| Sizing behavior differences | When this screen sizes differently from similar screens | `← content fills width (unlike menu screens)` |
| Interaction triggers | What tapping/swiping does | `← tap to dismiss, returns to Help Menu` |
| Orientation differences | How landscape differs from portrait | `← single column in both orientations` |

---

## The Difference Rule

**When a component or layout behaves differently from how it appears on other screens, annotate the difference.**

### Why This Matters

The spec writer (AI) will look at your wireframe, identify familiar components, and assume they behave the same way they do everywhere else. Most of the time this assumption is correct. When it isn't, the spec will silently inherit the wrong behavior — and the bug won't surface until implementation.

### The Rule

If you're reusing a component or layout pattern from another screen, and it behaves differently here, write an annotation that calls out the difference. The format is:

```
← [what happens here] (unlike [what happens elsewhere])
```

### Real Example: Reused Container Bug

Imagine a `PageBackground` container appears on 6 views. On 5 of them, it wraps discrete lines of text (menu items, stat rows) where the content has a natural fixed width. The spec writer saw `PageBackground` on the Document Reader wireframe and assumed the same sizing pattern — "hugs content width." But the Document Reader wraps *flowing text* that needs to fill the available width.

**Without annotation:** The spec prescribed a sizing strategy that works for discrete lines but breaks flowing text. Implementation followed the spec. Text didn't wrap.

**With annotation:** A note saying `← content fills width (unlike views with discrete lines)` would have told the spec writer that this container behaves differently, preventing the wrong assumption.

### More Examples

| Annotation | What It Prevents |
|------------|-----------------|
| `← content fills width (unlike list views)` | Copying discrete-line sizing to flowing text |
| `← no bottom bar` | Inheriting the bottom bar from other modal views |
| `← single column in landscape (unlike menu's two columns)` | Copying the two-column landscape layout |
| `← scrollable area includes Page Background` | Assuming Page Background sits outside the scroll view |
| `← title extracted from document (not hardcoded)` | Assuming the title is a static string |

---

## What NOT to Annotate

These are implementation details that belong in code, not wireframes:

| Skip This | Why |
|-----------|-----|
| Exact pixel dimensions | The layout system handles spacing |
| Color values or names | Colors come from the theme system |
| Font names or sizes | Fonts come from the font system |
| Implementation strategy (`.fixedSize`, modifier chains) | The developer chooses the right approach |
| Platform-specific API names | Specs should be platform-agnostic |

**Rule of thumb:** If it's about *what the user sees*, annotate it. If it's about *how the developer builds it*, skip it.

---

## File Format and Location

- **Format:** PNG (exported from any drawing tool — iPad sketch apps, Figma, whiteboard photos)
- **Location:** `specs/views/<feature-name>/`
- **Naming:** Use descriptive names ending in `-wireframe.png`

| Pattern | When to Use | Example |
|---------|-------------|---------|
| `{description}-wireframe.png` | Most wireframes | `main-view-wireframe.png` |
| `{description}-portrait-wireframe.png` | Orientation variant | `main-view-portrait-wireframe.png` |
| `{description}-landscape-wireframe.png` | Orientation variant | `main-view-landscape-wireframe.png` |
| `{description}-logic-wireframe.png` | Logic/flowchart wireframe | `paste-logic-wireframe.png` |

```
specs/views/bookmarks/
├── bookmark-main-view-wireframe.png    ← screen wireframe (you create)
├── bookmark-edit-wireframe.png         ← screen wireframe (you create)
├── paste-logic-wireframe.png           ← logic wireframe (you create)
├── about-this-view.md                  ← optional context (you create)
├── spec.md                             ← generated by /ml-spec
└── notes.md                            ← generated by /ml-wireframe
```

---

## Orientation and States

### Orientation Variants

Create separate wireframes for each orientation **only when the layouts differ meaningfully** (e.g., single-column portrait vs. two-column landscape). Name them with orientation in the filename:

- `main-view-portrait-wireframe.png`
- `main-view-landscape-wireframe.png`

**Portrait-only apps** need no orientation annotation or separate wireframes — a single screen wireframe is sufficient.

If the layout is identical in both orientations (just wider), you can note that on a single wireframe: `← same layout in landscape, just wider`.

### State Variants

When a view has multiple visual states (populated, empty, error, loading):

- **Show multiple states side-by-side on one image** when practical — this gives the AI full context in a single wireframe
- **Use separate images with descriptive names** when states are complex enough to warrant their own wireframe (e.g., `search-results-wireframe.png`, `search-empty-wireframe.png`)

---

## Quick Checklist

Scan this before running `/ml-wireframe`:

- [ ] Every visual element is labeled (what component it is)
- [ ] Data sources are annotated (where content comes from)
- [ ] Scrollable areas are marked
- [ ] **Any behavior that differs from the same component on other screens is annotated** (The Difference Rule)
- [ ] Interaction triggers are noted (what tapping does)
- [ ] Orientation is addressed (separate wireframes, annotation, or portrait-only)
- [ ] All wireframe files use descriptive `-wireframe.png` names
- [ ] Logic wireframes (if any) show processing steps, not UI layout
- [ ] No implementation details (no modifier names, no pixel values, no API calls)
- [ ] Error/empty states are shown or annotated

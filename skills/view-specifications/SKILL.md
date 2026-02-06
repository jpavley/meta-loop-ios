---
name: view-specifications
description: Guide for writing view specification documents and a starter template for SwiftUI and cross-platform views
---

# How to Write a View Spec

> This guide teaches Claude how to write specification documents for SwiftUI views. Use this alongside the template section below as your reference.

## Key Concepts

### View Principles

1. **Composed from views** — Views arrange reusable child views with appropriate spacing
2. **Callback navigation** — Views receive closures (`onDismiss`, `onSelectItem`); they don't know where to navigate
3. **Data independent** — Views accept only primitive inputs (IDs, strings, values) and derive display data themselves. A view should never require its caller's data model.
4. **Layout-aware** — Every view provides portrait and landscape layouts where appropriate
5. **Animation coordination** — Views assign animation offsets to each element
6. **Platform-agnostic requirements** — All sections above Implementation Reference describe WHAT to build using prose, tables, and diagrams. Platform-specific code (Swift, Kotlin, etc.) belongs exclusively in Implementation Reference

### View Scope: What to Think About vs. Trust the System

View specs should focus thinking on **view-level concerns** and trust other systems for everything else.

**Requirements vs. implementation details:** Specs capture **what** the view must do (requirements from the wireframe) — not **how** the code achieves it. If the wireframe says "scrolling text should not receive a visual effect," the spec states that requirement in the Notes section. It does not prescribe the layering approach, modifier chain, or rendering technique. The implementor decides the approach.

**Platform-Agnostic Vocabulary**

| Instead of... | Write... |
|---------------|----------|
| `VStack` / `HStack` | "vertical stack" / "horizontal stack" |
| `ScrollView` | "scrollable area" |
| `struct MyView: View { let x: Type }` | Interface table (see Section 10) |
| `@State private var x: Type` | View State table (see Section 10) |
| `ForEach(items) { ... }` | "For each item in the collection" |
| `.cancellationAction` / `.bottomBar` | "top-left" / "bottom bar" |
| `Content VStack` / `Left VStack` | "Content column" / "Left column" |

**Think deeply about (view concerns):**

| Concern | Example Questions |
|---------|-------------------|
| View composition | Which child views? In what order? |
| Layout structure | Portrait vs landscape arrangement? Single column or two? |
| Content | What text? Where does data come from? |
| Interactions | What's tappable? What happens on tap? |
| Callbacks | What closures does the parent provide? |
| Animation offsets | What animation order for elements? |

**Trust the system for (not view concerns):**

| Concern | Handled By | Don't Ask... |
|---------|------------|--------------|
| Device-specific sizing | Layout system | "Should iPad have a max width?" |
| Font sizes | Font system | "What font size on iPhone SE?" |
| Colors | Theme system | "What exact color values?" |
| Responsive breakpoints | Layout system | "At what width does layout change?" |

If a question is about *how this view arranges its content*, think deeply. If a question is about *how the app handles device differences*, trust that the layout system already handles it — or note it as a potential layout system enhancement, not a view spec decision.

### Wireframes Are the Source of Truth

**Important:** When writing a spec, the wireframe defines the intended behavior. If existing code in the codebase conflicts with the wireframe, **follow the wireframe**. The codebase may contain legacy implementations that predate the spec-driven approach.

Examples:
- Wireframe shows title parsed from markdown `# Heading` → spec should describe runtime parsing, even if current code uses a hardcoded mapping
- Wireframe shows a new layout pattern → spec should describe that pattern, not preserve old layout code
- Wireframe annotations override any assumptions from reading existing code

The spec captures what the view **should** do, not what legacy code **currently** does.

## Before Writing a Spec

**Read your project's shared patterns:** If your project has a shared patterns document (referenced in CLAUDE.md), read it first. This file typically defines common styling rules, layout conventions, and animation patterns. Understanding these shared patterns prevents duplicating rules in your spec and ensures consistency across views.

**Read referenced view specs:** If the wireframe labels child views, read the corresponding view specs before writing the parent view spec. Child view specs define:

- What parameters the view accepts
- Internal behavior and styling rules
- What the parent is responsible for vs. what the child handles

This prevents the view spec from duplicating child view behavior or making incorrect assumptions.

## Spec File Structure

Every view spec follows this structure. Use the template at the end of this document as your starting point.

### 1. Header

```markdown
<!-- VIEW: {view-name} -->
# {View Name}

> One-sentence description of what this view does.
```

### 2. Wireframes Section

Always include both wireframes with descriptive alt text:

```markdown
## Wireframes

### Portrait

![{View Name} - Portrait](./portrait.png)

### Landscape

![{View Name} - Landscape](./landscape.png)
```

### 3. Child Views Table

List ALL child views this view composes. Link to their specs if they have them.

```markdown
## Child Views

This view composes the following child views:

| View            | Spec                                      | Instances                   |
| --------------- | ----------------------------------------- | --------------------------- |
| HeaderView      | [header-view](../header-view/spec.md)     | 1                           |
| ListItemView    | [list-item-view](../list-item-view/spec.md) | N (one per item)          |
| ...             | ...                                       | ...                         |
```

Document which views are reused from your project's existing components, and which are new.

### 4. Layout Section

Describe the layout for BOTH orientations. Be explicit about:
- Container hierarchy (vertical stacks, horizontal stacks, columns)
- What goes in each container
- Alignment for each container (especially leading alignment for lists)

**Portrait example:**

```markdown
### Portrait

Single-column vertical stack:

| Element     | Description                                |
| ----------- | ------------------------------------------ |
| Header      | View title                                 |
| Content     | Vertical stack with main content           |

**Content column:**

1. Section header
2. List items (N rows)
3. Footer notes

**Alignment:**

| Container | Alignment | Reason |
| --------- | --------- | ------ |
| Content column | Center (default) | Centers the content |
| List items column | **Leading** | Indicators form a straight left edge |
```

**Landscape example:**

```markdown
### Landscape

Two-column horizontal layout:

| Element      | Description                                        |
| ------------ | -------------------------------------------------- |
| Header       | View title (full width)                            |
| Left column  | Vertical stack with primary content                |
| Right column | Vertical stack with secondary content              |

**Column group centering:** Both columns sit side-by-side as a centered group — they do NOT spread to fill the available width.
```

### 5. Spacing Section

Document ALL gaps between elements. Separate portrait and landscape if values differ.

```markdown
## Spacing

### Portrait

| Gap                                    | Value |
| -------------------------------------- | ----- |
| Header to content column               | 16pt  |
| Container inner padding                | 20pt  |
| Section header to first item           | 12pt  |
| Between list items                     | 8pt   |
```

### 6. Content Section

Document the actual content — text, data sources, static values.

```markdown
## Content

### Header

- **Title:** `# VIEW TITLE #`
- **Subtitle:** `{context-specific subtitle}`

### Section Name

Describe what appears in each section. Include:
- Exact text strings (in backticks)
- Data sources (e.g., "from `viewModel.property`")
- Any transformations (e.g., "uppercase", "padded to 22 chars")
```

### 7. Data Model Section (if applicable)

If the view displays data from a model, document the model structure using a field table:

```markdown
### Data Model

**ItemModel:**

| Field | Type | Description |
|-------|------|-------------|
| `id` | string, unique | Unique identifier |
| `title` | string | Display title |
| `subtitle` | string, optional | Secondary text |
```

### 8. Toolbar Configuration Section

```markdown
## Toolbar Configuration

Describe button placement using a table:

| Button | Icon | Placement | Action |
|--------|------|-----------|--------|
| Dismiss | X symbol | Top-left | Returns to previous screen |

- **Dismiss button:** Top-left (standard dismiss position)
- **Bottom bar:** None (or describe action buttons)
```

**Dismiss button behavior:** The dismiss button always returns to the view that presented the current view. The view doesn't know or care *where* it returns to — it simply calls `onDismiss()`, and the parent provides the navigation logic. This keeps views decoupled from the navigation hierarchy.

### 9. Interaction Section

Document ALL tappable elements and their behaviors:

```markdown
## Interaction

| Action              | Behavior                                            |
| ------------------- | --------------------------------------------------- |
| Tap list item       | Calls `onSelectItem(item)`, navigates to detail     |
| Tap Dismiss (X)     | Calls `onDismiss`, returns to previous view         |
```

### 10. View Interface Section

Document the view's inputs and outputs:

```markdown
### View Interface

**Inputs:**

| Parameter | Type | Description |
|-----------|------|-------------|
| items | [ItemModel] | Data to display |
| selectedId | String? | Currently selected item |

**Outputs (callbacks):**

| Event | Payload | Description |
|-------|---------|-------------|
| onSelectItem | item | Called when user taps an item |
| onDismiss | — | Called when user dismisses |

**Callback pattern:** The view doesn't know where to navigate — it receives callbacks from its parent. The parent provides the navigation logic.
```

### 11. Animation Section

Document animation offsets for each element (if your project uses sequential animations):

```markdown
## Animation

### Animation Offsets

View assigns starting offsets to each element:

| Element                | Element Count | Starting Offset |
| ---------------------- | ------------- | --------------- |
| Header                 | 1             | 1               |
| Section Title          | 1             | 2               |
| List Items (×N)        | N             | 3               |

**Total elements:** N + 2

**Note:** Offsets create sequential appearance animations.
```

### 12. Styling Section

Reference shared patterns — don't duplicate rules:

```markdown
## Styling

- Follows project's shared styling patterns (see CLAUDE.md)
- Accent color: Inherited from theme
```

### 13. Accessibility Section

```markdown
## Accessibility

- View announced as "{View Name}"
- Interactive elements have appropriate accessibility labels
- List items are buttons with action hints
```

### 14. Implementation Reference Section

Show the file location and key code patterns. This section is the **only place** for platform-specific code. It should also contain:
- Swift struct signature (or equivalent in target platform)
- Key modifiers or patterns
- Parent call-site example (how the parent wires callbacks)

```markdown
## Implementation Reference

- **File:** `Views/MyView.swift`

```swift
struct MyView: View {
    let items: [ItemModel]
    let onSelectItem: (ItemModel) -> Void
    let onDismiss: () -> Void

    var body: some View {
        // Implementation here
    }
}
```
```

### 15. Error Handling Section (if applicable)

```markdown
## Error Handling

### Scenario Name

Describe what happens when things go wrong (missing data, invalid input, etc.)
```

### 16. Notes Section

Catch-all for important details that don't fit elsewhere:

```markdown
## Notes

- Any special rendering considerations
- Differences from similar views
- Non-obvious design decisions from wireframe annotations
```

## Wireframe Annotations

Good wireframes include annotations that map UI elements to views. When reviewing wireframes, look for:

| Annotation Type | Example | Purpose |
|-----------------|---------|---------|
| View labels | "HeaderView" | Identifies which reusable view to use |
| Data sources | "Data passed from parent view" | Clarifies where data comes from |
| Behavioral notes | "Scrolling text should NOT receive effect X" | Captures non-obvious requirements |
| Element groupings | Rounded rectangles around content | Shows what's inside a container |

**Annotations are scoped to what they name.** When an annotation references specific elements, it applies to exactly those elements. Unnamed elements follow their default behavior. Do not ask whether unnamed elements are also affected — they aren't.

## Common Pitfalls

### 1. Forgetting Landscape Layout

Every view MUST specify both portrait AND landscape where applicable. Phone landscape uses different column arrangements than portrait.

### 2. Missing Alignment Specifications

Lists with indicators MUST use leading alignment so indicators form a straight vertical line.

### 3. Duplicating Shared Patterns

Don't copy-paste styling rules into the spec. Reference your project's shared patterns instead.

### 4. Mixing Parent and Child View Concerns

- **Parent view spec:** External spacing, layout, animation offsets, callbacks
- **Child view spec:** Internal behavior, internal spacing, text formatting

If you're describing internal child view behavior in a parent view spec, stop and create/reference a child view spec instead.

## Checklist Before Completing a View Spec

- [ ] Header has HTML comment `<!-- VIEW: {name} -->` for tooling
- [ ] Both wireframes embedded with proper alt text
- [ ] Child views table links to all used view specs
- [ ] Layout section covers BOTH portrait AND landscape (where applicable)
- [ ] Alignment explicitly specified for all containers holding lists
- [ ] Spacing values documented for both orientations
- [ ] Content section has exact text strings in backticks
- [ ] View interface documented with inputs, outputs, and callback descriptions
- [ ] Animation offsets documented (if applicable)
- [ ] Styling references shared patterns (no duplication)
- [ ] Implementation reference shows file location and key code
- [ ] No platform-specific code (Swift, Kotlin, etc.) outside Implementation Reference section
- [ ] Notes section captures any non-obvious requirements from wireframe annotations

---

## Template

Use this template as the starting point for new view specs:

```markdown
<!-- VIEW: view-name -->
# View Name

> Brief description of the view's purpose.

## Wireframes

### Portrait
![Portrait wireframe](./portrait.png)

### Landscape
![Landscape wireframe](./landscape.png)

### Tablet (optional)
![Tablet wireframe](./tablet.png)

## Layout Requirements

- **Structure:** Describe the overall layout (vertical stack, grid, etc.)
- **Key sections:** List the main areas of the view
- **Spacing:** Note any important spacing rules

## Child Views

| View | Description | Instances |
|------|-------------|-----------|
| HeaderView | View header | 1 |
| ... | ... | ... |

## UI Elements

| Element | Description | Styling |
|---------|-------------|---------|
| Title | View title at top | Header styling |
| Content area | Main content | Primary color text |
| ... | ... | ... |

## Interactive Elements

| Element | Position | Icon | Action | Visibility |
|---------|----------|------|--------|------------|
| Dismiss | Toolbar | X | Returns to previous view | Always |
| ... | ... | ... | ... | ... |

## Styling Rules

- Follows project's shared styling patterns (see CLAUDE.md)
- Accent color: Inherited from theme

## Content Format

Describe any special text formatting rules:

- Data format: `LABEL: VALUE`
- Any special color treatments

## Animation

- **Entry:** Describe entry animation
- **Exit:** Describe exit animation

## View Interface

**Inputs:**

| Parameter | Type | Description |
|-----------|------|-------------|
| ... | ... | ... |

**Outputs (callbacks):**

| Event | Payload | Description |
|-------|---------|-------------|
| onDismiss | — | Called when user dismisses |
| ... | ... | ... |

## Implementation Reference

- **SwiftUI file:** `Views/ViewName.swift`

\```swift
struct ViewName: View {
    // Properties
    let onDismiss: () -> Void

    var body: some View {
        // Implementation
    }
}
\```

## Platform Variations

| Platform | Differences |
|----------|-------------|
| iPhone Portrait | Default layout |
| iPhone Landscape | Horizontal arrangement |
| iPad/Mac | Larger, same structure |

## Accessibility

- View announced as "View Name"
- Interactive elements have appropriate labels

## Notes

Any additional implementation notes or design decisions.
```

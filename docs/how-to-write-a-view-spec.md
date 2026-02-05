# How to Write a Screen Spec

> This guide teaches Claude how to write specification documents for screens in Bit Quiz 16. Use the Help Menu Screen spec as the canonical reference.

## Key Concepts

### Screens vs Modals (Legacy)

| Pattern | Location | Status | Description |
|---------|----------|--------|-------------|
| **Screens** | `Screens/*.swift` | Current | Spec-driven, content-only views that render ON TOP of persistent CRT background |
| **Modals** | `Modals/*.swift` | Legacy | Self-contained views with their own CRT/styling code (do not use as reference) |

**Important:** The code in `Modals/` is outdated. Always use `Screens/` implementations as your reference. The modal code includes embedded CRT effects and styling that screens should NOT have.

### Screen Principles

1. **Content only** — Screens don't include CRT shader code; they render on top of the persistent CRT background in `ContentView`
2. **Composed from components** — Screens arrange reusable components with external spacing
3. **Callback navigation** — Screens receive closures (`onDismiss`, `onSelectItem`); they don't know where to navigate
4. **Data independent** — Screens accept only primitive inputs (IDs, strings, values) and derive display data themselves. A screen should never require its caller's data model. For example, a document reader accepts a `documentId: String` and parses its own title from the file — it does not accept a `HelpMenuItem` from the Help Menu.
5. **Layout-aware** — Every screen provides portrait and landscape layouts
6. **Teletype coordination** — Screens assign animation offsets to each component
7. **Platform-agnostic requirements** — All sections above Implementation Reference describe WHAT to build using prose, tables, and diagrams. Platform-specific code (Swift, Kotlin, etc.) belongs exclusively in Implementation Reference

### Screen Scope: What to Think About vs. Trust the System

Screen specs should focus thinking on **screen-level concerns** and trust other systems for everything else.

**Requirements vs. implementation details:** Specs capture **what** the screen must do (requirements from the wireframe) — not **how** the code achieves it. If the wireframe says "scrolling text should not receive CRT effects," the spec states that requirement in the Notes section. It does not prescribe the layering approach, modifier chain, or rendering technique. The implementor decides the approach.

**Platform-Agnostic Vocabulary**

| Instead of... | Write... |
|---------------|----------|
| `VStack` / `HStack` | "vertical stack" / "horizontal stack" |
| `VStack with .pageBackground()` | "vertical stack within Page Background" |
| `.pageBackground(padding:)` value | "Page Background inner padding" |
| `ScrollView` | "scrollable area" |
| `struct MyScreen: View { let x: Type }` | Interface table (see Section 10) |
| `.toolbarButtons(dismiss: onDismiss)` | "Dismiss button, top-left placement" |
| `@State private var x: Type` | Screen State table (see Section 10) |
| `ForEach(items) { ... }` | "For each item in the collection" |
| `.cancellationAction` / `.bottomBar` | "top-left" / "bottom bar" |
| `Content VStack` / `Left VStack` | "Content column" / "Left column" |

**Think deeply about (screen concerns):**

| Concern | Example Questions |
|---------|-------------------|
| Component composition | Which components? In what order? |
| Layout structure | Portrait vs landscape arrangement? Single column or two? |
| Content | What text? Where does data come from? |
| Interactions | What's tappable? What happens on tap? |
| Callbacks | What closures does the parent provide? |
| Teletype offsets | What animation order for elements? |

**Trust the system for (not screen concerns):**

| Concern | Handled By | Don't Ask... |
|---------|------------|--------------|
| Device-specific sizing | `LayoutTheme` + layout views | "Should iPad have a max width?" |
| Font sizes | `FontSystem` | "What font size on iPhone SE?" |
| Colors | `DifficultyLevel` + `TextColorizer` | "What exact color values?" |
| CRT effects | `ContentView` | "How does barrel distortion work?" |
| Responsive breakpoints | `LayoutTheme.layoutType` | "At what width does layout change?" |

If a question is about *how this screen arranges its content*, think deeply. If a question is about *how the app handles device differences*, trust that the layout system already handles it — or note it as a potential layout system enhancement, not a screen spec decision.

### Wireframes Are the Source of Truth

**Important:** When writing a spec, the wireframe defines the intended behavior. If existing code in the codebase conflicts with the wireframe, **follow the wireframe**. The codebase may contain legacy implementations that predate the spec-driven approach.

Examples:
- Wireframe shows title parsed from markdown `# Heading` → spec should describe runtime parsing, even if current code uses a hardcoded mapping
- Wireframe shows a new layout pattern → spec should describe that pattern, not preserve old layout code
- Wireframe annotations override any assumptions from reading existing code

The spec captures what the screen **should** do, not what legacy code **currently** does.

## Before Writing a Spec

**Required reading:** Before planning or writing any screen spec, read [shared-screen-patterns/spec.md](./screens/shared-screen-patterns/spec.md). This file defines:

- Modal title and background formatting
- Indicator styling rules (menu items vs notes)
- Toolbar button configuration
- Stats entry format
- Color roles and text colorization rules
- Teletype animation patterns
- List alignment patterns
- ASCII box drawing characters

Understanding these shared patterns prevents duplicating rules in your spec and ensures consistency across screens.

**Read referenced component specs:** If the wireframe labels components (e.g., "Modal Title Component", "Page Background Component"), read the corresponding component specs in `specs/components/` before writing the screen spec. Component specs define:

- What parameters the component accepts
- Internal behavior and styling rules
- What the screen is responsible for vs. what the component handles

This prevents the screen spec from duplicating component behavior or making incorrect assumptions. For example, if Modal Title Component already handles the "(paused)" notification format, the screen spec should not re-specify that formatting.

## Spec File Structure

Every screen spec follows this structure. Use [help-menu-screen/spec.md](./screens/help-menu-screen/spec.md) as your template.

### 1. Header

```markdown
<!-- SCREEN: {screen-name}-screen -->
# {Screen Name} Screen

> One-sentence description of what this screen does.
```

### 2. Wireframes Section

Always include both wireframes with descriptive alt text:

```markdown
## Wireframes

### Portrait

![{Screen Name} - Portrait](./portrait.png)

### Landscape

![{Screen Name} - Landscape](./landscape.png)
```

### 3. Components Table

List ALL components this screen composes. Link to their specs.

```markdown
## Components

This screen composes the following components:

| Component       | Spec                                                                            | Instances                   |
| --------------- | ------------------------------------------------------------------------------- | --------------------------- |
| Modal Title     | [modal-title-component](../../components/modal-title-component/spec.md)         | 1                           |
| Section Title   | [section-title-component](../../components/section-title-component/spec.md)     | 1 (for "HELP TOPICS")       |
| ...             | ...                                                                             | ...                         |
```

**Common components available:**

| Component | When to Use | Spec Link |
|-----------|-------------|-----------|
| Modal Title | Every screen (title + level notification) | `components/modal-title-component/spec.md` |
| Section Title | Section headers like `# HELP TOPICS #` | `components/section-title-component/spec.md` |
| Notes | Instruction items with indicators | `components/notes-component/spec.md` |
| Page Background | Translucent container for content groups | `components/page-background-component/spec.md` |
| Toolbar Buttons | Native toolbar with dismiss/action buttons | `components/toolbar-buttons-component/spec.md` |
| Stats Entry | Stat rows like `LABEL => DATA` | `components/stats-entry-component/spec.md` |

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
| Modal Title | Screen title + level notification           |
| Content     | Vertical stack within Page Background       |

**Content column:**

1. Section Title: `# HELP TOPICS #`
2. Help Menu Items (8 rows)
3. Notes Component

**Alignment:**

| Container | Alignment | Reason |
| --------- | --------- | ------ |
| Content column | Center (default) | Centers the page background |
| Help Menu Items column | **Leading** | All `[>]` indicators form a straight left edge |
```

**Landscape example:**

```markdown
### Landscape

Two-column horizontal layout:

| Element      | Description                                        |
| ------------ | -------------------------------------------------- |
| Modal Title  | Screen title + level notification (full width)     |
| Left column  | Vertical stack within Page Background              |
| Right column | Vertical stack within Page Background              |

**Column group centering:** Both columns sit side-by-side as a centered group — they do NOT spread to fill the available width.
```

### 5. Spacing Section

Document ALL gaps between elements. Separate portrait and landscape if values differ.

```markdown
## Spacing

### Portrait

| Gap                                    | Value |
| -------------------------------------- | ----- |
| Modal Title to content column          | 16pt  |
| Page Background inner padding          | 20pt  |
| Section Title to first item            | 12pt  |
| Between list items                     | 8pt   |
```

### 6. Content Section

Document the actual content — text, data sources, static values.

```markdown
## Content

### Modal Title

- **Title:** `# BIT QUIZ 16 HELP #`
- **Notification:** `CURRENT LEVEL => {LEVEL-NAME} (paused)`

### Section Name

Describe what appears in each section. Include:
- Exact text strings (in backticks)
- Data sources (e.g., "from `container.level.difficultyLevel`")
- Any transformations (e.g., "uppercase", "padded to 22 chars")
```

### 7. Data Model Section (if applicable)

If the screen displays data from a model, document the model structure using a field table:

```markdown
### Data Model

**HelpMenuItem:**

| Field | Type | Description |
|-------|------|-------------|
| `id` | string, unique | Document identifier for navigation |
| `title` | string | Display title shown in menu |

**ID to Display Mapping:**

| Display Text | ID | Notes |
| ------------ | -- | ----- |
| HOW TO PLAY  | `how-to-play` | Maps to `how-to-play.md` |
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

**Dismiss button behavior:** The dismiss button always returns to the screen that presented the current screen. For example:
- Document Reader's dismiss → returns to Help Menu (which opened it)
- Help Menu's dismiss → returns to Game (which opened it)
- Level Chooser's dismiss → returns to Game (which opened it)

The screen doesn't know or care *where* it returns to — it simply calls `onDismiss()`, and the parent provides the navigation logic. This keeps screens decoupled from the navigation hierarchy.

### 9. Interaction Section

Document ALL tappable elements and their behaviors:

```markdown
## Interaction

| Action              | Behavior                                            |
| ------------------- | --------------------------------------------------- |
| Tap Help Menu Item  | Calls `onSelectItem(item)`, navigates to reader     |
| Tap Dismiss (X)     | Calls `onDismiss`, returns to game                  |
```

### 10. Screen Interface Section

Document the screen's inputs and outputs:

```markdown
### Screen Interface

**Inputs:**

| Parameter | Type | Description |
|-----------|------|-------------|
| (none for some screens, or data IDs for others) | | |

**Outputs (callbacks):**

| Event | Payload | Description |
|-------|---------|-------------|
| onSelectItem | item | Called when user taps a menu item |
| onDismiss | — | Called when user taps dismiss |

**Callback pattern:** The screen doesn't know where to navigate — it receives callbacks from its parent. The parent provides the navigation logic.
```

### 11. Animation Section

Document teletype offsets for each component:

```markdown
## Animation

### Teletype Offsets

Screen assigns starting offsets to each component:

| Component              | Element Count | Starting Offset |
| ---------------------- | ------------- | --------------- |
| Modal Title            | 2             | 1               |
| Section Title          | 1             | 3               |
| List Items (×8)        | 8             | 4               |
| Notes                  | 3             | 12              |

**Total elements:** 14

**Note:** Modal Title starts at offset 1 (not 0) to allow a brief pause before content appears.
```

### 12. Styling Section

Reference shared patterns — don't duplicate rules:

```markdown
## Styling

- Follows [Modal Background](../shared-screen-patterns/spec.md#modal-background)
- Follows [Text Colorization Rules](../shared-screen-patterns/spec.md#text-colorization-rules)
- Accent color: Inherited from current level
```

### 13. Accessibility Section

```markdown
## Accessibility

- Screen announced as "Bit Quiz 16 Help"
- List items are buttons with action hints ("Opens help document")
- Notes section provides context for UI symbols
```

### 14. Implementation Reference Section

Show the file location and key code patterns. This section is the **only place** for platform-specific code. It should also contain:
- Swift struct signature (or equivalent in target platform)
- Toolbar modifier chain
- Parent call-site example (how the parent wires callbacks)

```markdown
## Implementation Reference

- **File:** `Screens/HelpMenuScreen.swift`
- **Navigation:** `container.ui.navigateTo(.helpMenu)`
- **Dismiss:** `container.ui.dismissToMain()`

```swift
struct HelpMenuScreen: View {
    @Environment(\.layoutTheme) private var theme
    @Environment(\.gameContainer) private var container

    let onSelectItem: (HelpMenuItem) -> Void
    let onDismiss: () -> Void

    var body: some View {
        Group {
            if theme.isHorizontalLayout {
                landscapeLayout
            } else {
                portraitLayout
            }
        }
        .toolbarButtons(dismiss: onDismiss)
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

- Screen renders on top of persistent CRT background (no CRT code in this file)
- All list items use `[>]` indicator (vs Level Chooser which uses `[*]` for current level)
- The screen is structurally similar to Level Chooser but navigates to Document Reader instead
```

## Wireframe Annotations

Good wireframes include annotations that map UI elements to components. When reviewing wireframes, look for:

| Annotation Type | Example | Purpose |
|-----------------|---------|---------|
| Component labels | "Modal Title Component" | Identifies which reusable component to use |
| Data sources | "Document source passed from Help Menu" | Clarifies where data comes from |
| Behavioral notes | "Scrolling text should NOT receive CRT effects" | Captures non-obvious requirements |
| Element groupings | Rounded rectangles around content | Shows what's inside the Page Background container |

**Annotations are scoped to what they name.** When an annotation references specific elements (e.g., "the scrolling text view should not receive CRT effects"), it applies to exactly those elements. Unnamed elements follow their default behavior. Do not ask whether unnamed elements are also affected — they aren't.

## Common Pitfalls

### 1. Forgetting Landscape Layout

Every screen MUST specify both portrait AND landscape. Phone landscape uses different column arrangements than portrait.

### 2. Missing Alignment Specifications

Lists with indicators (`[>]`, `[*]`) MUST use leading alignment so indicators form a straight vertical line. See [List Alignment Patterns](./screens/shared-screen-patterns/spec.md#list-alignment-patterns).

### 3. Duplicating Shared Patterns

Don't copy-paste colorization rules or toolbar patterns into the spec. Reference [shared-screen-patterns/spec.md](./screens/shared-screen-patterns/spec.md) instead.

### 4. Mixing Screen and Component Concerns

- **Screen spec:** External spacing, layout, teletype offsets, callbacks
- **Component spec:** Internal behavior, internal spacing, text formatting

If you're describing internal component behavior in a screen spec, stop and create/reference a component spec instead.

### 5. Using Modal Code as Reference

The `Modals/` folder contains legacy implementations with embedded CRT effects and styling. **Do not use these as patterns.** Always reference `Screens/` implementations.

## Checklist Before Completing a Screen Spec

- [ ] Header has HTML comment `<!-- SCREEN: {name}-screen -->` for tooling
- [ ] Both wireframes embedded with proper alt text
- [ ] Components table links to all used component specs
- [ ] Layout section covers BOTH portrait AND landscape
- [ ] Alignment explicitly specified for all containers holding lists
- [ ] Spacing values documented for both orientations
- [ ] Content section has exact text strings in backticks
- [ ] Screen interface documented with inputs, outputs, and callback descriptions
- [ ] Teletype offsets table totals correctly
- [ ] Styling references shared patterns (no duplication)
- [ ] Implementation reference shows file location and key code
- [ ] No platform-specific code (Swift, Kotlin, etc.) outside Implementation Reference section
- [ ] Notes section captures any non-obvious requirements from wireframe annotations

## Reference Files

| File | Purpose |
|------|---------|
| [help-menu-screen/spec.md](./screens/help-menu-screen/spec.md) | Canonical example screen spec |
| [shared-screen-patterns/spec.md](./screens/shared-screen-patterns/spec.md) | Shared styling rules to reference |
| [screens/README.md](./screens/README.md) | Screen types and implementation guide |
| [component-guide.md](../doc/component-guide.md) | How to write component specs |

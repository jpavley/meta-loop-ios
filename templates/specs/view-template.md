<!-- SCREEN: screen-name -->
# Screen Name

> Brief description of the screen's purpose.

## Wireframes

### Portrait
![Portrait wireframe](./portrait.png)

### Landscape
![Landscape wireframe](./landscape.png)

### Tablet (optional)
![Tablet wireframe](./tablet.png)

## Layout Requirements

- **Structure:** Describe the overall layout (vertical stack, grid, etc.)
- **Key sections:** List the main areas of the screen
- **Spacing:** Note any important spacing rules

## UI Elements

| Element | Description | Styling |
|---------|-------------|---------|
| Title | Screen title at top | Modal Title Format (# TITLE #) |
| Content area | Main content | Primary color text |
| ... | ... | ... |

## Interactive Elements

| Element | Position | SF Symbol | Action | Visibility |
|---------|----------|-----------|--------|------------|
| Dismiss | Bottom toolbar | `xmark` | Returns to previous screen | Always |
| ... | ... | ... | ... | ... |

## Styling Rules

- Follows [Modal Title Format](../shared-screen-patterns/spec.md#modal-title-format)
- Follows [Modal Background](../shared-screen-patterns/spec.md#modal-background)
- Accent color: Inherited from current level

## Content Format

Describe any special text formatting rules:

- Stats format: `LABEL => DATA`
- Separators (`=>`, `#`, etc.) use secondary color
- Numeric values use accent color (digit inversion)

## Animation

- **Entry:** Teletype effect, elements appear sequentially
- **Exit:** Fade out or slide

## Implementation Reference

- **SwiftUI file:** `Views/Screens/ScreenNameScreen.swift`
- **Navigation:** `container.ui.navigateTo(.screenName)`
- **Dismiss:** `container.ui.dismissToMain()`

## Platform Variations

| Platform | Differences |
|----------|-------------|
| iPhone Portrait | Default layout |
| iPhone Landscape | Horizontal arrangement |
| iPad/Mac | Larger wireframe, same structure |

## Notes

Any additional implementation notes or design decisions.

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

```swift
struct ViewName: View {
    // Properties
    let onDismiss: () -> Void

    var body: some View {
        // Implementation
    }
}
```

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

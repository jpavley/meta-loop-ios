---
name: project-structure
description: Directory layout, file responsibilities, and Xcode integration for meta-loop projects
---

# Project Structure

How meta-loop artifacts fit into an iOS/SwiftUI Xcode project. Covers directory layout, who creates each file, and what belongs in the Xcode project navigator.

## Directory Layout

```
MyApp/                              # Git repo root
├── MyApp.xcodeproj                 # Xcode project (you create)
├── MyApp/                          # Swift source (you + AI create)
│   ├── MyAppApp.swift
│   ├── ContentView.swift
│   └── Views/
│       └── FeatureView.swift
├── MyAppTests/                     # Test source (you + AI create)
├── CLAUDE.md                       # AI agent file (ml-setup creates, you maintain)
├── PROJECT-NOTES.md                # Session notes (ml-setup creates, you maintain)
├── PROJECT-TODO.md                 # Task tracking (ml-setup creates, you maintain)
├── README.md                       # Project readme (ml-setup creates, you maintain)
├── .claude/                        # Claude Code config (install.sh creates)
│   ├── commands/                   # Slash commands
│   │   ├── ml-setup.md
│   │   ├── ml-wireframe.md
│   │   ├── ml-spec.md
│   │   ├── ml-impl.md
│   │   └── ml-retain.md
│   ├── skills/                     # Reference docs
│   │   ├── meta-loop-methodology/
│   │   │   ├── SKILL.md
│   │   │   └── meta-loop-diagram.png
│   │   ├── wireframe-design/
│   │   │   └── SKILL.md
│   │   ├── view-specifications/
│   │   │   └── SKILL.md
│   │   └── project-structure/
│   │       └── SKILL.md
│   └── settings.json               # MCP servers, permissions (you create)
├── specs/                          # Specifications (ml-setup creates dir)
│   └── views/                      # View specs
│       └── feature-name/           # One directory per feature
│           ├── *-wireframe.png     # You create (drawing tool, one or more)
│           ├── about-this-view.md  # You create (optional context)
│           ├── spec.md             # ml-spec generates
│           └── notes.md            # ml-spec generates, you + AI update
├── supporting-docs/                # App-level context (ml-setup creates dir)
│   └── about-this-app.md          # You create
└── doc/                            # Retained learnings (ml-retain creates dir)
    ├── SHARED-PATTERNS.md          # ml-retain generates (optional)
    └── DECISIONS.md                # ml-retain generates (optional)
```

## File Responsibility Matrix

| File / Directory | Created By | Maintained By | In Xcode Project? | Purpose |
|---|---|---|---|---|
| `MyApp.xcodeproj` | You (Xcode) | You / Xcode | — | Xcode project file |
| `MyApp/` (Swift source) | You + AI | You + AI | Yes | App source code |
| `MyAppTests/` | You + AI | You + AI | Yes | Test source code |
| `CLAUDE.md` | `/ml-setup` | You | No | AI agent context file |
| `PROJECT-NOTES.md` | `/ml-setup` | You | No | Session notes and observations |
| `PROJECT-TODO.md` | `/ml-setup` | You + AI | No | Task tracking |
| `README.md` | `/ml-setup` | You | No | Project readme |
| `.claude/commands/` | `install.sh` | Plugin updates | No | Slash command definitions |
| `.claude/skills/` | `install.sh` | Plugin updates | No | Reference skill documents |
| `.claude/settings.json` | You | You | No | MCP servers, permissions |
| `specs/views/` | `/ml-setup` | — | No | Parent directory for view specs |
| `specs/views/*/*-wireframe.png` | You | You | No | Hand-drawn wireframe images (screen and/or logic) |
| `specs/views/*/spec.md` | `/ml-spec` | AI (regenerated) | No | Generated view specification |
| `specs/views/*/notes.md` | `/ml-spec` | You + AI | No | Decisions and context per feature |
| `specs/views/*/about-this-view.md` | You | You | No | Optional extra context for a view |
| `supporting-docs/` | `/ml-setup` | — | No | Parent directory for app context |
| `supporting-docs/about-this-app.md` | You | You | No | App purpose, audience, features |
| `doc/` | `/ml-retain` | AI (on demand) | No | Retained learnings |
| `doc/SHARED-PATTERNS.md` | `/ml-retain` | AI | No | Cross-feature patterns (optional) |
| `doc/DECISIONS.md` | `/ml-retain` | AI | No | Architectural decisions (optional) |

## Xcode Integration

**Only Swift/asset source goes into the Xcode project navigator.** Everything else lives in the repo but outside Xcode's project references.

### In Xcode project (managed by Xcode)
- `MyApp/` — Swift source, assets, Info.plist
- `MyAppTests/` — Test source

### In repo, outside Xcode project
- `specs/` — Wireframes and specifications
- `supporting-docs/` — App context documents
- `doc/` — Retained learnings
- `.claude/` — Commands, skills, settings
- `CLAUDE.md`, `PROJECT-NOTES.md`, `PROJECT-TODO.md`

Xcode ignores files that aren't added to the project navigator. No special configuration is needed — just don't drag the meta-loop directories into Xcode.

## .gitignore Guidance

**Track all meta-loop artifacts in git.** Specs, wireframes, supporting docs, and retained learnings are the persistent value of the meta-loop process. Code can be regenerated from them; they cannot be regenerated from code.

Your `.gitignore` should exclude only standard Xcode/macOS build artifacts:

```
# Xcode
build/
DerivedData/
*.xcuserdata
*.xcworkspace/xcuserdata/

# macOS
.DS_Store

# Swift Package Manager
.build/
```

Do **not** gitignore:
- `specs/` — These are your source of truth
- `supporting-docs/` — Context that drives spec generation
- `doc/` — Retained learnings from past sessions
- `.claude/` — Commands and skills needed by every collaborator
- `CLAUDE.md` — Shared AI context for the project

## Directory Creation

| Directory | Created By | When |
|---|---|---|
| `.claude/commands/` | `install.sh` | Plugin installation |
| `.claude/skills/` | `install.sh` | Plugin installation |
| `specs/views/` | `/ml-setup` | Project scaffolding |
| `supporting-docs/` | `/ml-setup` | Project scaffolding |
| `doc/` | `/ml-retain` | First learning retention session |

You create feature subdirectories (e.g., `specs/views/bookmarks/`) manually when you save your wireframes.

## Optional Files

These files are not created by any command but can add useful context:

| File | Purpose | Who Reads It |
|---|---|---|
| `specs/views/*/about-this-view.md` | Extra context for a specific view (design rationale, edge cases) | `/ml-spec`, `/ml-impl` |
| `doc/SHARED-PATTERNS.md` | Patterns that apply across multiple features | `/ml-impl` via CLAUDE.md reference |
| `doc/DECISIONS.md` | Architectural decisions with rationale | `/ml-impl` via CLAUDE.md reference |

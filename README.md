# Meta-Loop iOS

*Draw, spec, code, learn, repeat*

AI-assisted iOS development methodology for high probability single-shot repeatability. Build features with AI coding agents using a structured wireframe → spec → implementation → learning retention workflow.

## The Problem

Traditional development with AI coding agents often results in:
- Multiple iterations to get things right
- Lost context between sessions
- Knowledge trapped in conversation history
- Inconsistent implementations

## The Solution

Meta-Loop inverts traditional software economics:

| Traditional | Meta-Loop |
|-------------|-----------|
| Code is expensive to write | Code is cheap to regenerate |
| Documentation often skipped | Documentation is the persistent value |
| Knowledge lives in developers' heads | Knowledge is externalized to docs |
| Iteration is costly | Iteration is nearly free |
| Spec is refined at the end | Spec (and wireframe) is refined after each step |

**Learning is preserved in the documentation, not in the code.**

## Commands

| Command | Argument | Purpose |
|---------|----------|---------|
| `/ml-wireframe` | `wireframe_path` | Review wireframe to verify AI understanding |
| `/ml-spec` | `wireframe_path` | Create specification from wireframe |
| `/ml-impl` | `spec_path` | Implement from specification |
| `/ml-retain` | — | Capture learnings before clearing context |

## Skills

Skills are reference documents the AI reads during command execution.

| Skill | Description |
|-------|-------------|
| [meta-loop-methodology](skills/meta-loop-methodology/SKILL.md) | Full development process theory and practical user guide |
| [wireframe-design](skills/wireframe-design/SKILL.md) | Tips for creating wireframes that drive accurate specs |
| [view-specifications](skills/view-specifications/SKILL.md) | Guide and template for writing view specification documents |

## The Flow

```
┌──────────────┐     ┌──────────────┐     ┌──────────────┐     ┌──────────────┐
│    Draw      │ ──▶ │   Create     │ ──▶ │  Implement   │ ──▶ │   Capture    │
│  Wireframe   │     │    Spec      │     │    Code      │     │  Learnings   │
│  (manual)    │     │  /ml-spec    │     │  /ml-impl    │     │  /ml-retain  │
└──────────────┘     └──────────────┘     └──────────────┘     └──────────────┘
       │                    │                    │                    │
       └────────────────────┴────────────────────┴────────────────────┘
                              Clear context & repeat
```

## The "Delete and Regenerate" Rule

**When something goes wrong, don't patch—delete and regenerate.**

1. Patches fix symptoms, not causes
2. The cause is unclear documentation
3. Fix the source (wireframe, spec, docs)
4. Regenerate from the improved source
5. Now anyone can reproduce it

## Example Workflows

### New Feature (full loop)

```bash
# 1. Draw your wireframe, save to specs/views/my-feature/wireframe.png

# 2. Verify the AI understands it
/ml-wireframe specs/views/my-feature/wireframe.png

# 3. Clear context, then generate the spec
/ml-spec specs/views/my-feature/wireframe.png

# 4. Clear context, then implement from spec
/ml-impl specs/views/my-feature/spec.md

# 5. Capture what you learned
/ml-retain
```

### Fixing a Deviation

```bash
# Implementation review failed — spec was unclear
# 1. Update the wireframe or supporting docs to clarify
# 2. Delete the bad spec and code
# 3. Regenerate
/ml-spec specs/views/my-feature/wireframe.png
/ml-impl specs/views/my-feature/spec.md
```

## Installation

### Option 1: Clone and install

```bash
# Clone the repo
git clone https://github.com/jpavley/meta-loop-ios.git

# From your project directory, run the install script
cd /path/to/your/project
/path/to/meta-loop-ios/install.sh
```

### Option 2: Manual installation

1. Copy `commands/*.md` to your project's `.claude/commands/` directory
2. Copy the `skills/` directory to your project's `.claude/skills/` directory

## Requirements

- Claude Code (or compatible AI coding agent)
- iOS/SwiftUI project
- Git for version control

## Project Structure

```
meta-loop-ios/
├── .claude-plugin/
│   └── plugin.json         # Plugin manifest
├── commands/               # Slash commands
│   ├── ml-wireframe.md
│   ├── ml-spec.md
│   ├── ml-impl.md
│   └── ml-retain.md
├── skills/                 # Reference skills
│   ├── meta-loop-methodology/
│   │   ├── SKILL.md
│   │   └── meta-loop-diagram.png
│   ├── wireframe-design/
│   │   └── SKILL.md
│   └── view-specifications/
│       └── SKILL.md
├── install.sh
└── README.md
```

## Contributing

Contributions are welcome! See [CONTRIBUTING.md](CONTRIBUTING.md) for guidelines.

## License

MIT License - see [LICENSE](LICENSE) for details.

## Acknowledgments

This methodology was developed while building Bit Quiz 16 an iOS educational game teaching binary number concepts.

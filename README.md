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

## The Four Commands

| Command | Purpose |
|---------|---------|
| `/ml-wireframe` | Review wireframe to verify AI understanding |
| `/ml-spec` | Create specification from wireframe |
| `/ml-impl` | Implement from specification |
| `/ml-retain` | Capture learnings before clearing context |

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
2. Copy `docs/*.md` to your project's `docs/meta-loop/` directory
3. Copy `templates/specs/view-template.md` to your `specs/views/` directory

## Getting Started

1. **Read the user guide**: [docs/meta-loop-user-guide.md](docs/meta-loop-user-guide.md)
2. **Understand the theory**: [docs/ml-development-process.md](docs/ml-development-process.md)
3. **Learn wireframe tips**: [docs/how-to-create-a-wireframe.md](docs/how-to-create-a-wireframe.md)

## Requirements

- Claude Code (or compatible AI coding agent)
- iOS/SwiftUI project
- Git for version control

## Project Structure

```
meta-loop-ios/
├── commands/           # Slash commands
│   ├── ml-wireframe.md
│   ├── ml-spec.md
│   ├── ml-impl.md
│   └── ml-retain.md
├── docs/               # Methodology documentation
│   ├── ml-development-process.md
│   ├── meta-loop-user-guide.md
│   ├── how-to-create-a-wireframe.md
│   └── how-to-write-a-view-spec.md
├── templates/          # Spec templates
│   └── specs/
│       └── view-template.md
├── install.sh          # Installation script
├── plugin.json         # Plugin manifest
└── README.md
```

## Contributing

Contributions are welcome! See [CONTRIBUTING.md](CONTRIBUTING.md) for guidelines.

## License

MIT License - see [LICENSE](LICENSE) for details.

## Acknowledgments

This methodology was developed while building [Bit Quiz 16]([https://github.com/jpavley/Card-Flip-Animation](https://apps.apple.com/us/app/bit-quiz-16/id1670026590)), an iOS educational game teaching binary number concepts.

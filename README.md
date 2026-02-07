# Meta-Loop iOS

>Draw, spec, code, learn, repeat

AI-assisted iOS development methodology for high probability single-shot repeatability. Build features with AI coding agents using a structured `wireframe → spec → implementation → learning retention` workflow.

**Before you start, read the [Meta-Loop Methodology](skills/meta-loop-methodology/SKILL.md).** It explains the full process, the thinking behind it, and how to get the most out of every command. The README gives you the overview — the methodology doc is the real manual.

## The Problem

Traditional development with AI coding agents often results in:

- Multiple iterations to get things right
- Lost context between sessions
- Knowledge trapped in conversation history
- Inconsistent implementations

## The Solution

Meta-Loop inverts traditional software economics:

| Traditional                          | Meta-Loop                                       |
| ------------------------------------ | ----------------------------------------------- |
| Code is expensive to write           | Code is cheap to regenerate                     |
| Documentation often skipped          | Documentation is the persistent value           |
| Knowledge lives in developers' heads | Knowledge is externalized to docs               |
| Iteration is costly                  | Iteration is nearly free                        |
| Spec is refined at the end           | Spec (and wireframe) is refined after each step |

**Learning is preserved in the documentation, not in the code.**

## Commands

| Command         | Argument         | Purpose                                     |
| --------------- | ---------------- | ------------------------------------------- |
| `/ml-setup`     | —                | Scaffold project for meta-loop workflow     |
| `/ml-wireframe` | `wireframe_path` | Review wireframe to verify AI understanding |
| `/ml-spec`      | `wireframe_path` | Create specification from wireframe         |
| `/ml-impl`      | `spec_path`      | Implement from specification                |
| `/ml-retain`    | —                | Capture learnings before clearing context   |

## Skills

Skills are reference documents the AI reads during command execution.

| Skill                                                          | Description                                                 |
| -------------------------------------------------------------- | ----------------------------------------------------------- |
| [meta-loop-methodology](skills/meta-loop-methodology/SKILL.md) | Full development process theory and practical user guide    |
| [wireframe-design](skills/wireframe-design/SKILL.md)           | Tips for creating wireframes that drive accurate specs      |
| [view-specifications](skills/view-specifications/SKILL.md)     | Guide and template for writing view specification documents |
| [project-structure](skills/project-structure/SKILL.md)         | Directory layout, file responsibilities, and Xcode integration |

## The Flow

![Meta Loop Diagram](skills/meta-loop-methodology/meta-loop-diagram.png)

The process has **three nested loops** plus a learning retention step. Each loop has a review gate where you confirm the output before advancing. If a review fails, you delete and regenerate rather than patch.

### Three Loops

1. **Wireframe Loop** — Draw a wireframe (manual, on paper or in a drawing app), then use `/ml-wireframe` to verify the AI understands it. If the review fails, revise the wireframe and re-verify.
2. **Specification Loop** — Use `/ml-spec` to generate a view spec from the wireframe. Review the spec against the wireframe. If the review fails, fix the wireframe or supporting docs and regenerate the spec.
3. **Implementation Loop** — Use `/ml-impl` to generate code from the spec. Review the implementation against the spec. If the review fails, fix the spec (or the wireframe behind it) and regenerate the code.

After all three loops pass, use `/ml-retain` to capture learnings before clearing context.

### Four Modes

Each step runs in a specific mode that determines who is acting:

| Mode         | Color (in diagram) | Meaning                                       |
| ------------ | ------------------ | --------------------------------------------- |
| Human Action | White              | You do the work (draw, review, confirm)       |
| Plan Mode    | Pink               | AI plans an approach for your approval        |
| Ask Mode     | Yellow             | AI answers questions or analyzes artifacts    |
| Agent Mode   | Blue               | AI generates output (spec, code) autonomously |

### Review Gates and Feedback

- Each loop ends with a human review. Passing advances to the next loop; failing sends you back to regenerate.
- **Cross-loop feedback:** A spec review failure can send you back to the wireframe. An implementation review failure can send you back to the spec or the wireframe.
- **"Complete" gates:** You explicitly confirm completion before advancing. Context is cleared between loops so each phase starts fresh.

For the full methodology, see [meta-loop-methodology](skills/meta-loop-methodology/SKILL.md).

## The "Delete and Regenerate" Rule

**When something goes wrong, don't patch—delete and regenerate.**

1. Patches fix symptoms, not causes
2. The cause is unclear documentation
3. Fix the source (wireframe, spec, docs)
4. Regenerate from the improved source
5. Now anyone can reproduce it

## Example Workflows

### Project Setup

```bash
# 1. Install the plugin (from your project root)
/path/to/meta-loop-ios/install.sh

# 2. Scaffold project directories and starter files
/ml-setup

# 3. Follow the action items printed by /ml-setup
```

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

## Your Project Layout

After installing meta-loop and running `/ml-setup`, your Xcode project will look like this:

```
MyApp/
├── MyApp.xcodeproj              # You create
├── MyApp/                       # Swift source (in Xcode project)
├── MyAppTests/                  # Test source (in Xcode project)
├── CLAUDE.md                    # ml-setup creates, you maintain
├── .claude/                     # install.sh creates
│   ├── commands/                #   slash commands
│   └── skills/                  #   reference docs
├── specs/views/                 # ml-setup creates
│   └── feature-name/
│       ├── wireframe.png        #   you create (drawing tool)
│       └── spec.md              #   ml-spec generates
├── supporting-docs/             # ml-setup creates
│   └── about-this-app.md       #   you create
└── doc/                         # ml-retain creates on first use
```

Only Swift source and assets belong in the Xcode project navigator. Everything else stays in the repo but outside Xcode. For the full layout, file responsibility matrix, and `.gitignore` guidance, see [project-structure](skills/project-structure/SKILL.md).

## Plugin Repository Structure

```ascii
meta-loop-ios/
├── .claude-plugin/
│   └── plugin.json         # Plugin manifest
├── commands/               # Slash commands
│   ├── ml-setup.md
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

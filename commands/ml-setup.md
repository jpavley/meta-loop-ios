---
description: Scaffold project directories and starter files for the meta-loop workflow
---

# Meta-Loop: Project Setup

Scaffold the directory structure and starter files needed for the meta-loop workflow.

**Mode:** Agent Mode (creates files and directories)

## Prerequisites

This command prepares a project to use the Meta-Loop process defined in `skills/meta-loop-methodology/SKILL.md`.

Run this once after installing the meta-loop plugin. It is safe to re-run — existing files are never overwritten.

---

## Phase 1: Check Prerequisites

1. **Verify git repo root:**
   - Check that `.git/` exists in the current directory
   - If not, stop and tell the developer to run from the project root

2. **Check for installed skills:**
   - Check that `.claude/skills/` exists and contains meta-loop skill directories
   - If missing, warn: "Meta-loop skills not found. Run install.sh first, then re-run /ml-setup."

3. **Check for installed commands:**
   - Check that `.claude/commands/` exists and contains `ml-wireframe.md`, `ml-spec.md`, `ml-impl.md`, `ml-retain.md`
   - If missing, warn: "Meta-loop commands not found. Run install.sh first, then re-run /ml-setup."

If any prerequisite fails, stop and print the warning. Do not continue to Phase 2.

---

## Phase 2: Create Directory Structure

Create these directories if they don't already exist. Skip and note any that already exist.

- `specs/views/`
- `supporting-docs/`

---

## Phase 3: Create Starter Files

**Important: Never overwrite an existing file.** If a file already exists, skip it and note that it was skipped in the summary.

### 3.1 `CLAUDE.md`

Only create if `CLAUDE.md` does not exist in the project root.

```markdown
# [App Name]

[Brief description of what this app does.]

## Build Commands

| Command                                                                                                      | Action              |
| ------------------------------------------------------------------------------------------------------------ | ------------------- |
| `xcodebuild -scheme [Scheme] -sdk iphonesimulator build`                                                     | Build for simulator |
| `xcodebuild test -scheme [Scheme] -sdk iphonesimulator -destination 'platform=iOS Simulator,name=iPhone 16'` | Run tests           |

## Project Structure

```
[Describe your project's file organization here]
```

## Key Patterns

[Document project-specific patterns, conventions, and architectural decisions here.]

## Meta-Loop Commands

| Command         | Purpose                                     |
| --------------- | ------------------------------------------- |
| `/ml-setup`     | Scaffold project for meta-loop workflow     |
| `/ml-wireframe` | Review wireframe to verify AI understanding |
| `/ml-spec`      | Create specification from wireframe         |
| `/ml-impl`      | Implement from specification                |
| `/ml-retain`    | Capture learnings before clearing context   |

## Meta-Loop Skills

Reference docs are in `.claude/skills/`:
- `meta-loop-methodology/` — Process theory and user guide
- `wireframe-design/` — Wireframe creation tips
- `view-specifications/` — Spec writing guide and template
- `project-structure/` — Directory layout and file responsibilities
```

### 3.2 `PROJECT-NOTES.md`

Only create if `PROJECT-NOTES.md` does not exist in the project root.

```markdown
# Project Notes

**Started:** [today's date]
**Purpose:** [What is this project for?]

## Notes

[Capture observations, decisions, and context that don't belong in CLAUDE.md or specs.]
```

### 3.3 `PROJECT-TODO.md`

Only create if `PROJECT-TODO.md` does not exist in the project root.

```markdown
# Project TODO

## Next Up

- [ ] Create `supporting-docs/about-this-app.md` describing the app, its audience, and key features
- [ ] Draw first wireframe and save to `specs/views/`
- [ ] Run `/ml-wireframe` to verify AI understanding
- [ ] Fill in CLAUDE.md with project-specific details

## Completed

[Move completed items here with date.]
```

### 3.4 `README.md`

Only create if `README.md` does not exist in the project root.

```markdown
# [Project Name]

[Brief description of the project.]

## Getting Started

[Setup instructions.]

## Architecture

[High-level architecture overview.]

## License

[License info.]
```

---

## Phase 4: Print Setup Summary and Next Steps

Print the following structured summary:

````
## Setup Summary

### Created
- [List each directory and file that was created]

### Skipped (already existed)
- [List each directory and file that was skipped]

---

## Recommended Plugins

### Axiom Plugin
The [axiom plugin](https://github.com/anthropics/knowledge-work-plugins/tree/main/axiom)
provides general-purpose development commands (code review, refactoring, etc.)
that complement the meta-loop workflow. Install it alongside meta-loop for a
complete AI development setup.

---

## Recommended MCP Server

### XcodeBuildMCP
[XcodeBuildMCP](https://github.com/cameroncooke/XcodeBuildMCP) lets Claude build,
test, and run your Xcode project directly. Install it so `/ml-impl` can build and
verify code without leaving the conversation.

**Quick install (Homebrew):**
1. `brew install xcodebuildmcp/tap/xcodebuildmcp`
2. Add to `.claude/settings.json`:
   ```json
   {
     "mcpServers": {
       "xcodebuild": {
         "command": "xcrun",
         "args": ["xcodebuildmcp"]
       }
     }
   }
   ```

---

## Action Items

1. **Create `supporting-docs/about-this-app.md`** — Describe what your app does,
   who it's for, and its key features. This document is read by `/ml-spec` and
   `/ml-impl` to understand context. Include: app purpose, target audience,
   main features, and any design principles or constraints.

2. **Fill in `CLAUDE.md`** — Replace the placeholders with your actual project
   details (app name, build commands, project structure).

3. **Review the project layout** — See `.claude/skills/project-structure/SKILL.md`
   for the full directory layout, file responsibility matrix, and what belongs
   in the Xcode project navigator vs. the repo.

4. **Restart Claude Code** to activate any newly installed slash commands.

---

## What to Do Next

1. Draw a wireframe for your first feature (paper, iPad, any drawing tool)
2. Save it to `specs/views/{feature-name}/wireframe.png`
3. Run `/ml-wireframe specs/views/{feature-name}/wireframe.png`
````

---

## Key Constraints

- **Idempotent:** Safe to re-run at any time. Never overwrites existing files.
- **Agent Mode only:** No plan/ask mode needed — the action is deterministic.
- **No doc copying:** Skills and commands are already installed by install.sh. This command only creates project-level scaffolding.
- **Minimal starter content:** Files contain useful structure but not verbose boilerplate. The developer fills in the details.

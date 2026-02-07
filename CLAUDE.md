# Meta-Loop iOS Plugin

A Claude Code plugin providing a structured AI-assisted iOS development methodology. This is a **documentation-only** project — no Swift code, no Xcode project, no build step.

## Project Structure

```
.claude-plugin/plugin.json   # Minimal manifest (Anthropic standard)
commands/                    # Slash commands (installed to .claude/commands/)
  ml-setup.md               # Step 0: Scaffold project for meta-loop workflow
  ml-wireframe.md            # Step 1: Review wireframe
  ml-spec.md                 # Step 2: Create spec from wireframe
  ml-impl.md                 # Step 3: Implement from spec
  ml-retain.md               # Step 4: Capture learnings
skills/                      # Reference docs (installed to .claude/skills/)
  meta-loop-methodology/     # Process theory + user guide
  wireframe-design/          # Wireframe creation tips
  view-specifications/       # Spec writing guide + template
install.sh                   # Copies commands + skills into a target project
```

## Standards

- Follows [Anthropic knowledge-work-plugins](https://github.com/anthropics/knowledge-work-plugins) format
- Commands use `argument-hint:` (not `arguments:`) in YAML frontmatter
- Skills use YAML frontmatter with `name:` and `description:`
- All doc references in commands point to `skills/.../SKILL.md`

## Conventions

- Command files are markdown with YAML frontmatter
- Skill files are named `SKILL.md` inside a named directory
- The plugin manifest at `.claude-plugin/plugin.json` is minimal (name, version, description, author)
- `install.sh` copies commands to `.claude/commands/` and the skills tree to `.claude/skills/`
- Keep examples generic (not tied to a specific app)
- Keep content platform-agnostic in requirement sections; platform-specific code goes only in Implementation Reference sections

## Repo Info

- **Remote:** github.com:jpavley/meta-loop-ios.git
- **Branch:** main
- **License:** MIT
- **Author:** John Pavley

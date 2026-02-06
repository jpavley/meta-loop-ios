# Meta-Loop iOS Plugin - Manual Test Plans

> Three human-executable test plans to verify that the meta-loop commands and skills work correctly.

## Recommended Wireframe

For all tests, draw a **"Bookmark List" view** -- a simple screen showing a list of saved bookmarks. It exercises all major spec sections:

- **Header** with title ("Bookmarks")
- **List** of items (title + URL, variable count)
- **Interactive elements** (tap item to open, swipe to delete)
- **Empty state** ("No bookmarks yet")
- **Dismiss button** (X, top-left)
- Portrait only is fine (annotate: "same layout in landscape, just wider")

Draw it on paper or iPad at whiteboard quality. Annotate: label each element, mark the list as scrollable, note the empty state, note that tapping an item calls a callback. Save as `specs/views/bookmark-list/wireframe.png`.

---

## Test Plan 1: New Empty Xcode iOS Project (Full Pipeline)

**Goal:** Verify install.sh works on a fresh project and the full 4-command loop produces a building app.

### Setup

1. Create a new Xcode iOS App project (SwiftUI, name: "BookmarkTest")
   - **Expect:** Clean project, builds and runs
2. `cd BookmarkTest && git init && git add -A && git commit -m "init"`
   - **Expect:** Clean git repo
3. Create a minimal `CLAUDE.md` with project name, build command (`xcodebuild -scheme BookmarkTest -sdk iphonesimulator`), and file structure
   - **Expect:** File exists at root

### Installation

4. Run `bash /path/to/meta-loop-ios/install.sh` from project root
   - **Expect:** See "Installation complete!", `.claude/commands/` has 4 `.md` files, `.claude/skills/` has 3 directories
5. Verify commands appear: open Claude Code, type `/ml-` and check autocomplete
   - **Expect:** All 4 commands (`ml-wireframe`, `ml-spec`, `ml-impl`, `ml-retain`) appear

### Wireframe Phase

6. Create `specs/views/bookmark-list/` dir and place your wireframe PNG there
   - **Expect:** Wireframe file exists
7. Run `/ml-wireframe specs/views/bookmark-list/wireframe.png`
   - **Expect:** AI describes the layout, identifies elements, asks specific clarifying questions (or none if wireframe is clear), gives PASS/FAIL verdict. A `notes.md` file is created in the spec directory on PASS
8. Answer any clarifying questions. If FAIL, update wireframe and rerun step 7
   - **Expect:** Eventually PASS
9. Clear context (`/clear` or restart Claude Code)
   - **Expect:** Fresh session

### Specification Phase

10. Run `/ml-spec specs/views/bookmark-list/wireframe.png`
    - **Expect:** AI enters plan mode, proposes spec structure, waits for approval
11. Approve the plan
    - **Expect:** AI writes `specs/views/bookmark-list/spec.md`, copies wireframe, runs self-review. PASS with platform-agnostic requirement sections and Swift code only in Implementation Reference
12. Verify `spec.md` exists and has all template sections (Layout, Child Views, Interactive Elements, View Interface, Implementation Reference, etc.)
    - **Expect:** All sections present, no Swift code outside Implementation Reference
13. Clear context
    - **Expect:** Fresh session

### Implementation Phase

14. Run `/ml-impl specs/views/bookmark-list/spec.md`
    - **Expect:** AI enters plan mode, proposes files to create/modify, waits for approval
15. Approve the plan
    - **Expect:** AI creates Swift files, attempts build, runs self-review
16. Verify the project builds (`Cmd+B` in Xcode or `xcodebuild`)
    - **Expect:** Build succeeds with no errors
17. Clear context
    - **Expect:** Fresh session

### Learning Retention Phase

18. Run `/ml-retain`
    - **Expect:** AI reviews git diff, proposes CLAUDE.md/TODO.md updates, commits
19. Verify git log shows the commit, CLAUDE.md was updated
    - **Expect:** Commit exists, docs updated

### Pass Criteria

- [ ] All 4 commands ran without errors
- [ ] Spec is platform-agnostic above Implementation Reference
- [ ] Project builds
- [ ] `notes.md` carries decisions across phases

---

## Test Plan 2: Existing Project (Mid-Stream Integration)

**Goal:** Verify the plugin integrates into a project that already has code, patterns, and a CLAUDE.md with existing conventions.

### Setup

Use any existing iOS project with at least a few Swift files and an established CLAUDE.md (or create one documenting existing patterns like shared colors, navigation patterns, existing views).

### Installation

1. Run `bash /path/to/meta-loop-ios/install.sh` from existing project root
   - **Expect:** "Installation complete!", no conflicts with existing `.claude/` content
2. Verify existing `.claude/commands/` files (if any) are preserved
   - **Expect:** Only `ml-*` files added, nothing overwritten
3. Add a Meta-Loop Commands table to existing CLAUDE.md (as install.sh suggests)
   - **Expect:** Table added without disrupting existing content

### Wireframe Phase

4. Place wireframe at `specs/views/bookmark-list/wireframe.png`
   - **Expect:** File exists
5. Run `/ml-wireframe specs/views/bookmark-list/wireframe.png`
   - **Expect:** AI references **existing codebase patterns** from CLAUDE.md in its analysis (e.g., "I see your project uses NavigationStack" or "matching your existing theme system"). This is the key differentiator from Test 1

### Specification Phase

6. On PASS, clear context and run `/ml-spec specs/views/bookmark-list/wireframe.png`
   - **Expect:** Spec plan references existing views/patterns. The spec's Implementation Reference should use the project's actual file paths and naming conventions
7. Verify spec references existing components
   - **Expect:** Child Views section links to real existing views where applicable. Implementation Reference uses project's actual directory structure

### Implementation Phase

8. Clear context and run `/ml-impl specs/views/bookmark-list/spec.md`
   - **Expect:** Implementation plan modifies existing files (e.g., adding navigation routes) in addition to creating new ones
9. Verify build succeeds and new code follows existing patterns
   - **Expect:** Builds, uses same styling/naming conventions as rest of project

### Learning Retention Phase

10. Run `/ml-retain`
    - **Expect:** Updates existing TODO.md and CLAUDE.md (appends, doesn't overwrite)

### Pass Criteria

- [ ] AI correctly reads and references existing codebase patterns at every phase
- [ ] Spec and implementation integrate with (not ignore) existing code
- [ ] No existing files are damaged

---

## Test Plan 3: Error Paths and Delete-Regenerate Loop

**Goal:** Verify the "delete and regenerate" philosophy works -- that when a review FAILs, updating source docs and rerunning produces a better result.

### Setup

1. Install plugin into either test project (new or existing)
   - **Expect:** Working installation

### Wireframe FAIL Path

2. Create a **deliberately ambiguous** wireframe: draw the bookmark list but omit annotations -- no labels, no interaction notes, no empty state, no data source info
   - **Expect:** Bare wireframe PNG saved
3. Run `/ml-wireframe specs/views/bookmark-list/wireframe.png`
   - **Expect:** AI should identify ambiguities and give **FAIL** verdict with specific issues listed (e.g., "unclear what tapping a row does", "no empty state shown")
4. Verify FAIL output lists specific improvements, not generic advice
   - **Expect:** Issues are actionable (e.g., "annotate what happens on row tap")
5. Update the wireframe: add annotations addressing each listed issue
   - **Expect:** Improved wireframe saved
6. Re-run `/ml-wireframe specs/views/bookmark-list/wireframe.png`
   - **Expect:** Should now PASS (or identify fewer issues). Repeat until PASS

### Spec Violation Detection

7. Clear context, run `/ml-spec` and get a spec
   - **Expect:** Spec created
8. **Intentionally sabotage:** Edit the spec to add SwiftUI code (`VStack`, `@State`) into the Layout section (above Implementation Reference)
   - **Expect:** Spec now violates the platform-agnostic rule
9. Ask Claude to review the spec: "Review this spec against the view-specifications skill for code placement violations"
   - **Expect:** AI should identify the platform-specific code in requirement sections
10. Delete the sabotaged spec: `rm specs/views/bookmark-list/spec.md`
    - **Expect:** Spec deleted
11. Re-run `/ml-spec specs/views/bookmark-list/wireframe.png`
    - **Expect:** Fresh spec generated without the violations. Requirement sections are clean

### Implementation Deviation Detection

12. Clear context, run `/ml-impl`, let it build
    - **Expect:** Implementation created
13. **Intentionally break:** Add a feature not in the spec (e.g., a search bar) to a generated Swift file
    - **Expect:** Code now deviates from spec
14. Ask Claude to review: "Review this implementation against the spec"
    - **Expect:** AI should identify the search bar as a deviation ("feature not in spec")
15. Delete the implementation (revert files), re-run `/ml-impl`
    - **Expect:** Clean implementation without the extra feature

### Pass Criteria

- [ ] FAIL verdicts are specific and actionable
- [ ] The delete-and-regenerate cycle produces clean artifacts
- [ ] AI catches spec violations (platform code in requirements)
- [ ] AI catches implementation deviations (features not in spec)

---

## Summary

- **Test Plan 1 (New Project)** -- starts from an empty Xcode project. Validates the full happy-path pipeline from install through retain.
- **Test Plan 2 (Existing Project)** -- starts from a project with code and patterns. Validates integration with an existing codebase and pattern awareness.
- **Test Plan 3 (Error Paths)** -- starts from either project. Validates FAIL verdicts, the delete-regenerate loop, and violation detection.

All three tests use the same **Bookmark List** wireframe, which keeps the feature simple while exercising every spec section. The wireframe starts deliberately bare in Test 3 to validate the error path.

#!/bin/bash
# Meta-Loop iOS - Manual Installation Script
#
# This script installs the Meta-Loop commands into your project.
# Run from your project's root directory.

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo "Meta-Loop iOS - Installation Script"
echo "===================================="
echo ""

# Check if we're in a git repo
if [ ! -d ".git" ]; then
    echo -e "${RED}Error: Not in a git repository root.${NC}"
    echo "Please run this script from your project's root directory."
    exit 1
fi

# Define the source (this repo)
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Define target directories
COMMANDS_DIR=".claude/commands"
DOCS_DIR="docs/meta-loop"

# Create directories
echo "Creating directories..."
mkdir -p "$COMMANDS_DIR"
mkdir -p "$DOCS_DIR"

# Copy commands
echo "Installing commands..."
cp "$SCRIPT_DIR/commands/ml-wireframe.md" "$COMMANDS_DIR/"
cp "$SCRIPT_DIR/commands/ml-spec.md" "$COMMANDS_DIR/"
cp "$SCRIPT_DIR/commands/ml-impl.md" "$COMMANDS_DIR/"
cp "$SCRIPT_DIR/commands/ml-retain.md" "$COMMANDS_DIR/"

# Copy docs
echo "Installing documentation..."
cp "$SCRIPT_DIR/docs/ml-development-process.md" "$DOCS_DIR/"
cp "$SCRIPT_DIR/docs/meta-loop-user-guide.md" "$DOCS_DIR/"
cp "$SCRIPT_DIR/docs/how-to-create-a-wireframe.md" "$DOCS_DIR/"
cp "$SCRIPT_DIR/docs/how-to-write-a-view-spec.md" "$DOCS_DIR/"

# Copy diagram
if [ -f "$SCRIPT_DIR/docs/meta-loop-diagram.png" ]; then
    cp "$SCRIPT_DIR/docs/meta-loop-diagram.png" "$DOCS_DIR/"
fi

# Copy template
echo "Installing templates..."
mkdir -p "specs/views"
cp "$SCRIPT_DIR/templates/specs/view-template.md" "specs/views/"

echo ""
echo -e "${GREEN}Installation complete!${NC}"
echo ""
echo "Installed files:"
echo "  - $COMMANDS_DIR/ml-wireframe.md"
echo "  - $COMMANDS_DIR/ml-spec.md"
echo "  - $COMMANDS_DIR/ml-impl.md"
echo "  - $COMMANDS_DIR/ml-retain.md"
echo "  - $DOCS_DIR/ (documentation)"
echo "  - specs/views/view-template.md"
echo ""
echo -e "${YELLOW}Next steps:${NC}"
echo "1. Add the following to your CLAUDE.md:"
echo ""
echo "   ## Meta-Loop Commands"
echo "   | Command | Purpose |"
echo "   |---------|---------|"
echo "   | /ml-wireframe | Review wireframe before spec creation |"
echo "   | /ml-spec | Create specification from wireframe |"
echo "   | /ml-impl | Implement from specification |"
echo "   | /ml-retain | Capture learnings before clearing context |"
echo ""
echo "2. Read docs/meta-loop/meta-loop-user-guide.md to get started"
echo ""

#!/bin/bash
# Claude Code Status Line Setup Script (Unix/Linux/macOS)
# Uses ccstatusline tool for rich status line display

set -e

echo "=== Claude Code Status Line Setup ==="

# Check if npm is installed
if ! command -v npm &> /dev/null; then
    echo "Error: npm is not installed. Please install Node.js and npm first."
    echo "Visit https://nodejs.org/ to download and install"
    exit 1
fi

echo "✓ npm is installed"

# Install or update ccstatusline
echo "Installing/updating ccstatusline..."
npm install -g ccstatusline

echo "✓ ccstatusline installed successfully"

# Test ccstatusline
echo "Testing ccstatusline..."
if echo '{"model": {"display_name": "test"}}' | ccstatusline &> /dev/null; then
    echo "✓ ccstatusline test passed"
else
    echo "✗ ccstatusline test failed"
    exit 1
fi

# Determine configuration file path
CLAUDE_CONFIG="$HOME/.claude/settings.json"
if [ ! -f "$CLAUDE_CONFIG" ]; then
    echo "Creating Claude Code configuration file..."
    mkdir -p "$(dirname "$CLAUDE_CONFIG")"
    cat > "$CLAUDE_CONFIG" << 'EOF'
{
  "language": "中文",
  "statusLine": {
    "type": "command",
    "command": "ccstatusline"
  }
}
EOF
    echo "✓ Created new configuration file"
else
    echo "Updating existing configuration file..."
    # Use temporary file for JSON update
    TEMP_FILE=$(mktemp)
    if python3 -c "
import json, sys
try:
    with open('$CLAUDE_CONFIG', 'r', encoding='utf-8') as f:
        config = json.load(f)
except:
    config = {}

config['statusLine'] = {'type': 'command', 'command': 'ccstatusline'}

with open('$TEMP_FILE', 'w', encoding='utf-8') as f:
    json.dump(config, f, indent=2, ensure_ascii=False)
" 2>/dev/null; then
        mv "$TEMP_FILE" "$CLAUDE_CONFIG"
        echo "✓ Configuration file updated"
    elif python -c "
import json, sys
try:
    with open('$CLAUDE_CONFIG', 'r', encoding='utf-8') as f:
        config = json.load(f)
except:
    config = {}

config['statusLine'] = {'type': 'command', 'command': 'ccstatusline'}

with open('$TEMP_FILE', 'w', encoding='utf-8') as f:
    json.dump(config, f, indent=2, ensure_ascii=False)
" 2>/dev/null; then
        mv "$TEMP_FILE" "$CLAUDE_CONFIG"
        echo "✓ Configuration file updated (using Python 2)"
    else
        echo "⚠ Could not update JSON automatically, please manually add to $CLAUDE_CONFIG:"
        echo '  "statusLine": {'
        echo '    "type": "command",'
        echo '    "command": "ccstatusline"'
        echo '  }'
        rm -f "$TEMP_FILE"
    fi
fi

echo ""
echo "=== Setup Complete ==="
echo "1. Completely exit and restart Claude Code"
echo "2. Status line will show model info, Git status, etc."
echo ""
echo "Customization options:"
echo "- ccstatusline config: ~/.config/ccstatusline/settings.json"
echo "- Enable Powerline style: Set powerline.enabled to true"
echo "- Choose colors suitable for your terminal theme (dark/light)"
echo "- More options: Refer to ccstatusline documentation"

# Show current status line example
echo ""
echo "Status line example:"
echo '{"model": {"display_name": "Claude 3.5 Sonnet"}, "context_window": {"remaining_percentage": 85}}' | ccstatusline
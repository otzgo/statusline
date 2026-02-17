#!/bin/bash
# Claude Code Status Line Test Script (Unix/Linux/macOS)
# Tests ccstatusline configuration and displays sample output

echo "=== Claude Code Status Line Test ==="

# Test 1: Check ccstatusline installation
echo -e "\nTest 1: Checking ccstatusline installation..."
if command -v ccstatusline &> /dev/null; then
    echo "✓ ccstatusline is installed"
else
    echo "✗ ccstatusline is not installed"
    echo "  Run: npm install -g ccstatusline"
fi

# Test 2: Test ccstatusline execution
echo -e "\nTest 2: Testing ccstatusline execution..."
TEST_INPUT='{"model": {"display_name": "Claude 3.5 Sonnet"}, "context_window": {"remaining_percentage": 75}}'
if echo "$TEST_INPUT" | ccstatusline 2>&1; then
    echo "✓ ccstatusline executes successfully"
else
    echo "✗ ccstatusline execution failed"
fi

# Test 3: Check Claude Code configuration
echo -e "\nTest 3: Checking Claude Code configuration..."
CLAUDE_CONFIG="$HOME/.claude/settings.json"
if [ -f "$CLAUDE_CONFIG" ]; then
    if python3 -c "
import json, sys
try:
    with open('$CLAUDE_CONFIG', 'r') as f:
        config = json.load(f)
    if 'statusLine' in config and config['statusLine'].get('command') == 'ccstatusline':
        print('OK: Claude Code is configured to use ccstatusline')
    else:
        print('WARNING: Claude Code is not configured to use ccstatusline')
        print('Update $CLAUDE_CONFIG with:')
        print('  \"statusLine\": {\"type\": \"command\", \"command\": \"ccstatusline\"}')
except Exception as e:
    print(f'WARNING: Could not parse Claude Code configuration: {e}')
" 2>/dev/null; then
        # Output is handled in python script
        :
    else
        echo "⚠ Could not check Claude Code configuration"
    fi
else
    echo "⚠ Claude Code configuration file not found"
    echo "  Create $CLAUDE_CONFIG with:"
    echo '  {"statusLine": {"type": "command", "command": "ccstatusline"}}'
fi

# Test 4: Check ccstatusline configuration
echo -e "\nTest 4: Checking ccstatusline configuration..."
CCSTATUSLINE_CONFIG="$HOME/.config/ccstatusline/settings.json"
if [ -f "$CCSTATUSLINE_CONFIG" ]; then
    if python3 -c "
import json, sys
try:
    with open('$CCSTATUSLINE_CONFIG', 'r') as f:
        config = json.load(f)
    print('✓ ccstatusline configuration found')
    if config.get('powerline', {}).get('enabled', False):
        print('  Powerline style: Enabled')
    else:
        print('  Powerline style: Disabled (default)')
except Exception as e:
    print(f'⚠ Could not parse ccstatusline configuration: {e}')
" 2>/dev/null; then
        # Output is handled in python script
        :
    else
        echo "⚠ Could not check ccstatusline configuration"
    fi
else
    echo "ℹ ccstatusline using default configuration"
    echo "  Default config will be created on first run"
fi

# Display sample outputs
echo -e "\n=== Sample Status Line Outputs ==="

echo -e "\n1. Basic output:"
echo '{"model": {"display_name": "Claude 3.5 Sonnet"}}' | ccstatusline

echo -e "\n2. With context usage:"
echo '{"model": {"display_name": "Claude 3.5 Sonnet"}, "context_window": {"remaining_percentage": 65}}' | ccstatusline

echo -e "\n3. With Git info (simulated):"
echo "   (Git info comes from actual repository status)"

echo -e "\n=== Test Complete ==="
echo "If all tests pass, restart Claude Code to see the status line."
echo "For issues, run: ./scripts/setup-unix.sh"
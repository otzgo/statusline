# Claude Code Status Line Configuration Guide

## Overview

This guide provides detailed configuration options for Claude Code's status line using the `ccstatusline` tool. The status line displays useful information including:
- Current Claude model in use
- Context window usage percentage
- Git branch and file change status
- Custom modules and formatting

## Basic Configuration

### Claude Code Configuration

Add or update the following in your Claude Code configuration file:

**Global configuration** (`~/.claude/settings.json` on Unix/Linux/macOS, `%USERPROFILE%\.claude\settings.json` on Windows):
```json
{
  "statusLine": {
    "type": "command",
    "command": "ccstatusline"
  }
}
```

**Project-specific configuration** (`.claude/settings.json` in project directory):
```json
{
  "statusLine": {
    "type": "command",
    "command": "ccstatusline"
  }
}
```

### ccstatusline Configuration

ccstatusline automatically creates a default configuration file on first run:

**Default location**:
- Unix/Linux/macOS: `~/.config/ccstatusline/settings.json`
- Windows: `%USERPROFILE%\.config\ccstatusline\settings.json`

## Module Configuration

### Available Modules

ccstatusline supports the following modules:

| Module ID | Type | Description | Default Color |
|-----------|------|-------------|---------------|
| `model` | `model` | Shows current Claude model name | `cyan` |
| `context-length` | `context-length` | Shows context window usage percentage | `brightBlack` |
| `git-branch` | `git-branch` | Shows current Git branch | `magenta` |
| `git-changes` | `git-changes` | Shows Git file changes (+, - counts) | `yellow` |
| `separator` | `separator` | Separator between modules | (inherits) |

### Default Layout

The default configuration displays modules in this order:
1. `model` - Current model name
2. `separator` - Separator
3. `context-length` - Context usage (if data available)
4. `separator` - Separator
5. `git-branch` - Git branch (if in Git repository)
6. `separator` - Separator
7. `git-changes` - Git file changes (if in Git repository)

### Customizing Module Order

Edit the `lines` array in `settings.json` to rearrange modules:

```json
{
  "lines": [
    [
      {
        "id": "1",
        "type": "git-branch",
        "color": "magenta"
      },
      {
        "id": "2",
        "type": "separator"
      },
      {
        "id": "3",
        "type": "model",
        "color": "cyan"
      },
      {
        "id": "4",
        "type": "separator"
      },
      {
        "id": "5",
        "type": "context-length",
        "color": "brightBlack"
      }
    ]
  ]
}
```

## Color Customization

### Theme-Aware Color Selection

When selecting colors for your status line, always consider the user's terminal theme:

**For Dark Themes** (dark background):
- Avoid: `black`, `brightBlack` text colors
- Recommended: Light text with colored backgrounds
- Example: `color: "white", background: "blue"`

**For Light Themes** (light background):
- Avoid: `white`, `brightWhite` text colors
- Recommended: Dark text with light/colored backgrounds
- Example: `color: "black", background: "cyan"`

**Universal Recommendations**:
- Use high-contrast combinations for readability
- Test color choices with both dark and light themes
- When uncertain, ask the user about their theme preference

### Available Colors

ccstatusline supports standard terminal colors:

**Basic colors**: `black`, `red`, `green`, `yellow`, `blue`, `magenta`, `cyan`, `white`

**Bright colors**: `brightBlack`, `brightRed`, `brightGreen`, `brightYellow`, `brightBlue`, `brightMagenta`, `brightCyan`, `brightWhite`

### Setting Module Colors

Set the `color` property for each module:

```json
{
  "id": "1",
  "type": "model",
  "color": "brightCyan"
}
```

### Powerline Colors

When Powerline style is enabled, colors work differently:

```json
{
  "powerline": {
    "enabled": true,
    "separators": [""],
    "separatorInvertBackground": [false]
  },
  "lines": [
    [
      {
        "id": "1",
        "type": "model",
        "color": "white",
        "background": "blue"
      }
    ]
  ]
}
```

## Powerline Style

### Enabling Powerline

Set `powerline.enabled` to `true`:

```json
{
  "powerline": {
    "enabled": true,
    "separators": [""],
    "separatorInvertBackground": [false],
    "startCaps": [],
    "endCaps": [],
    "autoAlign": false
  }
}
```

### Powerline Options

- `separators`: Array of separator characters (Powerline glyphs)
- `separatorInvertBackground`: Whether to invert background colors at separators
- `startCaps`: Starting cap characters
- `endCaps`: Ending cap characters
- `autoAlign`: Automatically align to terminal width

### Powerline Glyphs

Common Powerline glyphs (requires Powerline-patched font):
- `""` - Right-pointing triangle
- `""` - Left-pointing triangle
- `""` - Rounded right
- `""` - Rounded left

## Advanced Configuration

### Multiple Lines

ccstatusline supports up to 3 lines of status information:

```json
{
  "lines": [
    [ /* Line 1 modules */ ],
    [ /* Line 2 modules */ ],
    [ /* Line 3 modules */ ]
  ]
}
```

### Flex Mode

Control how status line behaves when terminal width changes:

```json
{
  "flexMode": "full-minus-40",  // Options: "off", "full", "full-minus-40"
  "compactThreshold": 60        // Width threshold for compact mode
}
```

- `"off"`: Fixed width
- `"full"`: Use full terminal width
- `"full-minus-40"`: Use terminal width minus 40 columns

### Compact Mode

When terminal width is below `compactThreshold`, ccstatusline switches to compact mode (fewer modules shown).

### Color Level

Set color support level:

```json
{
  "colorLevel": 2  // 0: no color, 1: 16 colors, 2: 256 colors, 3: true color
}
```

## Platform-Specific Configuration

### Windows Specific

**Font requirements**: For Powerline glyphs, install a Powerline-patched font like:
- Cascadia Code PL
- Fira Code Retina
- JetBrains Mono

**PowerShell execution**: Ensure execution policy allows script execution:
```powershell
Set-ExecutionPolicy RemoteSigned -Scope CurrentUser
```

### Unix/Linux/macOS Specific

**Font installation**:
```bash
# Install Powerline fonts on Ubuntu/Debian
sudo apt-get install fonts-powerline

# Install Powerline fonts on macOS
brew tap homebrew/cask-fonts
brew install --cask font-fira-code-nerd-font
```

## Environment Variables

ccstatusline respects these environment variables:

- `CCSTATUSLINE_CONFIG`: Override configuration file path
- `NO_COLOR`: Disable colors when set to any value
- `CLICOLOR`: Enable colors (set to `1`)
- `CLICOLOR_FORCE`: Force colors (set to `1`)

## Validation

Test your configuration:

```bash
# Test with sample input
echo '{"model": {"display_name": "test"}}' | ccstatusline

# Validate configuration file
ccstatusline --validate  # If supported
```

## Migration from Custom Commands

If migrating from custom status line commands:

1. **Remove custom commands** from Claude Code configuration
2. **Install ccstatusline**: `npm install -g ccstatusline`
3. **Test configuration**: Use test scripts in `scripts/` directory
4. **Customize appearance**: Edit ccstatusline configuration as needed

## Troubleshooting Configuration

### Common Issues

1. **No output**: Check npm installation and ccstatusline PATH
2. **Wrong colors**: Verify terminal color support and colorLevel setting
3. **Missing Powerline glyphs**: Install Powerline-patched font
4. **Git info missing**: Ensure in Git repository and Git is installed
5. **Configuration not loading**: Check file permissions and paths

### Debug Mode

Enable debug output by setting environment variable:

```bash
export CCSTATUSLINE_DEBUG=1
# Then test
echo '{"model": {"display_name": "test"}}' | ccstatusline
```

## Examples

### Basic Configuration
```json
{
  "lines": [[{"id":"1","type":"model","color":"cyan"}]],
  "powerline": {"enabled": false}
}
```

### Powerline Style
```json
{
  "lines": [[
    {"id":"1","type":"model","color":"white","background":"blue"},
    {"id":"2","type":"separator"},
    {"id":"3","type":"git-branch","color":"black","background":"magenta"}
  ]],
  "powerline": {
    "enabled": true,
    "separators": [""],
    "separatorInvertBackground": [false]
  }
}
```

### Minimal Configuration
```json
{
  "lines": [[
    {"id":"1","type":"model","color":"cyan"},
    {"id":"2","type":"separator"},
    {"id":"3","type":"git-branch","color":"magenta"}
  ]],
  "flexMode": "off"
}
```
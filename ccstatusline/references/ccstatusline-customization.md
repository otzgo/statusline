# ccstatusline Customization Guide

## Overview

ccstatusline is highly customizable. This guide covers advanced customization options beyond basic configuration.

## Configuration File Structure

### Complete Configuration Schema

```json
{
  "version": 3,
  "lines": [
    [
      {
        "id": "unique-id-1",
        "type": "module-type",
        "color": "foreground-color",
        "background": "background-color",
        "bold": false,
        "italic": false,
        "underline": false
      }
    ],
    [],
    []
  ],
  "flexMode": "full-minus-40",
  "compactThreshold": 60,
  "colorLevel": 2,
  "inheritSeparatorColors": false,
  "globalBold": false,
  "powerline": {
    "enabled": false,
    "separators": [""],
    "separatorInvertBackground": [false],
    "startCaps": [],
    "endCaps": [],
    "autoAlign": false
  }
}
```

## Module Types

### Model Module

Displays current Claude model name.

**Properties**:
- `type`: `"model"`
- `color`: Text color (default: `"cyan"`)
- `format`: Custom format string (optional)

**Example**:
```json
{
  "id": "model-display",
  "type": "model",
  "color": "brightCyan",
  "bold": true
}
```

### Context Length Module

Displays context window usage percentage.

**Properties**:
- `type`: `"context-length"`
- `color`: Text color (default: `"brightBlack"`)
- `format`: Format string with `{percent}` placeholder

**Example**:
```json
{
  "id": "context-info",
  "type": "context-length",
  "color": "yellow",
  "format": "Context: {percent}%"
}
```

### Git Branch Module

Displays current Git branch.

**Properties**:
- `type`: `"git-branch"`
- `color`: Text color (default: `"magenta"`)
- `icon`: Custom icon before branch name
- `maxLength`: Maximum branch name length

**Example**:
```json
{
  "id": "git-branch-display",
  "type": "git-branch",
  "color": "green",
  "icon": "⎇ ",
  "maxLength": 20
}
```

### Git Changes Module

Displays Git file change counts.

**Properties**:
- `type`: `"git-changes"`
- `color`: Text color (default: `"yellow"`)
- `format`: Format string with `{added}`, `{modified}`, `{deleted}` placeholders

**Example**:
```json
{
  "id": "git-changes-display",
  "type": "git-changes",
  "color": "brightYellow",
  "format": "(+{added},~{modified},-{deleted})"
}
```

### Separator Module

Separates other modules.

**Properties**:
- `type`: `"separator"`
- `color`: Inherits from previous module if `inheritSeparatorColors` is true
- `text`: Custom separator text (default: space)

**Example**:
```json
{
  "id": "separator-1",
  "type": "separator",
  "text": " | "
}
```

### Custom Text Module

Display static text (if supported).

**Properties**:
- `type`: `"text"`
- `text`: Text to display
- `color`: Text color

**Example**:
```json
{
  "id": "custom-text",
  "type": "text",
  "text": "Claude Code",
  "color": "blue"
}
```

## Color System

### Theme Compatibility Considerations

When designing status line color schemes, always prioritize readability across different terminal themes:

**Dark Theme Guidelines**:
- Text colors: Prefer `white`, `brightWhite`, `cyan`, `yellow`, `green`
- Background colors: Darker shades work well (`blue`, `magenta`, `cyan`)
- Avoid: `black` or `brightBlack` text on dark backgrounds

**Light Theme Guidelines**:
- Text colors: Prefer `black`, `brightBlack`, `blue`, `magenta`, `red`
- Background colors: Lighter shades or colored backgrounds
- Avoid: `white` or `brightWhite` text on light backgrounds

**Best Practices**:
1. **Ask First**: If the user's theme is unknown, ask before applying styles
2. **Test Both**: Always test color schemes with dark and light themes
3. **High Contrast**: Ensure sufficient contrast between text and background
4. **Fallback Options**: Provide alternative color schemes for different themes

**Example Theme-Aware Configuration**:
```json
{
  "id": "theme-aware-model",
  "type": "model",
  "color": "white",        // Good for dark themes
  "background": "blue",
  "bold": true
}
```

### Color Formats

1. **Named colors**: `"red"`, `"green"`, `"blue"`, etc.
2. **Bright named colors**: `"brightRed"`, `"brightGreen"`, etc.
3. **256-color codes**: Numbers 0-255
4. **RGB values**: `"#RRGGBB"` format (requires colorLevel 3)

### Background Colors

Set `background` property for modules:
```json
{
  "id": "module-with-bg",
  "type": "model",
  "color": "white",
  "background": "blue"
}
```

### Color Inheritance

When `inheritSeparatorColors` is `true`, separators inherit colors from previous module.

## Powerline Customization

### Basic Powerline Setup

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

### Multiple Separator Styles

Use different separators for different transitions:

```json
{
  "powerline": {
    "enabled": true,
    "separators": ["", "", ""],
    "separatorInvertBackground": [false, true, false]
  }
}
```

### Caps and Endings

Add start and end caps for complete Powerline bar:

```json
{
  "powerline": {
    "enabled": true,
    "separators": [""],
    "startCaps": [""],
    "endCaps": [""]
  }
}
```

### Auto Alignment

Automatically align status line to terminal width:

```json
{
  "powerline": {
    "enabled": true,
    "autoAlign": true
  }
}
```

## Layout Options

### Multiple Lines

Use up to 3 lines for complex layouts:

```json
{
  "lines": [
    [
      {"id": "l1-1", "type": "model", "color": "cyan"},
      {"id": "l1-2", "type": "separator"},
      {"id": "l1-3", "type": "git-branch", "color": "magenta"}
    ],
    [
      {"id": "l2-1", "type": "context-length", "color": "yellow"},
      {"id": "l2-2", "type": "separator"},
      {"id": "l2-3", "type": "git-changes", "color": "brightYellow"}
    ],
    []  // Empty third line
  ]
}
```

### Flex Modes

Control how status line responds to terminal width:

```json
{
  "flexMode": "full-minus-40",  // Options: "off", "full", "full-minus-40"
  "compactThreshold": 60
}
```

- `"off"`: Fixed width, may truncate
- `"full"`: Use all available width
- `"full-minus-40"`: Leave 40 columns for content

### Compact Mode

When terminal width < `compactThreshold`, switch to compact mode (fewer modules).

## Text Formatting

### Bold, Italic, Underline

Apply text styles to modules:

```json
{
  "id": "styled-module",
  "type": "model",
  "color": "cyan",
  "bold": true,
  "italic": false,
  "underline": true
}
```

### Global Formatting

Apply styles to all modules:

```json
{
  "globalBold": true,
  "inheritSeparatorColors": true
}
```

### Custom Icons and Symbols

Use Unicode symbols or custom icons:

```json
{
  "id": "git-with-icon",
  "type": "git-branch",
  "color": "magenta",
  "icon": " "  // Git icon
}
```

Common icons:
- `"⎇ "` - Branch symbol
- `" "` - Git logo
- `" "` - Nerd Font Git icon
- `" "` - Terminal icon

## Advanced Examples

### Professional Theme

```json
{
  "version": 3,
  "lines": [
    [
      {
        "id": "1",
        "type": "model",
        "color": "white",
        "background": "blue",
        "bold": true
      },
      {
        "id": "2",
        "type": "separator"
      },
      {
        "id": "3",
        "type": "context-length",
        "color": "black",
        "background": "cyan"
      },
      {
        "id": "4",
        "type": "separator"
      },
      {
        "id": "5",
        "type": "git-branch",
        "color": "white",
        "background": "magenta",
        "icon": " "
      },
      {
        "id": "6",
        "type": "separator"
      },
      {
        "id": "7",
        "type": "git-changes",
        "color": "black",
        "background": "yellow"
      }
    ]
  ],
  "flexMode": "full-minus-40",
  "compactThreshold": 80,
  "colorLevel": 2,
  "inheritSeparatorColors": false,
  "globalBold": false,
  "powerline": {
    "enabled": true,
    "separators": [""],
    "separatorInvertBackground": [false],
    "startCaps": [],
    "endCaps": [],
    "autoAlign": true
  }
}
```

### Minimalist Theme

```json
{
  "version": 3,
  "lines": [
    [
      {
        "id": "1",
        "type": "model",
        "color": "brightBlack",
        "bold": true
      },
      {
        "id": "2",
        "type": "separator",
        "text": " | "
      },
      {
        "id": "3",
        "type": "git-branch",
        "color": "green"
      }
    ]
  ],
  "flexMode": "off",
  "compactThreshold": 60,
  "colorLevel": 1,
  "inheritSeparatorColors": true,
  "globalBold": false,
  "powerline": {
    "enabled": false
  }
}
```

### Colorful Theme

```json
{
  "version": 3,
  "lines": [
    [
      {
        "id": "1",
        "type": "model",
        "color": "#FF6B6B",
        "bold": true
      },
      {
        "id": "2",
        "type": "separator",
        "text": " ❯ "
      },
      {
        "id": "3",
        "type": "context-length",
        "color": "#4ECDC4"
      },
      {
        "id": "4",
        "type": "separator",
        "text": " ❯ "
      },
      {
        "id": "5",
        "type": "git-branch",
        "color": "#FFD166",
        "icon": "🌿 "
      },
      {
        "id": "6",
        "type": "separator",
        "text": " ❯ "
      },
      {
        "id": "7",
        "type": "git-changes",
        "color": "#06D6A0"
      }
    ]
  ],
  "flexMode": "full",
  "compactThreshold": 60,
  "colorLevel": 3,
  "inheritSeparatorColors": false,
  "globalBold": false,
  "powerline": {
    "enabled": false
  }
}
```

## Platform-Specific Customization

### Windows Optimization

```json
{
  "lines": [[
    {
      "id": "1",
      "type": "model",
      "color": "brightCyan",
      "bold": true
    }
  ]],
  "colorLevel": 1,  // Windows often has basic color support
  "powerline": {
    "enabled": false  // Disable unless Powerline font installed
  }
}
```

### macOS Optimization

```json
{
  "lines": [[
    {
      "id": "1",
      "type": "model",
      "color": "cyan"
    },
    {
      "id": "2",
      "type": "separator",
      "text": " · "
    },
    {
      "id": "3",
      "type": "git-branch",
      "color": "magenta",
      "icon": "🌱 "
    }
  ]],
  "colorLevel": 2,
  "powerline": {
    "enabled": true,
    "separators": [""]
  }
}
```

### Linux Optimization

```json
{
  "lines": [[
    {
      "id": "1",
      "type": "model",
      "color": "brightBlue",
      "bold": true
    },
    {
      "id": "2",
      "type": "separator"
    },
    {
      "id": "3",
      "type": "git-branch",
      "color": "brightMagenta"
    },
    {
      "id": "4",
      "type": "separator"
    },
    {
      "id": "5",
      "type": "git-changes",
      "color": "brightYellow"
    }
  ]],
  "colorLevel": 2,
  "powerline": {
    "enabled": true,
    "separators": [""],
    "autoAlign": true
  }
}
```

## Dynamic Configuration

### Conditional Formatting

Some modules support conditional formatting based on values:

```json
{
  "id": "context-warning",
  "type": "context-length",
  "color": {
    "default": "green",
    "warning": "yellow",     // When percent < 30
    "critical": "red"        // When percent < 10
  }
}
```

### Environment-Based Configuration

Use different configurations based on environment:

```json
{
  "lines": [[
    {
      "id": "1",
      "type": "model",
      "color": "cyan"
    },
    {
      "id": "2",
      "type": "separator"
    },
    {
      "id": "3",
      "type": "text",
      "text": "ENV: " + (process.env.NODE_ENV || "development"),
      "color": "yellow"
    }
  ]]
}
```

## Performance Optimization

### Simplify for Performance

```json
{
  "lines": [[
    {
      "id": "1",
      "type": "model",
      "color": "cyan"
    }
  ]],
  "flexMode": "off",
  "powerline": {
    "enabled": false
  }
}
```

### Disable Expensive Modules

Remove or disable modules that require significant computation:

```json
{
  "lines": [[
    {
      "id": "1",
      "type": "model",
      "color": "cyan"
    }
    // Removed git modules for performance
  ]]
}
```

## Migration and Compatibility

### Upgrading Configuration

When ccstatusline updates, check for:
- New module types
- Changed property names
- Deprecated features
- Version number changes

### Backward Compatibility

Keep a backup of working configuration:
```bash
cp ~/.config/ccstatusline/settings.json ~/.config/ccstatusline/settings.json.backup
```

### Testing Changes

Test configuration changes incrementally:
```bash
# Test with sample input
echo '{"model": {"display_name": "test"}}' | ccstatusline

# Compare output
diff <(echo '{"model": {"display_name": "test"}}' | ccstatusline) expected-output.txt
```

## Community Themes

Check ccstatusline documentation or GitHub repository for community-contributed themes that can be used as starting points for customization.
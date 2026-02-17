# Claude Code Status Line Skill

**Language / 语言:** [中文](README.md)

---

This skill provides configuration and customization guidance for Claude Code's status line, using the `ccstatusline` tool to display model information, Git status, context usage, and other useful information.

## Purpose

Use this skill when:
- Claude Code status line shows raw text (e.g., `"\u@\h:\w\$(git branch...)"`) instead of parsed values
- Status line doesn't show any information
- You want to install and configure `ccstatusline` for better status line display
- You need to customize status line appearance (Powerline style, colors, modules)
- You encounter platform-specific issues with status line configuration

## Installation

Install this skill with the following command:

```bash
npx skills add https://github.com/otzgo/statusline
```

GitHub repository: https://github.com/otzgo/statusline

## Usage

In Claude Code, you can use this skill by:

```
/claude-code-statusline
```

Or use the skill's functionality through the skill invocation interface. After installation, the skill will provide guidance and suggestions for status line configuration.

---

**Language / 语言:** [中文](README.md)
# Claude Code Status Line Skill

**Language / 语言:** [English](#english) | [中文](#中文)

---

<a name="english"></a>
## English Version

### Claude Code Status Line Skill

This skill provides configuration and customization guidance for Claude Code's status line, using the `ccstatusline` tool to display model information, Git status, context usage, and other useful information.

### Purpose

Use this skill when:
- Claude Code status line shows raw text (e.g., `"\u@\h:\w\$(git branch...)"`) instead of parsed values
- Status line doesn't show any information
- You want to install and configure `ccstatusline` for better status line display
- You need to customize status line appearance (Powerline style, colors, modules)
- You encounter platform-specific issues with status line configuration

### Installation

Install this skill with the following command:

```bash
npx skills add https://github.com/otzgo/statusline
```

GitHub repository: https://github.com/otzgo/statusline

### Usage

In Claude Code, you can use this skill by:

```
/claude-code-statusline
```

Or use the skill's functionality through the skill invocation interface. After installation, the skill will provide guidance and suggestions for status line configuration.

---

<a name="中文"></a>
## 中文版本

### Claude Code Status Line Skill

这个 skill 提供了 Claude Code 状态行的配置和自定义指南，使用 `ccstatusline` 工具来显示模型信息、Git 状态、上下文使用情况等有用信息。

### 用途

当您遇到以下情况时，可以使用此 skill：
- Claude Code 状态行显示原始文本（如 `"\u@\h:\w\$(git branch...)"`）而不是解析后的值
- 状态行不显示任何信息
- 想要安装和配置 `ccstatusline` 以获得更好的状态行显示效果
- 需要自定义状态行外观（Powerline 样式、颜色、模块）
- 遇到状态行配置的平台特定问题

### 安装

通过以下命令安装此 skill：

```bash
npx skills add https://github.com/otzgo/statusline
```

GitHub 仓库地址：https://github.com/otzgo/statusline

### 使用

在 Claude Code 中，您可以通过以下方式使用此 skill：

```
/claude-code-statusline
```

或通过技能调用接口使用此 skill 的功能。安装后，skill 将提供状态行配置的指导和建议。

---

**Language / 语言:** [English](#english) | [中文](#中文)
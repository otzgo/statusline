# Claude Code Status Line Skill

**Language / 语言:** [English](README.en-US.md)

---

这个 skill 提供了 Claude Code 状态行的配置和自定义指南，使用 `ccstatusline` 工具来显示模型信息、Git 状态、上下文使用情况等有用信息。

## 用途

当您遇到以下情况时，可以使用此 skill：
- Claude Code 状态行显示原始文本（如 `"\u@\h:\w\$(git branch...)"`）而不是解析后的值
- 状态行不显示任何信息
- 想要安装和配置 `ccstatusline` 以获得更好的状态行显示效果
- 需要自定义状态行外观（Powerline 样式、颜色、模块）
- 遇到状态行配置的平台特定问题

## 安装

通过以下命令安装此 skill：

```bash
npx skills add https://github.com/otzgo/statusline
```

GitHub 仓库地址：https://github.com/otzgo/statusline

## 使用

在 Claude Code 中，您可以通过以下方式使用此 skill：

```
/claude-code-statusline
```

或通过技能调用接口使用此 skill 的功能。安装后，skill 将提供状态行配置的指导和建议。

---

**Language / 语言:** [English](README.en-US.md)
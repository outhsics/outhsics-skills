# 🔄 Cursor 到 Claude Code 聊天记录迁移工具

<div align="center">

**无缝迁移 Cursor/Codex 聊天记录到 Claude Code**

[![Stars](https://img.shields.io/github/stars/outhsics/outhsics-skills?style=social)](https://github.com/outhsics/outhsics-skills)
[![License](https://img.shields.io/github/license/outhsics/outhsics-skills)](LICENSE)
[![Claude Code](https://img.shields.io/badge/Claude_Code-Supported-red)](https://claude.ai/code)

[English](./README.md) | [中文文档](./README.zh.md)

</div>

---

## ✨ 功能特点

- 🎯 **一键导出** - 自动从 Cursor 导出所有聊天记录
- 📊 **智能选择** - 交互式 workspace 选择
- 📝 **可读摘要** - 生成人类可读的对话摘要
- 🔍 **可搜索** - 过滤和搜索历史对话
- 🚀 **继续对话** - 在 Claude Code 中继续之前的讨论
- 💾 **多 workspace 支持** - 支持多个 Cursor workspace

## 🎬 演示

```
🔍 正在扫描 Cursor 工作区...

📋 发现 34 个有聊天记录的 workspace:

   [0] 4b4f51c0f722ba75d9bcebbbfd4c5718
       文件夹: my-project
       最后修改: 2026-02-07 11:16

   [1] d4b15159f3324442f159f374139390d8
       文件夹: another-project
       最后修改: 2025-06-28 11:09

👉 输入 workspace 编号: 0

✅ 已选择: 4b4f51c0f722ba75d9bcebbbfd4c5718
📂 导出中: 277 个提问, 100 个回答
✅ 导出完成!
```

## 📦 安装

### 方法 1: 通过 Claude Code 插件市场（推荐）

```
/plugin marketplace add outhsics/outhsics-skills
```

### 方法 2: 手动安装

```bash
git clone https://github.com/outhsics/outhsics-skills.git ~/.claude/skills/outhsics-skills
```

## 🚀 使用方法

### 在 Claude Code 中

直接输入：

```
/load-codex-chat
```

或使用自然语言：

```
"帮我加载 Codex 聊天记录"
"加载我的 Cursor 聊天历史"
"导入 Codex 对话记录"
```

### 命令行

```bash
~/.claude/skills/outhsics-skills/load-codex-chat/load-chat.sh
```

## 📖 使用示例

### 1. 查看最近的对话

```bash
cat ~/codex_chat_summary.txt
```

### 2. 继续之前的讨论

在 Claude Code 中：

```
"读取聊天记录，继续我们关于 Vue.js 的讨论"
```

### 3. 搜索特定话题

```bash
cat ~/codex_chat_prompts.json | \
  jq -r '.[] | select(.text | test("permission"; "i")) | .text'
```

### 4. 分析对话主题

```bash
cat ~/codex_chat_prompts.json | \
  jq -r '.[].text' | \
  grep -oE '\b[a-zA-Z]{4,}\b' | \
  sort | uniq -c | sort -rn | head -20
```

## 📁 导出内容

| 文件 | 说明 | 格式 |
|------|------|------|
| `~/codex_chat_prompts.json` | 你的提问记录 | JSON 数组 |
| `~/codex_chat_generations.json` | AI 回答记录 | JSON 数组 |
| `~/codex_chat_summary.txt` | 可读摘要（最近 10 条） | 纯文本 |

## 🛠️ 系统要求

- **macOS**（特定于 Cursor 数据位置）
- **sqlite3** - 命令行 SQLite 工具
- **jq** - JSON 处理工具

安装依赖：

```bash
brew install sqlite3 jq
```

## 🎯 适用场景

### ✅ 非常适合

- 从 Cursor 迁移到 Claude Code
- 备份 AI 对话记录
- 搜索历史代码讨论
- 继续被打断的工作
- 分析你的编程模式

### ❌ 不适合

- 工具间的实时同步
- 编辑 Cursor 聊天记录
- 跨平台迁移（仅支持 macOS）

## 🔧 工作原理

1. **扫描** Cursor workspace 目录
2. **查找** 包含聊天历史的 SQLite 数据库
3. **提取** prompts 和 generations 表
4. **导出** 为 JSON 和摘要格式
5. **加载** 到 Claude Code 上下文

## 🤝 贡献

欢迎贡献！特别需要：

- Windows/Linux 支持
- 其他 AI 工具集成
- GUI 界面
- 性能优化

## 📊 统计

- **支持平台:** macOS
- **支持工具:** Cursor, Codex
- **导出格式:** JSON, TXT
- **许可证:** MIT

## 🐛 故障排除

### 问题: "找不到 Cursor workspace"

**解决:** 确保你至少使用过一次 Cursor 的 AI 聊天功能。

### 问题: "sqlite3: command not found"

**解决:** 安装 sqlite3：
```bash
brew install sqlite3
```

### 问题: "导出的文件是空的"

**解决:** 选中的 workspace 可能没有聊天记录，尝试选择另一个 workspace。

## 📝 许可证

MIT License - 自由用于个人和商业项目。

## 🌟 如果这个工具对你有帮助，请给它一个星标！

## 📮 联系方式

- **作者:** [@outhsics](https://github.com/outhsics)
- **问题反馈:** [GitHub Issues](https://github.com/outhsics/outhsics-skills/issues)
- **讨论:** [GitHub Discussions](https://github.com/outhsics/outhsics-skills/discussions)

---

<div align="center">

**为 Claude Code 社区用 ❤️ 制作**

[⬆ 返回顶部](#-cursor-到-claude-code-聊天记录迁移工具)

</div>

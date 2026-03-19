# 🔄 Cursor to Claude Code Chat Migration Tool

<div align="center">

**Seamlessly migrate your Cursor/Codex chat history to Claude Code**

[![Stars](https://img.shields.io/github/stars/outhsics/outhsics-skills?style=social)](https://github.com/outhsics/outhsics-skills)
[![License](https://img.shields.io/github/license/outhsics/outhsics-skills)](LICENSE)
[![Claude Code](https://img.shields.io/badge/Claude_Code-Supported-red)](https://claude.ai/code)

[English](./README.md) | [中文文档](./README.zh.md)

</div>

---

## ✨ Features

- 🎯 **One-click Export** - Automatically export all chat history from Cursor
- 📊 **Smart Selection** - Interactive workspace selection
- 📝 **Readable Summaries** - Generate human-readable conversation summaries
- 🔍 **Searchable** - Filter and search through historical conversations
- 🚀 **Continue Conversations** - Pick up where you left off in Claude Code
- 💾 **Multiple Workspaces** - Support for multiple Cursor workspaces

## 🎬 Demo

```
🔍 Scanning for Cursor workspaces with chat history...

📋 Found 34 workspace(s) with chat history:

   [0] 4b4f51c0f722ba75d9bcebbbfd4c5718
       Folder: my-project
       Last modified: 2026-02-07 11:16

   [1] d4b15159f3324442f159f374139390d8
       Folder: another-project
       Last modified: 2025-06-28 11:09

👉 Enter workspace number: 0

✅ Selected workspace: 4b4f51c0f722ba75d9bcebbbfd4c5718
📂 Exporting: 277 prompts, 100 generations
✅ Export complete!
```

## 📦 Installation

### Method 1: Via Claude Code Plugin Marketplace (Recommended)

```
/plugin marketplace add outhsics/outhsics-skills
```

### Method 2: Manual Installation

```bash
git clone https://github.com/outhsics/outhsics-skills.git ~/.claude/skills/outhsics-skills
```

## 🚀 Usage

### In Claude Code

Simply type:

```
/load-codex-chat
```

Or use natural language:

```
"帮我加载 Codex 聊天记录"
"Load my Cursor chat history"
"Import my Codex conversations"
```

### Command Line

```bash
~/.claude/skills/outhsics-skills/load-codex-chat/load-chat.sh
```

## 📖 Usage Examples

### 1. View Recent Conversations

```bash
cat ~/codex_chat_summary.txt
```

### 2. Continue a Previous Discussion

In Claude Code:

```
"Read the chat history and continue our discussion about Vue.js"
```

### 3. Search for Specific Topics

```bash
cat ~/codex_chat_prompts.json | \
  jq -r '.[] | select(.text | test("permission"; "i")) | .text'
```

### 4. Analyze Conversation Topics

```bash
cat ~/codex_chat_prompts.json | \
  jq -r '.[].text' | \
  grep -oE '\b[a-zA-Z]{4,}\b' | \
  sort | uniq -c | sort -rn | head -20
```

## 📁 What Gets Exported

| File | Description | Format |
|------|-------------|--------|
| `~/codex_chat_prompts.json` | Your questions/prompts | JSON array |
| `~/codex_chat_generations.json` | AI responses | JSON array |
| `~/codex_chat_summary.txt` | Readable summary (last 10) | Plain text |

## 🛠️ Requirements

- **macOS** (Cursor data location specific)
- **sqlite3** - Command-line SQLite tool
- **jq** - JSON processor

Install dependencies:

```bash
brew install sqlite3 jq
```

## 🎯 Use Cases

### ✅ Perfect For

- Migrating from Cursor to Claude Code
- Backing up AI conversations
- Searching historical code discussions
- Continuing interrupted work sessions
- Analyzing your coding patterns

### ❌ Not For

- Real-time sync between tools
- Editing Cursor chat history
- Cross-platform migration (macOS only)

## 🔧 How It Works

1. **Scans** Cursor workspace directories
2. **Finds** SQLite databases containing chat history
3. **Extracts** prompts and generations tables
4. **Exports** to JSON and summary formats
5. **Loads** into Claude Code context

## 🤝 Contributing

Contributions are welcome! Especially for:

- Windows/Linux support
- Additional AI tool integrations
- GUI interface
- Performance improvements

## 📊 Stats

- **Supported Platforms:** macOS
- **Supported Tools:** Cursor, Codex
- **Export Formats:** JSON, TXT
- **License:** MIT

## 🐛 Troubleshooting

### Issue: "No Cursor workspace found"

**Solution:** Make sure you've used Cursor's AI chat feature at least once.

### Issue: "sqlite3: command not found"

**Solution:** Install sqlite3:
```bash
brew install sqlite3
```

### Issue: "Exported files are empty"

**Solution:** The selected workspace might not have chat history. Try another workspace.

## 📝 License

MIT License - feel free to use in personal and commercial projects.

## 🌟 Star History

If you find this tool helpful, please consider giving it a star!

[![Star History Chart](https://api.star-history.com/svg?repos=outhsics/outhsics-skills&type=Date)](https://star-history.com/#outhsics/outhsics-skills&Date)

## 📮 Contact

- **Author:** [@outhsics](https://github.com/outhsics)
- **Issues:** [GitHub Issues](https://github.com/outhsics/outhsics-skills/issues)
- **Discussions:** [GitHub Discussions](https://github.com/outhsics/outhsics-skills/discussions)

---

<div align="center">

**Made with ❤️ for the Claude Code community**

[⬆ Back to Top](#-cursor-to-claude-code-chat-migration-tool)

</div>

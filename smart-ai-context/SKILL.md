---
name: smart-ai-context
description: Automatically scan and load conversations from all AI tools (Cursor, ChatGPT, Claude Code, etc.) into Claude Code context. Zero configuration, intelligent loading.
---

# Smart AI Context Aggregator

## Overview

Automatically scan and load conversations from multiple AI tools into Claude Code, providing unified context across all your AI interactions.

## Features

- 🔍 **Automatic Scanning** - Detects all installed AI tools
- 📊 **Unified Context** - Aggregates conversations from Cursor, ChatGPT, Claude Code
- 🚀 **Zero Configuration** - Works out of the box
- 🎯 **Smart Loading** - Load all, recent, or keyword-filtered conversations
- 🔒 **Privacy First** - All processing happens locally

## Supported AI Tools

### ✅ Currently Supported
- **Cursor/Codex** - All workspaces
- **ChatGPT** (macOS app) - Local conversations
- **Claude Code** - Current session history

### 🔄 Coming Soon
- GitHub Copilot
- Windsurf
- Tabby
- Continue
- Codeium

## When to Use

**Perfect for:**
- Switching between AI tools and wanting complete context
- Searching discussions across all AI tools
- Continuing previous conversations from any tool
- Analyzing your AI usage patterns

**Use when:**
- Starting a new Claude Code session
- Looking for past discussions about a topic
- Need context from previous AI interactions

## Usage

### Basic Usage

```
/smart-ai-context
```

This will:
1. Scan all AI tools
2. Show conversation counts
3. Display recent activity

### Load Conversations

```
/load-ai-context all
```
Load all conversations from all tools

```
/load-ai-context recent
```
Load recent conversations (last 7 days)

```
/load-ai-context keyword <your-keyword>
```
Load conversations containing a specific keyword

### Examples

```
"Scan all my AI tools and show recent activity"
"Load all conversations about Vue.js"
"What did I discuss with AI tools this week?"
"Find all conversations about authentication"
```

## How It Works

### 1. Scanning

```
🤖 Smart AI Context Aggregator

🔍 Scanning for AI tools...

✓ Cursor: 277 conversations
✓ ChatGPT: 156 conversations
✓ Claude Code: 89 conversations

📊 Total: 522 conversations across 3 AI tools
```

### 2. Loading

```
📅 Loading recent conversations (last 7 days)...

📤 Loading Cursor conversations...
   ✓ Loaded 50 prompts from Cursor

📤 Loading ChatGPT conversations...
   ✓ Loaded 23 conversations from ChatGPT

✅ AI conversations loaded successfully!
```

### 3. Using the Context

After loading, you can:

- "Summarize all conversations"
- "What did I ask about error handling?"
- "Continue the Vue.js discussion from Cursor"
- "Compare ChatGPT and Claude's answers on X"

## Data Locations

### Cursor
```
~/Library/Application Support/Cursor/User/workspaceStorage/<workspace-id>/state.vscdb
```

### ChatGPT
```
~/Library/Application Support/com.openai.chat/Local/storage.db
```

### Claude Code
```
~/.claude/history.jsonl
```

## Output Files

Conversations are exported to:
- `~/cursor_prompts.json` - Your Cursor questions
- `~/cursor_generations.json` - Cursor AI responses
- `~/chatgpt_conversations.json` - ChatGPT conversations

## Privacy & Security

- ✅ **100% Local** - All processing happens on your machine
- ✅ **No Upload** - No data sent to external servers
- ✅ **User Control** - You decide what to load
- ✅ **Transparent** - Open source code you can review

## Performance

- **Scan**: < 2 seconds for 1000+ conversations
- **Load**: < 1 second for typical usage
- **Memory**: Minimal footprint with intelligent caching

## Requirements

- macOS (currently)
- sqlite3 (usually pre-installed)
- jq (JSON processor)

Install dependencies:
```bash
brew install jq
```

## Troubleshooting

### "No conversations found"
- Make sure you've used AI tools before
- Check if data paths are correct
- Try running individual tool loaders

### "Permission denied"
- Ensure Claude Code has access to your folders
- Check file permissions in AI tool directories

### "Slow performance"
- First scan builds cache (slower)
- Subsequent scans are much faster
- Consider filtering by keyword

## Advanced Usage

### Manual Scripts

```bash
# Scan only
~/.claude/skills/smart-ai-context/scripts/scan.sh

# Load specific mode
~/.claude/skills/smart-ai-context/scripts/load.sh all
~/.claude/skills/smart-ai-context/scripts/load.sh recent
~/.claude/skills/smart-ai-context/scripts/load.sh keyword "Vue"
```

### Configuration

Edit `~/.claude/skills/smart-ai-context/config/settings.yaml`:
```yaml
tools:
  cursor: true
  chatgpt: true
  claude: true

scan:
  exclude_tools: []
  max_age_days: 30

load:
  default_mode: recent
  max_conversations: 100
```

## Development

### Adding Support for New AI Tools

1. Create tool parser in `tools/<tool-name>.sh`
2. Add to `scan.sh` detection logic
3. Test with sample data
4. Submit PR

### Project Structure

```
smart-ai-context/
├── scripts/
│   ├── scan.sh           # Main scanning script
│   └── load.sh           # Loading script
├── tools/                # Tool-specific parsers
├── config/               # Configuration files
└── cache/                # Metadata and indices
```

## Roadmap

### v1.0 (Current)
- ✅ Cursor support
- ✅ ChatGPT support
- ✅ Claude Code support
- ✅ Basic filtering

### v1.5 (Next)
- [ ] Windows/Linux support
- [ ] GUI configuration
- [ ] Advanced search
- [ ] Conversation analytics

### v2.0 (Future)
- [ ] Plugin system
- [ ] Cloud sync (optional)
- [ ] Team collaboration
- [ ] Mobile apps

## Contributing

Contributions welcome! Areas of need:
- Additional AI tool support
- Windows/Linux ports
- Performance improvements
- Documentation improvements

## License

MIT License - Free for personal and commercial use

## Credits

Created by [@outhsics](https://github.com/outhsics)

Inspired by the need for unified AI context across tools.

---

**Made with ❤️ for the AI development community**

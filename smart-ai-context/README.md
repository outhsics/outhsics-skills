# Smart AI Context Aggregator

Automatically scan and load conversations from multiple AI tools into Claude Code.

## Quick Start

```
/smart-ai-context
```

This will scan all AI tools and show:
- How many conversations in each tool
- Recent activity summary
- Smart loading suggestions

## Features

- 🔍 Auto-detect AI tools (Cursor, ChatGPT, Claude Code)
- 📊 Aggregate all conversations
- 🎯 Load all, recent, or keyword-filtered
- 🔒 100% local, privacy-first
- ⚡ Fast (< 2 seconds)

## Usage Examples

### Scan and show summary
```
/smart-ai-context
```

### Load recent conversations
```
/load-ai-context recent
```

### Load by keyword
```
/load-ai-context keyword Vue
```

### Load all
```
/load-ai-context all
```

## Supported Tools

- ✅ Cursor/Codex
- ✅ ChatGPT (mac app)
- ✅ Claude Code

## Output Files

- `~/cursor_prompts.json`
- `~/cursor_generations.json`
- `~/chatgpt_conversations.json`

## Privacy

All processing is local. No uploads. No tracking.

## Requirements

- macOS
- sqlite3
- jq: `brew install jq`

## License

MIT

# outhsics-skills

Personal Claude Code Skills Collection by outhsics

## Skills

### load-codex-chat

Automatically export and load Cursor/Codex chat history into Claude Code context.

**Features:**
- Interactive workspace selection
- Export prompts and generations
- Generate readable summaries
- Support multiple workspaces

**Usage:**
```bash
/load-codex-chat
```

## Installation

### Via Plugin Marketplace

```bash
/plugin marketplace add outhsics/outhsics-skills
```

### Manual Install

```bash
git clone https://github.com/outhsics/outhsics-skills.git ~/.claude/skills/outhsics-skills
```

## Requirements

- macOS (Cursor data location specific)
- sqlite3 command-line tool
- jq for JSON processing

Install dependencies:
```bash
brew install sqlite3 jq
```

## License

MIT

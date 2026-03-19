---
name: load-codex-chat
description: Load and import Cursor/Codex chat history into Claude Code context. Use when you want to continue previous conversations or reference past AI interactions.
---

# Load Codex Chat History

## Overview

Automatically exports and loads Cursor/Codex chat history from local SQLite databases into Claude Code context.

## When to Use

- Continue a previous Cursor/Codex conversation in Claude Code
- Reference past AI interactions and prompts
- Migrate context from Cursor to Claude Code
- Review historical coding discussions

## How It Works

1. Automatically finds the most recent Cursor workspace
2. Exports `aiService.prompts` (your questions) and `aiService.generations` (AI responses)
3. Formats the data for easy reading and context loading
4. Provides summaries and allows filtering by topic/time

## Usage

Simply invoke this skill and it will:
- Export the latest chat history to `~/codex_chat_prompts.json` and `~/codex_chat_generations.json`
- Create a readable summary at `~/codex_chat_summary.txt`
- Load the most recent conversations into context

## Data Locations

Cursor stores chat history in:
```
~/Library/Application Support/Cursor/User/workspaceStorage/<workspace-id>/state.vscdb
```

Tables used:
- `ItemTable` with keys:
  - `aiService.prompts` - User's questions/prompts
  - `aiService.generations` - AI's responses

## Output Format

The exported JSON contains:
- **prompts**: Array of your questions with timestamps and UUIDs
- **generations**: Array of AI responses with type (apply/composer) and descriptions

## Example Queries After Loading

You can ask Claude to:
- "Summarize the last 5 conversations about Vue.js"
- "Continue the discussion about the permission.ts issue"
- "What was the solution we found for the runtime error?"
- "List all bugs we fixed in the past week"

## Automation

This skill can be called automatically when:
- Starting a new Claude Code session
- Switching between workspaces
- Need arises to reference past conversations

## Notes

- Only works if Cursor/Codex has been used on this machine
- Requires access to `~/Library/Application Support/Cursor/`
- Data is local only, no API calls needed
- Multiple workspaces are supported (uses most recent)

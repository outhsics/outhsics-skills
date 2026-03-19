#!/bin/bash

# Load AI conversations into Claude Code context

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CACHE_DIR="$HOME/.claude/skills/smart-ai-context/cache"
OUTPUT_DIR="$HOME"

# Parse arguments
MODE="${1:-recent}"
KEYWORD="${2:-}"

case "$MODE" in
    all)
        echo "🔄 Loading all AI conversations..."
        ;;
    recent)
        echo "📅 Loading recent conversations (last 7 days)..."
        ;;
    keyword)
        if [ -z "$KEYWORD" ]; then
            echo "❌ Please provide a keyword: /load-ai-context keyword <your-keyword>"
            exit 1
        fi
        echo "🔍 Loading conversations with keyword: $KEYWORD"
        ;;
    *)
        echo "Usage: /load-ai-context [all|recent|keyword <keyword>]"
        exit 1
esac

echo ""

# Load Cursor conversations
if [ -d "$HOME/Library/Application Support/Cursor/User/workspaceStorage" ]; then
    echo "📤 Loading Cursor conversations..."

    # Find most recent workspace with data
    LATEST_DB=$(find "$HOME/Library/Application Support/Cursor/User/workspaceStorage" -name "state.vscdb" -type f -exec stat -f "%m %N" {} \; | sort -rn | head -1 | cut -d' ' -f2-)

    if [ -n "$LATEST_DB" ]; then
        sqlite3 "$LATEST_DB" "SELECT value FROM ItemTable WHERE key='aiService.prompts';" > "$OUTPUT_DIR/cursor_prompts.json" 2>/dev/null
        sqlite3 "$LATEST_DB" "SELECT value FROM ItemTable WHERE key='aiService.generations';" > "$OUTPUT_DIR/cursor_generations.json" 2>/dev/null

        PROMPTS_COUNT=$(jq 'length' "$OUTPUT_DIR/cursor_prompts.json" 2>/dev/null || echo "0")
        echo "   ✓ Loaded $PROMPTS_COUNT prompts from Cursor"
    fi
fi

# Load ChatGPT conversations
if [ -f "$HOME/Library/Application Support/com.openai.chat/Local/storage.db" ]; then
    echo "📤 Loading ChatGPT conversations..."

    # Export ChatGPT conversations to JSON
    sqlite3 "$HOME/Library/Application Support/com.openai.chat/Local/storage.db" "SELECT json_object('id', id, 'title', title, 'messages', messages) FROM conversations LIMIT 50;" > "$OUTPUT_DIR/chatgpt_conversations.json" 2>/dev/null

    CHATGPT_COUNT=$(jq 'length' "$OUTPUT_DIR/chatgpt_conversations.json" 2>/dev/null || echo "0")
    echo "   ✓ Loaded $CHATGPT_COUNT conversations from ChatGPT"
fi

echo ""
echo "✅ AI conversations loaded successfully!"
echo ""
echo "📁 Files created:"
echo "   - $OUTPUT_DIR/cursor_prompts.json"
echo "   - $OUTPUT_DIR/cursor_generations.json"
echo "   - $OUTPUT_DIR/chatgpt_conversations.json"
echo ""
echo "💡 You can now ask me to:"
echo "   • 'Summarize all conversations'"
echo "   • 'Find discussions about <topic>'"
echo "   • 'Continue the conversation about <subject>'"

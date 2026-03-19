#!/bin/bash

# Smart AI Context Aggregator - Scanner
# Automatically scan and load AI tool conversations

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CACHE_DIR="$HOME/.claude/skills/smart-ai-context/cache"

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

mkdir -p "$CACHE_DIR"

echo -e "${BLUE}🤖 Smart AI Context Aggregator${NC}"
echo ""
echo "🔍 Scanning for AI tools..."
echo ""

# Use temp files for tool tracking
TOOL_FILE="$CACHE_DIR/tools.txt"
COUNT_FILE="$CACHE_DIR/counts.txt"
rm -f "$TOOL_FILE" "$COUNT_FILE"
touch "$TOOL_FILE" "$COUNT_FILE"

TOTAL_COUNT=0

# Scan Cursor
if [ -d "$HOME/Library/Application Support/Cursor/User/workspaceStorage" ]; then
    CURSOR_COUNT=0
    while IFS= read -r -d '' db; do
        COUNT=$(sqlite3 "$db" "SELECT CASE WHEN EXISTS(SELECT 1 FROM ItemTable WHERE key IN ('aiService.prompts', 'aiService.generations')) THEN 1 ELSE 0 END;" 2>/dev/null || echo "0")
        CURSOR_COUNT=$((CURSOR_COUNT + COUNT))
    done < <(find "$HOME/Library/Application Support/Cursor/User/workspaceStorage" -name "state.vscdb" -type f -print0 2>/dev/null)

    if [ $CURSOR_COUNT -gt 0 ]; then
        echo "$CURSOR_COUNT" >> "$COUNT_FILE"
        echo "Cursor|$HOME/Library/Application Support/Cursor/User/workspaceStorage" >> "$TOOL_FILE"
        TOTAL_COUNT=$((TOTAL_COUNT + CURSOR_COUNT))
        echo -e "${GREEN}✓${NC} Cursor: $CURSOR_COUNT workspaces with data"
    fi
fi

# Scan ChatGPT
if [ -d "$HOME/Library/Application Support/com.openai.chat" ]; then
    CHATGPT_COUNT=0
    while IFS= read -r -d '' db; do
        TABLES=$(sqlite3 "$db" ".tables" 2>/dev/null || echo "")
        if echo "$TABLES" | grep -q "conversations"; then
            CHATGPT_COUNT=$((CHATGPT_COUNT + 1))
        fi
    done < <(find "$HOME/Library/Application Support/com.openai.chat" -name "*.db" -type f -print0 2>/dev/null)

    if [ $CHATGPT_COUNT -gt 0 ]; then
        echo "$CHATGPT_COUNT" >> "$COUNT_FILE"
        echo "ChatGPT|$HOME/Library/Application Support/com.openai.chat" >> "$TOOL_FILE"
        TOTAL_COUNT=$((TOTAL_COUNT + CHATGPT_COUNT))
        echo -e "${GREEN}✓${NC} ChatGPT: $CHATGPT_COUNT databases found"
    fi
fi

# Scan Claude Code
if [ -f "$HOME/.claude/history.jsonl" ]; then
    CLAUDE_COUNT=$(wc -l < "$HOME/.claude/history.jsonl" 2>/dev/null | tr -d ' ')
    if [ $CLAUDE_COUNT -gt 0 ]; then
        echo "$CLAUDE_COUNT" >> "$COUNT_FILE"
        echo "Claude Code|$HOME/.claude/history.jsonl" >> "$TOOL_FILE"
        TOTAL_COUNT=$((TOTAL_COUNT + CLAUDE_COUNT))
        echo -e "${GREEN}✓${NC} Claude Code: $CLAUDE_COUNT conversations"
    fi
fi

TOOL_COUNT=$(wc -l < "$TOOL_FILE" 2>/dev/null || echo "0")

echo ""
echo "📊 Total: $TOOL_COUNT AI tools found"
echo ""

if [ $TOTAL_COUNT -eq 0 ]; then
    echo -e "${YELLOW}⚠️  No AI tools detected. Make sure you've used AI tools before.${NC}"
    exit 0
fi

# Show recent activity
echo -e "${YELLOW}💡 Quick actions:${NC}"
echo "   • /load-ai-context recent"
echo "   • /load-ai-context all"
echo "   • /load-ai-context keyword <topic>"
echo ""

# Save metadata
cat > "$CACHE_DIR/summary.json" << EOF
{
  "scan_time": "$(date -u +"%Y-%m-%dT%H:%M:%SZ")",
  "tools_found": $TOOL_COUNT,
  "total_items": $TOTAL_COUNT
}
EOF

echo -e "${GREEN}✅ Scan complete!${NC}"

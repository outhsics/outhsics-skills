#!/bin/bash

# Load Codex Chat History Skill
# Exports Cursor/Codex chat history and formats it for Claude Code

set -e

OUTPUT_DIR="$HOME"
PROMPTS_FILE="$OUTPUT_DIR/codex_chat_prompts.json"
GENERATIONS_FILE="$OUTPUT_DIR/codex_chat_generations.json"
SUMMARY_FILE="$OUTPUT_DIR/codex_chat_summary.txt"
CURSOR_BASE="$HOME/Library/Application Support/Cursor/User/workspaceStorage"

# Function to list workspaces
list_workspaces() {
    echo "🔍 Scanning for Cursor workspaces with chat history..."
    echo ""

    # Create temp file for workspace list
    TEMP_WS=$(mktemp)
    INDEX=0

    while IFS= read -r -d '' db; do
        WORKSPACE_ID=$(basename "$(dirname "$db")")

        # Check if this database has chat data
        HAS_DATA=$(sqlite3 "$db" "SELECT COUNT(*) FROM ItemTable WHERE key IN ('aiService.prompts', 'aiService.generations');" 2>/dev/null || echo "0")

        if [ "$HAS_DATA" -gt 0 ]; then
            # Get workspace folder name
            FOLDER=$(sqlite3 "$db" "SELECT value FROM ItemTable WHERE key='folder';" 2>/dev/null | jq -r '.folder' 2>/dev/null || echo "unknown")
            MOD_TIME=$(stat -f "%Sm" -t "%Y-%m-%d %H:%M" "$db")

            echo "$INDEX|$WORKSPACE_ID|$FOLDER|$MOD_TIME" >> "$TEMP_WS"
            ((INDEX++))
        fi
    done < <(find "$CURSOR_BASE" -name "state.vscdb" -type f -print0)

    if [ $INDEX -eq 0 ]; then
        echo "❌ No Cursor workspace with chat history found!"
        echo "💡 Make sure you've used Cursor's AI chat feature."
        rm -f "$TEMP_WS"
        exit 1
    fi

    echo "📋 Found $INDEX workspace(s) with chat history:"
    echo ""

    cat "$TEMP_WS" | while IFS='|' read -r idx ws_id folder mod_time; do
        printf "   [%s] %s\n" "$idx" "$ws_id"
        printf "       Folder: %s\n" "$folder"
        printf "       Last modified: %s\n" "$mod_time"
        echo ""
    done

    echo "$TEMP_WS"
}

# Main logic
if [ -n "$1" ]; then
    TARGET_WORKSPACE="$1"
    echo "🎯 Using specified workspace: $TARGET_WORKSPACE"
    echo ""
else
    TEMP_WS=$(list_workspaces)
    LINE_COUNT=$(wc -l < "$TEMP_WS" | tr -d ' ')

    if [ $LINE_COUNT -eq 1 ]; then
        CHOICE=0
        echo "✅ Auto-selected the only workspace"
    else
        echo "👉 Enter workspace number (0-$((LINE_COUNT-1))): "
        read -r CHOICE

        if ! [[ "$CHOICE" =~ ^[0-9]+$ ]] || [ "$CHOICE" -lt 0 ] || [ "$CHOICE" -ge $LINE_COUNT ]; then
            echo "❌ Invalid choice!"
            rm -f "$TEMP_WS"
            exit 1
        fi
    fi

    TARGET_WORKSPACE=$(sed -n "$((CHOICE+1))p" "$TEMP_WS" | cut -d'|' -f2)
    echo "✅ Selected workspace: $TARGET_WORKSPACE"
    rm -f "$TEMP_WS"
fi

DB_PATH="$CURSOR_BASE/$TARGET_WORKSPACE/state.vscdb"

if [ ! -f "$DB_PATH" ]; then
    echo "❌ Database not found: $DB_PATH"
    exit 1
fi

echo "📂 Database: $DB_PATH"
echo ""

# Export prompts
echo "📤 Exporting prompts..."
sqlite3 "$DB_PATH" "SELECT value FROM ItemTable WHERE key='aiService.prompts';" > "$PROMPTS_FILE" 2>/dev/null || echo "No prompts found"

# Export generations
echo "📤 Exporting generations..."
sqlite3 "$DB_PATH" "SELECT value FROM ItemTable WHERE key='aiService.generations';" > "$GENERATIONS_FILE" 2>/dev/null || echo "No generations found"

echo ""
echo "✅ Export complete!"
echo ""
echo "📁 Files created:"
echo "   - $PROMPTS_FILE"
echo "   - $GENERATIONS_FILE"

# Create summary
echo ""
echo "📝 Creating summary..."

# Count entries
PROMPTS_COUNT=$(jq 'length' "$PROMPTS_FILE" 2>/dev/null || echo "0")
GENERATIONS_COUNT=$(jq 'length' "$GENERATIONS_FILE" 2>/dev/null || echo "0")

cat > "$SUMMARY_FILE" << EOF
# Codex Chat History Summary
Exported: $(date)
Workspace: $TARGET_WORKSPACE

## Statistics
- Total Prompts: $PROMPTS_COUNT
- Total Generations: $GENERATIONS_COUNT

## Recent Prompts (Last 10)
EOF

if [ -f "$PROMPTS_FILE" ] && [ "$PROMPTS_COUNT" -gt 0 ]; then
    jq -r '.[-10:] | reverse | .[] | "### \(.timestamp // "No timestamp")\n\(.text // "Empty")\n"' "$PROMPTS_FILE" >> "$SUMMARY_FILE" 2>/dev/null || echo "Error formatting prompts"
fi

cat >> "$SUMMARY_FILE" << EOF

## Recent Generations (Last 10)
EOF

if [ -f "$GENERATIONS_FILE" ] && [ "$GENERATIONS_COUNT" -gt 0 ]; then
    jq -r '.[-10:] | reverse | .[] | "### \(.unixMs // "No timestamp") - \(.type // "unknown")\n\(.textDescription // "Empty")\n"' "$GENERATIONS_FILE" >> "$SUMMARY_FILE" 2>/dev/null || echo "Error formatting generations"
fi

echo "   - $SUMMARY_FILE"
echo ""
echo "📊 Summary:"
echo "   - $PROMPTS_COUNT prompts"
echo "   - $GENERATIONS_COUNT generations"
echo ""
echo "✨ Ready to load into Claude Code!"
echo ""
echo "💡 Usage tips:"
echo "   - View summary: cat $SUMMARY_FILE"
echo "   - Load in Claude Code: 'Read the prompts and tell me what we discussed about [topic]'"
echo "   - Continue conversation: 'Based on prompt #X, continue that discussion'"

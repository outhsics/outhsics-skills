#!/bin/bash

# Demo录制脚本 - 展示 Smart AI Context Aggregator

set -e

OUTPUT_DIR="$HOME/Desktop"
TIMESTAMP=$(date +"%Y%m%d_%H%M%S")
OUTPUT_FILE="$OUTPUT_DIR/smart-ai-context-demo-$TIMESTAMP.gif"

echo "🎬 Recording Smart AI Context Aggregator Demo"
echo "Output: $OUTPUT_FILE"
echo ""

# 检查是否安装了录制工具
if command -v ffmpeg &> /dev/null; then
    # 使用 terminal recorder
    echo "Using ffmpeg for recording..."
    echo "⚠️  Note: Interactive recording - press 'q' to stop"

    read -p "Press Enter to start recording..."

    # 使用 terminal 截图（需要用户手动操作）
    echo ""
    echo "📝 Demo script:"
    echo ""
    echo "# Step 1: Scan for AI tools"
    echo "echo '🔍 Scanning for AI tools...'"
    echo "~/.claude/skills/smart-ai-context/scripts/scan.sh"
    echo ""
    echo "# Step 2: Load conversations"
    echo "echo '📤 Loading conversations...'"
    echo "~/.claude/skills/smart-ai-context/scripts/load.sh recent"
    echo ""
    echo "# Step 3: Use in Claude Code"
    echo "echo '💬 Using loaded context...'"
    echo ""

elif command -v terminalizer &> /dev/null; then
    # 使用 terminalizer
    echo "Using terminalizer..."
    terminalizer record smart-ai-context-demo -c ~/.claude/skills/smart-ai-context/scripts/scan.sh

elif [ -d "/Applications" ]; then
    # macOS - 建议使用屏幕录制
    echo "📱 Recommended recording methods for macOS:"
    echo ""
    echo "Option 1: Built-in Screen Recording"
    echo "  1. Press Cmd + Shift + 5"
    echo "  2. Select 'Record Selected Portion'"
    echo "  3. Run the demo commands:"
    echo ""
    echo "  ~/.claude/skills/smart-ai-context/scripts/scan.sh"
    echo "  ~/.claude/skills/smart-ai-context/scripts/load.sh recent"
    echo ""
    echo "Option 2: Use CleanShot X (if installed)"
    echo "Option 3: Use Kap (free screen recorder)"
    echo "  brew install --cask kap"
    echo ""

else
    echo "⚠️  No recording tool found."
    echo ""
    echo "Install one of:"
    echo "  brew install ffmpeg"
    echo "  brew install --cask kap"
    echo "  npm install -g terminalizer"
    echo ""
fi

# 创建演示文本版本
echo "📝 Creating text-based demo..."
cat > "$OUTPUT_DIR/DEMO.md" << 'EOF'
# Smart AI Context Aggregator - Demo

## Step 1: Scan AI Tools

```bash
~/.claude/skills/smart-ai-context/scripts/scan.sh
```

**Output:**
```
🤖 Smart AI Context Aggregator

🔍 Scanning for AI tools...

✓ Cursor: 34 workspaces with data
✓ ChatGPT: 2 databases found
✓ Claude Code: 1388 conversations

📊 Total: 3 AI tools found

💡 Quick actions:
   • /load-ai-context recent
   • /load-ai-context all
   • /load-ai-context keyword <topic>

✅ Scan complete!
```

## Step 2: Load Conversations

In Claude Code:
```
/load-ai-context recent
```

**Output:**
```
📅 Loading recent conversations (last 7 days)...

📤 Loading Cursor conversations...
   ✓ Loaded 50 prompts from Cursor

📤 Loading ChatGPT conversations...
   ✓ Loaded 23 conversations from ChatGPT

✅ AI conversations loaded successfully!

📁 Files created:
   - ~/cursor_prompts.json
   - ~/cursor_generations.json
   - ~/chatgpt_conversations.json

💡 You can now ask me to:
   • 'Summarize all conversations'
   • 'Find discussions about <topic>'
   • 'Continue the conversation about <subject>'
```

## Step 3: Use Loaded Context

```
"Summarize all conversations about Vue.js"
"What did I ask about authentication?"
"Find discussions about error handling"
```

## Key Features

✅ **Zero Configuration** - Works out of the box
✅ **Multi-Tool Support** - Cursor, ChatGPT, Claude Code
✅ **Privacy First** - 100% local processing
✅ **Fast** - Scans in < 2 seconds
✅ **Smart Loading** - Filter by time or keyword
EOF

echo "✅ Demo guide created: $OUTPUT_DIR/DEMO.md"
echo ""
echo "🎯 Next steps:"
echo "1. Record demo using one of the methods above"
echo "2. Upload GIF to GitHub Releases"
echo "3. Add GIF to README.md"
echo "4. Share on social media"

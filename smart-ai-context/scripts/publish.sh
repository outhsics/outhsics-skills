#!/bin/bash

# 发布脚本 - 将 smart-ai-context 发布到 GitHub

set -e

GITHUB_REPO="outhsics/outhsics-skills"
TEMP_DIR="/tmp/outhsics-skills-publish"

echo "🚀 Publishing Smart AI Context Aggregator to GitHub"
echo "Repository: $GITHUB_REPO"
echo ""

# 创建临时目录
rm -rf "$TEMP_DIR"
mkdir -p "$TEMP_DIR"
cd "$TEMP_DIR"

# 克隆现有仓库
echo "📥 Cloning repository..."
git clone "https://github.com/$GITHUB_REPO.git" .

# 复制新的 skill
echo "📦 Adding smart-ai-context skill..."
rm -rf smart-ai-context
cp -r "$HOME/.claude/skills/smart-ai-context" .

# 更新主 README
echo "📝 Updating README..."
cat > README.md << 'EOF'
# 🤖 outhsics-skills

Personal Claude Code Skills Collection by [outhsics](https://github.com/outhsics)

## ✨ Skills

### 1. Smart AI Context Aggregator ⭐ NEW

**Automatically scan and load conversations from all AI tools**

- 🔍 Auto-detect Cursor, ChatGPT, Claude Code
- 📊 Unify all AI conversations in one place
- 🚀 Zero configuration
- 🔒 100% local and private

```
/smart-ai-context
```

[Read more →](./smart-ai-context/README.md)

### 2. Load Codex Chat

**Export Cursor/Codex chat history to Claude Code**

```
/load-codex-chat
```

[Read more →](./load-codex-chat/README.md)

## 📦 Installation

### Via Plugin Marketplace (Recommended)

```
/plugin marketplace add outhsics/outhsics-skills
```

### Manual Installation

```bash
git clone https://github.com/outhsics/outhsics-skills.git ~/.claude/skills/outhsics-skills
```

## 🛠️ Requirements

- macOS (currently)
- sqlite3
- jq

Install dependencies:
```bash
brew install sqlite3 jq
```

## 🎯 Usage

### Smart AI Context (Recommended)

```
/smart-ai-context
```

This will scan all AI tools and show:
- How many conversations in each tool
- Recent activity summary
- Quick actions

### Load Specific Conversations

```
/load-ai-context recent
/load-ai-context all
/load-ai-context keyword <topic>
```

## 🤝 Contributing

Contributions welcome! Please feel free to submit a Pull Request.

## 📄 License

MIT License - feel free to use in personal and commercial projects.

## 👨‍💻 Author

[@outhsics](https://github.com/outhsics)

---

**Made with ❤️ for the Claude Code community**
EOF

# Git 操作
echo "📤 Committing changes..."
git add .
git commit -m "Add Smart AI Context Aggregator

Features:
- Auto-scan all AI tools (Cursor, ChatGPT, Claude Code)
- Load conversations by time or keyword
- Zero configuration, privacy-first
- Fast scanning (< 2 seconds)"

echo "🚀 Pushing to GitHub..."
git push origin main

echo ""
echo "✅ Successfully published!"
echo ""
echo "📦 Repository: https://github.com/$GITHUB_REPO"
echo ""
echo "🎯 Next steps:"
echo "1. Add demo GIF to README"
echo "2. Share on social media"
echo "3. Submit to Claude Code marketplace"
echo "4. Monitor issues and PRs"

# 清理
echo ""
echo "🧹 Cleaning up..."
rm -rf "$TEMP_DIR"

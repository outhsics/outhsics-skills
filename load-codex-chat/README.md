# Load Codex Chat - 使用指南

## 🎯 功能

自动导出 Cursor/Codex 的聊天历史记录，并在 Claude Code 中加载使用。

## 📦 安装

Skill 已经安装在：`~/.claude/skills/load-codex-chat/`

## 🚀 使用方法

### 方法 1：交互式选择（推荐）

直接在 Claude Code 中说：
```
/load-codex-chat
```

或
```
帮我加载 Codex 聊天记录
```

然后脚本会列出所有有聊天记录的 workspace，你只需要输入对应的数字即可。

### 方法 2：直接指定 workspace

如果你知道 workspace ID，可以直接指定：
```bash
~/.claude/skills/load-codex-chat/load-chat.sh <workspace-id>
```

例如：
```bash
~/.claude/skills/load-codex-chat/load-chat.sh 9d90fcdabf25fa2dd012d3b7adaa893a
```

### 方法 3：使用 Skill 工具

在 Claude Code 中：
```
使用 load-codex-chat skill
```

## 📁 导出的文件

运行后会在 home 目录生成以下文件：

1. **`~/codex_chat_prompts.json`** - 你的提问记录
2. **`~/codex_chat_generations.json`** - AI 的回答记录
3. **`~/codex_chat_summary.txt`** - 可读的摘要（最近 10 条）

## 💡 使用场景

### 1. 查看摘要
```bash
cat ~/codex_chat_summary.txt
```

### 2. 在 Claude Code 中继续讨论

直接告诉我：
- "读取聊天记录，总结我们讨论了什么"
- "查看最近的对话，继续之前关于 Vue 的问题"
- "根据 prompt #5，继续那个讨论"

### 3. 搜索特定话题

```bash
# 查找包含特定关键词的对话
cat ~/codex_chat_prompts.json | jq -r '.[] | select(.text | test("permission"; "i")) | .text'
```

### 4. 查看所有对话主题

```bash
cat ~/codex_chat_prompts.json | jq -r '.[].text' | head -20
```

## 🔍 Workspace ID 查找

Chat history 存储在：
```
~/Library/Application Support/Cursor/User/workspaceStorage/<workspace-id>/state.vscdb
```

可以通过修改时间找到最新的：
```bash
find ~/Library/Application\ Support/Cursor/User/workspaceStorage \
  -name "state.vscdb" -type f -exec stat -f "%m %N" {} \; | \
  sort -rn | head -1
```

## 📊 数据格式

### Prompts 格式
```json
[
  {
    "timestamp": 1234567890,
    "text": "你的问题内容",
    "uuid": "唯一标识符"
  }
]
```

### Generations 格式
```json
[
  {
    "unixMs": 1234567890,
    "generationUUID": "唯一标识符",
    "type": "composer|apply",
    "textDescription": "问题摘要"
  }
]
```

## 🛠️ 故障排除

### 问题：找不到 workspace
- 确保你使用过 Cursor 的 AI 聊天功能
- 检查路径是否正确：`~/Library/Application Support/Cursor/`

### 问题：导出的文件是空的
- 该 workspace 可能没有聊天记录
- 尝试选择其他 workspace

### 问题：sqlite3 命令不存在
```bash
brew install sqlite3
```

## 📝 示例工作流

```bash
# 1. 导出聊天记录
~/.claude/skills/load-codex-chat/load-chat.sh

# 2. 查看摘要
cat ~/codex_chat_summary.txt

# 3. 在 Claude Code 中说：
# "读取 ~/codex_chat_prompts.json，找出所有关于 Vue 的问题"

# 4. 继续讨论
# "根据 prompt #12，继续那个关于权限管理的讨论"
```

## 🎓 高级技巧

### 1. 定期备份
```bash
# 添加到 crontab 定期备份
crontab -e
# 添加：0 0 * * * ~/.claude/skills/load-codex-chat/load-chat.sh <workspace-id>
```

### 2. 多 workspace 管理
```bash
# 导出所有 workspace 的聊天记录
for ws in ~/Library/Application\ Support/Cursor/User/workspaceStorage/*/state.vscdb; do
    ws_id=$(basename $(dirname $ws))
    ~/.claude/skills/load-codex-chat/load-chat.sh $ws_id
    mv ~/codex_chat_*.json ~/backups/codex_$ws_id.json
done
```

### 3. 聊天记录分析
```bash
# 统计最常讨论的话题
cat ~/codex_chat_prompts.json | jq -r '.[].text' | \
  grep -oE '\b[a-zA-Z]{4,}\b' | sort | uniq -c | sort -rn | head -20
```

## 📚 相关资源

- Cursor: https://cursor.sh
- Claude Code: https://claude.ai/code
- 本 skill 位置：`~/.claude/skills/load-codex-chat/`

## 🔄 更新日志

- **v1.0** (2026-03-18)
  - 初始版本
  - 支持交互式选择 workspace
  - 自动生成可读摘要
  - 支持多 workspace 管理

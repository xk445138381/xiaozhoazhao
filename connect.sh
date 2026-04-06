#!/bin/bash
# G(Gitee)跟本地连接脚本
# 用于将本地仓库与Gitee远程仓库建立连接

set -e

REMOTE_NAME="gitee"
REMOTE_URL=""

usage() {
    echo "用法: $0 <Gitee仓库URL>"
    echo "示例: $0 https://gitee.com/用户名/仓库名.git"
    echo "      $0 git@gitee.com:用户名/仓库名.git"
    exit 1
}

# 显示帮助
if [ "${1:-}" = "-h" ] || [ "${1:-}" = "--help" ]; then
    usage
fi

# 检查参数
if [ $# -lt 1 ]; then
    # 尝试从git config读取已有配置
    REMOTE_URL=$(git remote get-url "$REMOTE_NAME" 2>/dev/null || true)
    if [ -z "$REMOTE_URL" ]; then
        echo "错误: 未提供Gitee仓库URL，且本地尚未配置gitee远程。"
        usage
    fi
    echo "已找到现有Gitee远程配置: $REMOTE_URL"
else
    REMOTE_URL="$1"
fi

# 检查是否在git仓库中
if ! git rev-parse --is-inside-work-tree > /dev/null 2>&1; then
    echo "错误: 当前目录不是Git仓库，请先执行 git init"
    exit 1
fi

# 添加或更新远程
if git remote get-url "$REMOTE_NAME" > /dev/null 2>&1; then
    echo "更新远程 '$REMOTE_NAME' 的URL为: $REMOTE_URL"
    git remote set-url "$REMOTE_NAME" "$REMOTE_URL"
else
    echo "添加远程 '$REMOTE_NAME': $REMOTE_URL"
    git remote add "$REMOTE_NAME" "$REMOTE_URL"
fi

echo ""
echo "✅ G(Gitee)与本地连接成功！"
echo ""
echo "当前远程列表:"
git remote -v
echo ""
echo "常用命令:"
echo "  推送到Gitee:  git push $REMOTE_NAME <分支名>"
echo "  从Gitee拉取:  git pull $REMOTE_NAME <分支名>"

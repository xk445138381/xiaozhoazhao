# xiaozhoazhao
自用

## G跟本地连接

将G(Gitee)与本地Git仓库建立连接。

### 使用方法

```bash
# 赋予脚本执行权限
chmod +x connect.sh

# 连接到Gitee仓库（HTTPS）
./connect.sh https://gitee.com/用户名/仓库名.git

# 连接到Gitee仓库（SSH）
./connect.sh git@gitee.com:用户名/仓库名.git
```

### 连接成功后

```bash
# 推送到Gitee
git push gitee <分支名>

# 从Gitee拉取
git pull gitee <分支名>
```

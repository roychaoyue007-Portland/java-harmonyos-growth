# GitHub Setup

目标：把 `java-harmonyos-growth` 学习项目交给 Git 和 GitHub 管理。

GitHub 仓库：

- https://github.com/roychaoyue007-Portland/java-harmonyos-growth

## 先理解 5 个词

- Git：本地版本管理工具，记录文件变化。
- GitHub：线上代码托管平台，用来备份、分享和协作。
- 仓库 repository：一个被 Git 管理的项目文件夹。
- 提交 commit：保存一次项目变化。
- 远程仓库 remote：GitHub 上对应的线上仓库。

## 当前进度

- [x] 安装 Git
- [x] 初始化本地 Git 仓库
- [x] 创建 `.gitignore`
- [x] 完成第一次本地提交
- [x] 创建 GitHub 远程仓库
- [x] 连接远程仓库 `origin`
- [x] 推送 `main` 分支到 GitHub

## 当前仓库信息

本地仓库：

```text
E:\Codex\projects\java-harmonyos-growth
```

远程仓库：

```text
https://github.com/roychaoyue007-Portland/java-harmonyos-growth.git
```

当前主分支：

```text
main
```

## 每天学习后的固定流程

进入项目目录：

```powershell
cd E:\Codex\projects\java-harmonyos-growth
```

查看变化：

```powershell
git status
```

暂存所有变化：

```powershell
git add .
```

提交变化：

```powershell
git commit -m "day XX notes"
```

推送到 GitHub：

```powershell
git push
```

## 常见命令解释

- `git status`：查看哪些文件发生了变化。
- `git add .`：把当前目录下所有变化加入待提交区。
- `git commit -m "..."`：保存一次版本记录。
- `git push`：把本地提交上传到 GitHub。
- `git log --oneline`：查看提交历史。


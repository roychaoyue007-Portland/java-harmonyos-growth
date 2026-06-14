# GitHub Setup

目标：把 `java-harmonyos-growth` 学习项目交给 Git 和 GitHub 管理。

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
- [ ] 创建 GitHub 远程仓库
- [ ] 连接远程仓库
- [ ] 推送到 GitHub

## 创建 GitHub 远程仓库

在 GitHub 网页创建一个新仓库：

```text
java-harmonyos-growth
```

建议：

- Public 或 Private 都可以。
- 不要勾选自动创建 README，因为本地已经有 README。

## 连接远程仓库并推送

把下面地址换成自己的 GitHub 仓库地址：

```powershell
git remote add origin https://github.com/你的用户名/java-harmonyos-growth.git
git branch -M main
git push -u origin main
```

## 每天学习后的固定流程

```powershell
git status
git add .
git commit -m "day 01 notes"
git push
```


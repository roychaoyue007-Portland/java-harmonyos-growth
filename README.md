# Java HarmonyOS Fullstack Growth

这是我的 6 个月全栈成长学习仓库。

当前目标不是先追某一个框架，而是先听懂软件开发世界的基础语言，再逐步进入 Java、后端、数据库、鸿蒙、前端基础、GitHub 和部署。

GitHub 仓库：

- https://github.com/roychaoyue007-Portland/java-harmonyos-growth

## 总目标

6 个月后，我希望能独立完成一个完整项目：

```text
鸿蒙客户端 / 可选 Web 前端
    -> HTTP 接口
    -> Java Spring Boot 后端
    -> MySQL 数据库
    -> 部署到服务器
    -> GitHub 管理代码和文档
```

## 学习主线

1. 概念线：理解术语、原理和技术之间的关系。
2. 操作线：会使用电脑、命令行、IDE、Git、调试和部署工具。
3. 编程线：能用 Java / JavaScript / ArkTS 写出真实功能。
4. 项目线：最终完成 Java 后端 + 数据库 + 鸿蒙客户端的完整项目。

## 6 个月路线

- 第 1 个月：计算机导论、操作系统入门、文件、路径、命令、脚本、基础术语。
- 第 2 个月：编程基本功与 Java 核心。
- 第 3 个月：数据结构、数据库、HTTP、JSON、接口基础。
- 第 4 个月：Spring Boot 后端开发。
- 第 5 个月：鸿蒙客户端、前端基础、Git / GitHub、工程化。
- 第 6 个月：部署与完整全栈项目。

## 学习计划唯一入口

以后每天学习时，默认只读取下面这两个文件：

1. `plan/current-plan.md`：当前执行入口，说明今天应该按哪个计划走。
2. `plan/weekly-plan.md`：本周每天的具体主题、任务和验收方向。

`plan/six-month-fullstack-plan.md` 只作为长期路线图，不直接决定“今天学什么”。

`archive/old-30-day-plan/` 是旧计划归档，只用于历史参考。除非我明确说“查看旧 30 天计划”，否则不要按里面的内容安排学习。

详细计划见：

- `plan/current-plan.md`
- `plan/weekly-plan.md`
- `plan/six-month-fullstack-plan.md`
- `plan/github-setup.md`
- `plan/chatgpt-daily-prompt-template.md`

## 目录说明

- `plan/`：6 个月计划、每周计划。
- `dictionary/`：技术词典，用自己的话解释技术词。
- `notes/`：每日学习笔记。
- `practice/`：每日操作练习和代码练习。
- `java-demo/`：Java 练习代码。
- `harmonyos-demo/`：鸿蒙练习记录和示例。
- `english/`：技术英文词汇。
- `projects/`：阶段项目和最终项目。

## 每天 3 到 4 小时学习模板

1. 45 分钟：读书或概念理解。
2. 45 分钟：拆技术词，写技术词典。
3. 90 分钟：动手练习或写代码。
4. 30 分钟：复盘笔记。
5. 可选 30 分钟：英文 README、报错或文档阅读。

## 每天必须产出

- 3 到 5 个技术词解释。
- 1 个操作练习或代码练习。
- 1 篇简短复盘。

## 当前学习入口

当前主线：6 个月全栈成长计划 / Week 01。

今天学什么，以 `plan/current-plan.md` 和 `plan/weekly-plan.md` 为准。

当前 Week 01 主题：计算机导论与操作系统入门。

## 使用方式

每天开始学习前，可以对 Codex 或 ChatGPT 说：

```text
继续全栈学习计划，今天是 Day XX
```
```text
备注：如果无法正确开始，请确认计划路径是否找到。
```

如果要让 Codex 生成一段可以直接粘贴到 ChatGPT 网页版的每日学习提示词，可以在 Codex 新对话中说：

```text
使用 $fullstack-study-prompt，生成 Day XX 发给 ChatGPT 的学习提示词。
```

每天学完后，提交：

```text
今日笔记
技术词典更新
练习结果
验收题答案
```

然后让 AI 帮我检查是否通过当天学习。

## GitHub 管理

本项目已经接入 Git 和 GitHub。

每天学习资料更新后，常用流程：

```powershell
git status
git add .
git commit -m "day XX notes"
git push
```

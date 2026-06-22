# Week 02 学习计划：命令行操作与基础排错

周期：Day 08～Day 14  
计划开始：2026-06-23  
当前阶段：Month 01——计算机导论与操作系统入门  
建议学习时间：每天 3～3.5 小时，Day 14 为 2～3 小时

## 编号规则

- 全程使用连续编号：Day 08、Day 09……
- Week 02 · Day 01 只表示周内位置，不用于文件夹主编号。
- 进入新周或新月时不重置 Day，避免笔记、练习和验收文件重名。

## 本周定位

Week 01 解决的是：听懂文件、程序、进程、编译、网络等基础词。

Week 02 解决的是：能在命令行中操作电脑、理解命令执行过程，并对常见问题进行基础排查。

本周暂不进入：

- Java 变量、判断、循环等语法。
- Spring Boot、数据库、Vue、鸿蒙页面开发。
- Git 分支、合并和团队协作。
- PowerShell 高级脚本、系统管理和网络底层原理。

## 本周目标

- 分清终端、Shell、PowerShell、命令和参数。
- 熟练使用绝对路径、相对路径、当前目录和父目录。
- 理解标准输入、标准输出、错误输出、管道和重定向。
- 准确理解环境变量、PATH 以及命令查找过程。
- 理解前台程序、后台程序、服务、监听和端口。
- 学会阅读错误信息、检查退出码和查看基础日志。
- 建立一套可重复使用的基础排错流程。

## Day 08（Week 02 · Day 01）

### 主题

终端、Shell、PowerShell、命令与参数。

### 核心问题

```text
我在终端中输入一条命令并按下 Enter 后，电脑是怎样理解并执行它的？
```

### 核心词

- 终端（Terminal）
- Shell
- PowerShell
- 命令（Command）
- 参数（Parameter / Argument）

### 动手任务

```powershell
$PSVersionTable.PSVersion
Get-Location
Get-Command Get-ChildItem
Get-Command java
Get-Help Get-ChildItem -Examples
Get-ChildItem -Path . -File
java -version
```

重点观察：

- 终端和 PowerShell 为什么不是同一个东西。
- PowerShell 内置命令和外部 `.exe` 的区别。
- 命令名、参数名和参数值怎样组合。
- `Get-Command` 与 `Get-Help` 分别解决什么问题。

### 验收重点

- 能拆解 `Get-ChildItem -Path . -File`。
- 能说明输入 `java -version` 后发生了什么。
- 能解释 PATH 在外部命令查找中的作用。

### 文件

- 学习任务：`day-08-study-task.md`
- 正式笔记建议：`notes/day-08-terminal-shell-powershell-command-parameter.md`
- 练习目录建议：`practice/day-08/`

## Day 09（Week 02 · Day 02）

### 主题

文件系统、绝对路径、相对路径、当前目录与父目录。

### 核心问题

```text
同一个文件为什么既可以用完整路径找到，也可以用较短的相对路径找到？
```

### 核心词

- 文件系统（File System）
- 绝对路径（Absolute Path）
- 相对路径（Relative Path）
- 当前目录（Current Directory）
- 父目录（Parent Directory）

### 动手任务

```powershell
Get-Location
Get-ChildItem .
Get-ChildItem ..
Set-Location ..
Set-Location .\day-07
Resolve-Path .
Resolve-Path ..
Test-Path .\outputs\day-08-study-task.md
```

重点观察：

- `.`、`..`、`\` 分别表示什么。
- 相对路径为什么依赖当前目录。
- `Resolve-Path` 怎样把相对路径转换为完整路径。
- 路径存在和路径可访问为什么不是同一件事。

### 验收重点

- 能区分绝对路径和相对路径。
- 能根据当前目录判断 `.` 和 `..` 指向哪里。
- 能解释“工作目录不存在”或“找不到路径”的原因。

## Day 10（Week 02 · Day 03）

### 主题

标准输入、标准输出、错误输出、管道与重定向。

### 核心问题

```text
命令产生的结果去了哪里，又怎样把一个命令的结果交给另一个命令？
```

### 核心词

- 标准输入（Standard Input）
- 标准输出（Standard Output）
- 错误输出（Standard Error）
- 管道（Pipeline）
- 重定向（Redirection）

### 动手任务

```powershell
Write-Output "hello"
Get-ChildItem | Select-Object Name
Get-ChildItem | Where-Object Length -GT 0
Get-ChildItem | Out-File .\work\file-list.txt
Get-Content .\work\file-list.txt
```

再故意输入一个不存在的命令，观察正常结果与错误信息的区别。

重点观察：

- `|` 左边的输出怎样成为右边的输入。
- 终端显示内容与写入文件有什么不同。
- PowerShell 管道传递对象，初学阶段先理解为“把结果交给下一步”。

### 验收重点

- 能说明输入、输出和错误输出的区别。
- 能解释管道和重定向分别解决什么问题。
- 能读懂一条包含 `|` 的简单命令。

## Day 11（Week 02 · Day 04）

### 主题

环境变量、PATH、作用范围、配置与命令查找。

### 核心问题

```text
为什么同一条命令在一台电脑上能运行，换一台电脑却可能提示找不到？
```

### 核心词

- 环境变量（Environment Variable）
- PATH
- 变量值（Value）
- 作用范围（Scope）
- 命令查找（Command Resolution）

### 动手任务

```powershell
$env:PATH
$env:JAVA_HOME
[Environment]::GetEnvironmentVariable('PATH', 'User')
[Environment]::GetEnvironmentVariable('PATH', 'Machine')
Get-Command java
where.exe java
```

只观察，不修改系统或用户环境变量。

重点观察：

- PATH 本身就是一个环境变量。
- PATH 的值由多个目录组成。
- 用户级与系统级配置可能不同。
- 安装了软件，不代表 Shell 一定能找到它。

### 验收重点

- 能完整说明 PowerShell 怎样找到 `java.exe`。
- 能区分安装路径、JAVA_HOME 和 PATH。
- 能提出“命令不存在”时的基础检查步骤。

## Day 12（Week 02 · Day 05）

### 主题

前台程序、后台程序、服务、监听与本机端口。

### 核心问题

```text
为什么有些程序关掉窗口就结束，而有些服务能一直在后台等待请求？
```

### 核心词

- 前台程序（Foreground Program）
- 后台程序（Background Program）
- 服务（Service）
- 监听（Listen）
- 本地主机（localhost）

### 动手任务

```powershell
Get-Process
Get-Service | Select-Object -First 10
Get-NetTCPConnection -State Listen | Select-Object -First 10
```

可选：启动一个简单的本地 HTTP 服务，再观察它监听的端口。只在学习目录中操作，完成后主动停止服务。

重点观察：

- 进程和服务有什么关系。
- “监听端口”为什么表示正在等待连接。
- `localhost` 为什么代表当前电脑。
- 关闭窗口、停止进程和停止服务有什么区别。

### 验收重点

- 能说明前台程序和后台程序的区别。
- 能解释服务、进程、监听和端口之间的关系。
- 能说明 `localhost:端口` 表示什么。

## Day 13（Week 02 · Day 06）

### 主题

错误信息、退出码、日志与基础排错流程。

### 核心问题

```text
命令执行失败时，我应该从哪里开始查，而不是盲目重试？
```

### 核心词

- 错误信息（Error Message）
- 退出码（Exit Code）
- 日志（Log）
- 复现（Reproduce）
- 排错（Troubleshooting）

### 动手任务

故意制造并观察三类安全错误：

```powershell
Get-ChildItem .\not-exist-folder
not-a-real-command
java NotExistClass
$LASTEXITCODE
```

按固定流程记录：

```text
我执行了什么
    → 完整错误是什么
    → 哪个关键词最重要
    → 当前路径和环境是什么
    → 最可能的原因是什么
    → 我怎样验证这个原因
```

重点观察：

- 路径不存在、命令不存在和 Java 类不存在是三类不同问题。
- 错误信息中的路径、命令名和异常名通常是线索。
- PowerShell 命令与外部程序的退出状态表现可能不同，今天只建立初步认识。

### 验收重点

- 能保留并复述完整错误，而不是只说“报错了”。
- 能区分问题现象、可能原因和验证步骤。
- 能使用固定流程排查一个简单错误。

## Day 14（Week 02 · Day 07）

### 主题

第二周复盘：从输入命令到排查失败。

### 核心问题

```text
我能否独立执行、理解并排查一条基础命令？
```

### 复盘任务

1. 闭卷写出 Day 08～Day 13 的主题与关键词。
2. 画出命令执行总流程：

```text
终端输入
    → Shell 解析命令和参数
    → 内置命令或 PATH 查找外部程序
    → 操作系统创建或调用进程
    → 程序接收输入并执行
    → 产生正常输出或错误输出
    → 通过终端、管道、文件或日志查看结果
```

3. 完成一次综合练习：

```powershell
Get-Location
Get-Command java
java -version
Get-ChildItem -Path . -File | Select-Object Name
Get-ChildItem -Path . -File | Out-File .\work\week-02-files.txt
Get-Content .\work\week-02-files.txt
```

4. 故意输入错误路径或错误命令，按 Day 13 流程完成排错记录。
5. 整理本周技术词典，找出最薄弱的 3 个词。

### 周验收重点

- 能区分终端、Shell、PowerShell、命令和参数。
- 能正确使用绝对路径与相对路径。
- 能解释管道、重定向、PATH 和命令查找。
- 能解释前台程序、后台程序、服务与监听端口。
- 能按固定步骤排查路径不存在或命令不存在的问题。

### Week 02 通过标准

- 综合验收达到 80 分。
- 六天动手练习至少完成五天。
- 技术词典新增或修订不少于 20 个词。
- 能独立完成一份包含“命令、结果、错误、原因、验证”的排错记录。

## 每日统一学习结构

除 Day 14 外，每天采用：

1. 前一天复习：15 分钟。
2. 概念理解：45～50 分钟。
3. 核心关系或生活类比：25～30 分钟。
4. 动手练习：60 分钟。
5. 技术词典：25～30 分钟。
6. 今日笔记：30 分钟。
7. 验收测试：30～40 分钟。
8. 复盘：10～15 分钟。

## 每日统一产出

- 5 个左右技术词解释。
- 1 份命令或操作练习记录。
- 1 份今日笔记。
- 1 份验收答案。
- 1 段简短复盘。

## Week 02 最终成果

- [ ] Day 08～Day 13 六份学习笔记。
- [ ] Day 08～Day 13 六份操作练习或排错记录。
- [ ] 技术词典新增或修订至少 20 个词。
- [ ] 一张命令执行完整流程图。
- [ ] 一份 Week 02 周总结与验收结果。

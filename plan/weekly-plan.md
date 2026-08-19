# Week 04 学习计划：操作系统资源与程序运行收尾

周期：Day 22～Day 28  
计划开始：2026-08-05  
当前阶段：Month 01——计算机导论与操作系统入门  
建议学习时间：每天 3～4 小时，Day 28 为 2～3 小时

## 编号规则

- 全程使用连续编号：Day 22、Day 23……
- Week 04 · Day 01 只表示周内位置，不用于文件夹主编号。
- 进入新周或新月时不重置 Day，避免笔记、练习和验收文件重名。

## 本周定位

Week 03 解决的是：把程序启动、运行条件、开发环境、本地服务、监听端口、localhost 访问失败和综合排错串成一条链路。

Week 04 解决的是：回到操作系统基础，把 CPU、内存、硬盘、进程、资源管理、文件读写和程序运行条件再补扎实，为 Month 02 的 Java 基础学习做收尾准备。

本周暂不进入：

- Java 变量、判断、循环等语法。
- Spring Boot、数据库、Vue、鸿蒙页面开发。
- Git 分支、合并、提交和 GitHub 协作。
- 操作系统内核源码、线程调度、虚拟内存、页表等底层细节。

## 本周目标

- 能区分 CPU、内存、硬盘和操作系统的职责。
- 能解释程序文件从硬盘进入运行状态时，操作系统如何创建进程并分配资源。
- 能理解进程 ID、CPU 占用、内存占用和硬盘存储不是同一类概念。
- 能把 Day15～Day21 的程序启动链路接到操作系统资源管理模型上。
- 能继续用安全的 PowerShell 命令观察进程、资源和本地服务。
- 能形成 Month01 收尾复习清单，为 Java 编程基础做准备。

## Day 22（Week 04 · Day 01）

### 主题

操作系统如何管理程序运行：CPU、内存、硬盘、程序文件与进程之间的关系。

### 核心问题

```text
一个程序从硬盘上的文件变成正在运行的进程时，CPU、内存、硬盘和操作系统分别做了什么？
```

### 核心词

- CPU
- Memory / RAM
- Disk / Hard Drive / SSD
- Operating System
- Program File
- Process
- Process ID / PID
- Working Set
- Resource

### 动手任务

```powershell
Get-Location
Get-Process | Select-Object -First 10
Get-Process | Sort-Object CPU -Descending | Select-Object -First 10 Name,Id,CPU,WorkingSet
Get-Process | Sort-Object WorkingSet -Descending | Select-Object -First 10 Name,Id,CPU,WorkingSet
Get-CimInstance Win32_OperatingSystem | Select-Object TotalVisibleMemorySize,FreePhysicalMemory
Get-Volume
Get-Command java
java -version
Get-NetTCPConnection -State Listen | Select-Object -First 10 LocalAddress,LocalPort,State,OwningProcess
```

重点观察：

- `Get-Process` 看到的是正在运行的进程，不是硬盘上的程序文件列表。
- `Id` 是进程编号，帮助操作系统和用户区分不同进程。
- `CPU` 反映进程使用 CPU 的累计情况，不代表程序文件大小。
- `WorkingSet` 可以粗略理解为进程当前占用的一部分物理内存。
- 硬盘容量和内存容量不是同一个概念。
- `java -version` 会启动 Java 程序并输出版本信息。
- `Get-Command java` 是查看 Shell 能不能找到 Java 命令的位置。

### 验收重点

- 能区分 CPU、内存、硬盘和操作系统的职责。
- 能清楚区分程序文件和进程。
- 能解释为什么程序运行不是“文件自己动起来”。
- 能把 Day15 到 Day21 学过的程序启动、进程、本地服务和今天的操作系统资源关系连接起来。

### 文件

- 正式笔记：`notes/day-22-cpu-memory-disk-os-process.md`
- 练习笔记：`practice/day-22/笔记.md`
- 练习答案：`practice/day-22/answer/练习答案.md`
- 验收整理：`practice/day-22/answer/验收整理.md`

## Day 23（Week 04 · Day 02）

### 主题

文件读写与程序输入输出：程序如何从文件、终端和网络获得数据。

### 核心问题

```text
程序运行时的数据从哪里来，又会被输出到哪里？
```

### 核心词

- Input
- Output
- File Input
- File Output
- Read
- Write
- Append
- Standard Input
- Standard Output
- Standard Error
- Pipeline
- Redirection
- Data Flow

### 动手任务

```powershell
Get-Location
New-Item -ItemType Directory -Force .\practice\day-23
Set-Content .\practice\day-23\input.txt "hello day 23"
Get-Content .\practice\day-23\input.txt
Write-Output "this is terminal output"
Write-Output "this is file output" | Out-File .\practice\day-23\output.txt
Get-Content .\practice\day-23\output.txt
Add-Content .\practice\day-23\output.txt "second line"
Get-Content .\practice\day-23\output.txt
Get-Content .\practice\day-23\output.txt | Select-Object -First 1
Get-Content .\practice\day-23\output.txt | Measure-Object -Line
Get-Content .\practice\day-23\not-exist.txt
```

重点观察：

- `Get-Content` 是读取文件内容。
- `Set-Content` 是覆盖写入文件。
- `Add-Content` 是追加写入文件。
- `Write-Output` 默认把内容输出到终端或管道。
- `Out-File` 可以把输出写入文件。
- 管道 `|` 可以把一个命令的输出交给下一个命令。
- 文件在硬盘上，不等于程序已经读到了文件内容。
- 终端显示内容，不等于内容已经保存进文件。
- 错误信息也是一种输出线索，但它和正常输出不同。

### 验收重点

- 能区分输入和输出。
- 能区分文件输入、终端输入和网络输入。
- 能区分终端输出、文件输出和错误输出。
- 能解释 `Get-Content`、`Set-Content`、`Add-Content`、`Out-File` 的基本作用。
- 能把 Day10 的标准输入输出、管道、重定向和 Day22 的硬盘、内存、进程关系连接起来。

### 文件

- 正式笔记：`notes/day-23-file-input-output.md`
- 练习笔记：`practice/day-23/笔记.md`
- 练习答案：`practice/day-23/answer/练习答案.md`
- 验收整理：`practice/day-23/answer/验收整理.md`

## Day 24（Week 04 · Day 03）

### 主题

操作系统权限、用户和进程访问资源。

### 核心问题

```text
为什么文件或端口明明存在，程序却可能没有权限访问？
```

### 核心词

- User
- Current User
- Administrator
- Permission
- Resource
- File Permission
- Access
- Denied
- Read Permission
- Write Permission
- Process Identity
- Security Rule
- System Directory
- Permission Error

### 动手任务

```powershell
Get-Location
New-Item -ItemType Directory -Force .\practice\day-24
whoami
Get-ChildItem .\practice\day-24
Set-Content .\practice\day-24\permission-demo.txt "day 24 permission demo"
Get-Content .\practice\day-24\permission-demo.txt
Get-Item .\practice\day-24\permission-demo.txt | Select-Object FullName,Length,Attributes,LastWriteTime
Get-Content .\practice\day-24\not-exist.txt
Get-ChildItem C:\Windows | Select-Object -First 5 Name,Mode,LastWriteTime
Set-Content .\practice\day-24\write-test.txt "write ok"
Get-Content .\practice\day-24\write-test.txt
Get-NetTCPConnection -State Listen | Select-Object -First 10 LocalAddress,LocalPort,State,OwningProcess
Get-Process -Id 进程ID
```

重点观察：

- `whoami` 显示当前用户。
- 当前用户能读写学习目录，不代表能读写所有系统目录。
- 文件存在、路径正确、用户有权限，是不同条件。
- `Get-Content` 失败时，要看是路径不存在、权限不足，还是其他错误。
- 程序或命令以某个用户身份运行，访问资源时会受到权限限制。
- `OwningProcess` 仍然是占用端口的进程 ID。
- 进程存在、端口监听、访问成功是不同层次。

### 验收重点

- 能解释用户、进程、资源、权限的基本关系。
- 能区分文件存在、路径正确、权限允许。
- 能区分读取权限和写入权限。
- 能说明权限错误和路径不存在不是同一类问题。
- 能把 Day22 的操作系统资源管理、Day23 的文件读写和 Week03 的服务访问失败排查连接起来。

### 文件

- 正式笔记：`notes/day-24-user-permission-process-resource.md`
- 练习笔记：`practice/day-24/笔记.md`
- 练习答案：`practice/day-24/answer/练习答案.md`
- 验收整理：`practice/day-24/answer/验收整理.md`

## Day 25（Week 04 · Day 04，待学习）

### 预备主题

安装、配置、环境变量和开发工具的综合复习。

### 预备核心问题

```text
为什么软件安装好了，项目仍然可能因为配置或环境不正确而运行失败？
```

## Day 26（Week 04 · Day 05，待学习）

### 预备主题

从命令行到 IDE：同一个项目为什么可以用不同入口启动。

### 预备核心问题

```text
命令行启动和 IDE 启动项目时，哪些步骤相同，哪些条件可能不同？
```

## Day 27（Week 04 · Day 06，待学习）

### 预备主题

Month01 综合排错训练：从现象到证据再到结论。

### 预备核心问题

```text
面对一个本地项目启动或访问失败的问题，我能否按固定流程独立排查？
```

## Day 28（Week 04 · Day 07，待学习）

### 预备主题

Month01 月末复盘：计算机基础、操作系统和本地开发环境总验收。

### 预备核心问题

```text
我是否已经准备好进入 Month02 的 Java 编程基本功？
```

## 每日统一产出

- 5 个左右技术词解释。
- 1 份命令或操作练习记录。
- 1 份今日笔记。
- 1 份验收答案。
- 1 段简短复盘。

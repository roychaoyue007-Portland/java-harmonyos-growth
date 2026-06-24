# Day 08 学习任务：终端、Shell、PowerShell、命令与参数

日期：2026-06-23  
周内位置：Week 02 · Day 01  
建议学习时长：3～3.5 小时  
当前阶段：Month 01——计算机导论与操作系统入门

今天不学习 Java 语法、Spring Boot、数据库、Git 分支、复杂脚本或 PowerShell 管道。

今天只解决一个问题：

```text
我在终端中输入一条命令并按下 Enter 后，电脑是怎样理解并执行它的？
```

## 今日目标

- 能区分终端、Shell 和 PowerShell。
- 能从一条命令中找出命令名、参数名和参数值。
- 能说明 PowerShell 如何通过命令自身或 PATH 找到程序。
- 能区分 PowerShell 内置命令和外部程序。
- 能使用 `Get-Command`、`Get-Help` 主动调查陌生命令。

## 阶段 1：闭卷复习，15 分钟

先不要看 Day 07 笔记，用自己的话回答：

1. PATH 是什么？
2. 输入 `java` 时，系统为什么能找到 `java.exe`？
3. 路径和 PATH 是同一个概念吗？为什么？

如果第 1、2 题仍说不清，先记住：

```text
PATH 是一个环境变量，它保存了一串目录。
输入外部命令后，系统可以到 PATH 所列目录中寻找对应程序。
```

## 阶段 2：概念理解，50 分钟

理解 5 个基础词：

### 1. 终端（Terminal）

- 它是什么：显示命令和结果、接收键盘输入的交互界面。
- 它解决什么问题：让用户能够通过文字与 Shell 交互。
- 一个例子：Windows Terminal 或 Codex 内置终端面板。

### 2. Shell

- 它是什么：读取、解析并执行命令的程序。
- 它解决什么问题：把用户输入的文字转换为具体操作。
- 一个例子：PowerShell、Command Prompt、Bash。

### 3. PowerShell

- 它是什么：Windows 上常用的一种 Shell，同时也是脚本环境。
- 它解决什么问题：执行命令、管理文件和系统、运行脚本。
- 一个例子：看到提示符 `PS C:\Users\roych>`，通常表示当前正在使用 PowerShell。

### 4. 命令（Command）

- 它是什么：告诉 Shell 要执行什么动作的名称。
- 它解决什么问题：明确本次要做的事情。
- 一个例子：`Get-ChildItem` 表示查看目录内容，`java` 表示启动 Java 程序。

### 5. 参数（Parameter / Argument）

- 它是什么：跟在命令后面的附加信息，用来指定对象、范围或执行方式。
- 它解决什么问题：让同一个命令能够完成不同的具体任务。
- 一个例子：`Get-ChildItem -Path . -File` 中，`-Path` 和 `-File` 是参数。

重点区分：

```text
终端：负责显示和输入
Shell：负责理解和执行命令
PowerShell：一种具体的 Shell
命令：要做什么
参数：具体怎么做、对谁做
```

## 阶段 3：核心流程与类比，30 分钟

### 命令执行流程

```text
用户在终端输入命令
    → 终端把文字交给 PowerShell
    → PowerShell 拆分命令名和参数
    → PowerShell 判断它是内置命令、别名、脚本还是外部程序
    → 如果是外部程序，可通过当前目录或 PATH 查找
    → 找到后执行命令
    → 把结果或错误显示在终端中
```

### 生活类比

把终端想成餐厅前台，把 Shell 想成听懂订单的服务员：

- 终端：你说话和看到结果的窗口。
- Shell：听懂并处理订单的人。
- 命令：你要点什么，例如“来一杯咖啡”。
- 参数：具体要求，例如“大杯、无糖”。
- PATH：服务员寻找工具或材料时使用的地点清单。

请用自己的生活类比再解释一次，不能照抄上面的餐厅例子。

## 阶段 4：PowerShell 动手观察，60 分钟

### 任务 A：确认终端中的 Shell

执行：

```powershell
$PSVersionTable.PSVersion
Get-Location
```

记录：

- PowerShell 版本：__________
- 当前路径：__________
- 终端和 PowerShell 是不是同一个东西？为什么？

### 任务 B：调查两类命令

执行：

```powershell
Get-Command Get-ChildItem
Get-Command java
Get-Command javac
```

观察 `CommandType` 和 `Source`，回答：

1. `Get-ChildItem` 属于 PowerShell 命令还是外部程序？
2. `java` 和 `javac` 属于什么类型？
3. `Get-Command java` 显示的路径在哪里？
4. 这个路径和 PATH 有什么关系？

### 任务 C：观察参数怎样改变结果

在当前学习目录执行：

```powershell
Get-ChildItem
Get-ChildItem -Path .
Get-ChildItem -Path . -File
Get-ChildItem -Path . -Directory
```

回答：

1. `Get-ChildItem` 是命令名还是参数？
2. `-Path` 是什么？`.` 表示什么？
3. `-File` 和 `-Directory` 怎样改变结果？
4. 不写 `-Path .` 时为什么仍能执行？

### 任务 D：学会主动查帮助

执行：

```powershell
Get-Help Get-ChildItem
Get-Help Get-ChildItem -Examples
Get-Help Get-Command -Examples
```

记录一个你能看懂的官方示例，并用中文解释它做了什么。

### 任务 E：拆解外部命令

观察：

```powershell
java -version
javac -version
```

说明：

- `java` / `javac`：__________
- `-version`：__________
- PowerShell 怎样找到对应的 `.exe`：__________

## 阶段 5：技术词典，25 分钟

把下面 5 个词加入技术词典：

- 终端（Terminal）
- Shell
- PowerShell
- 命令（Command）
- 参数（Parameter / Argument）

每个词按下面格式整理：

```text
词：
一句话解释：
它解决什么问题：
我在哪里会遇到：
相关词：
我是否亲手观察过：
```

## 阶段 6：今日笔记，30 分钟

用自己的话回答：

1. 终端是什么？
2. Shell 是什么？
3. PowerShell 和终端有什么区别？
4. 命令与参数有什么区别？
5. PowerShell 怎样判断一条命令是什么类型？
6. PowerShell 怎样找到 `java.exe`？
7. `Get-Command` 和 `Get-Help` 分别解决什么问题？
8. 从输入命令到看到结果，中间大致发生了什么？

## 阶段 7：验收测试，30～40 分钟

闭卷回答，每题 10 分：

1. 终端和 Shell 有什么区别？各举一个例子。
2. PowerShell 是终端、Shell，还是操作系统？为什么？
3. 请拆解 `Get-ChildItem -Path . -File` 中的命令、参数和参数值。
4. `Get-Command java` 可以帮助你查到什么？
5. `Get-Help Get-ChildItem -Examples` 可以帮助你做什么？
6. PowerShell 内置命令和 `java.exe` 这种外部程序有什么区别？
7. PATH 在执行外部命令时起什么作用？
8. 输入 `java -version` 并按下 Enter 后，大致经历了什么？

评分标准：

- 64～80：通过。
- 48～63：补错题后再测。
- 48 以下：重新学习概念与动手观察阶段。

## 阶段 8：复盘，10～15 分钟

写下：

- 今天我学会了：__________
- 今天我还不懂：__________
- 今天最重要的关系：__________
- 今天最有用的命令：__________
- 明天我想继续补：__________

## 今日产出

- [ ] 一份 PowerShell 命令观察记录。
- [ ] 5 个技术词典条目。
- [ ] 一份今日笔记。
- [ ] 8 道验收题答案。
- [ ] 一段自己的生活类比。

## 今日通过标准

- [ ] 能准确区分终端、Shell 和 PowerShell。
- [ ] 能正确拆解命令、参数和参数值。
- [ ] 能解释 PATH 如何帮助查找外部程序。
- [ ] 能用 `Get-Command` 调查命令类型和位置。
- [ ] 能用 `Get-Help` 查看命令用法与示例。
- [ ] 验收测试达到 64 / 80。

## 最终记忆版

```text
终端负责接收输入和显示结果。
Shell 负责读取、解析并执行命令。
PowerShell 是 Windows 上常用的一种 Shell。
命令说明要做什么，参数说明具体怎么做。
执行外部命令时，PATH 可以帮助系统找到对应程序。
Get-Command 用来调查命令，Get-Help 用来学习命令。
```

https://chatgpt.com/share/6a3bf15a-97bc-83ea-912a-436a029e20fe
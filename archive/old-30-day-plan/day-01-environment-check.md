# Day 01 - 开发环境检查

今天检查到当前环境缺少两个关键命令：

- `git`：用于版本管理
- `javac`：用于编译 Java 代码，通常来自 JDK

## 为什么这很重要

Java 程序员至少需要能在命令行确认这些工具：

```bash
java -version
javac -version
git --version
```

如果这些命令不能正常输出版本号，说明环境还没有配置好。

## Java、JDK、JRE 的区别

- JDK：Java Development Kit，Java 开发工具包，包含 `javac`
- JRE：Java Runtime Environment，Java 运行环境，只能运行 Java 程序
- JVM：Java Virtual Machine，Java 虚拟机，负责执行字节码

简单理解：

- 写 Java 程序需要 JDK
- 运行 Java 程序需要 JRE / JVM
- 编译 `.java` 文件需要 `javac`

## Git 的作用

Git 用来记录代码变化。

常见流程：

```bash
git init
git add .
git commit -m "first commit"
git status
```

## 我的待办

- [ ] 安装 JDK
- [ ] 配置 `JAVA_HOME`
- [ ] 确认 `java -version`
- [ ] 确认 `javac -version`
- [ ] 安装 Git
- [ ] 确认 `git --version`
- [ ] 给 `java-harmonyos-growth` 做第一次提交


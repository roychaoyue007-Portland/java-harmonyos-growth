# Codex Workflow Rules

用途：记录 Codex 在本项目中必须遵守的长期工作规则，避免重复出现提示词不可直接复制、归档文件不全、路径写错、内容冗余等问题。

## 1. 项目根目录识别规则

主项目根目录不能写死盘符。以当前机器上检出的 `java-harmonyos-growth` 仓库根目录为准。

识别标准：该目录必须同时包含：

```text
README.md
plan/current-plan.md
plan/weekly-plan.md
dictionary/tech-dictionary.md
english/vocabulary.md
```

如果存在多个同名目录，只有满足上述标记文件且与当前 Git 仓库一致的目录可以作为主项目。

不要把正式学习归档写到：

- 临时线程目录。
- 历史副本。
- 仅仅名字相似但不包含上述标记文件的目录。
- `archive/old-30-day-plan/`，除非用户明确要求查看旧计划。

## 2. ChatGPT Prompt 直接复制规则

当用户要求生成“Day XX 学习计划”“ChatGPT 提示词”“直接复制内容”“全部复制内容”时，Codex 必须输出可以一次性复制到 ChatGPT 的内容。

规则：

1. 只输出一个 `text` 代码块。
2. 完整提示词必须全部放在同一个代码块里。
3. 代码块外不能有说明、寒暄、链接、总结或后续建议。
4. 提示词内部不要再使用三反引号代码块，避免复制时断开。
5. 命令和示例使用普通文本、缩进、或“命令：”“示例：”标识。
6. 必须覆盖 `plan/weekly-plan.md` 中当天的主题、核心问题、核心词、动手任务、重点观察和验收重点。

对应本地 skill：

```text
fullstack-study-prompt
```

本地 skill 文件位置通常是：

```text
C:\Users\roych\.codex\skills\fullstack-study-prompt\SKILL.md
```

注意：skill 文件属于本机 Codex 配置，不属于项目仓库；项目内只保存本规则文档和提示词模板。


## 3. 继续触发词规则

生成给 ChatGPT 的学习提示词时，必须让 ChatGPT 接受多种继续信号，而不是只接受“继续”。

有效继续信号包括：

```text
继续
1
开始
下一步
next
go
好的
ok
可以
继续下一阶段
```

要求：

1. 每个阶段结束后仍必须停下来。
2. 用户回复上述任意继续信号时，都可以进入下一阶段。
3. 不要要求用户只能输入“继续”。
4. 这个规则必须写进每天生成的 ChatGPT prompt。
## 4. 每天开始学习前读取规则

生成 Day XX 学习计划或提示词前，必须读取：

1. `plan/current-plan.md`
2. `plan/weekly-plan.md`
3. `dictionary/tech-dictionary.md`
4. `english/vocabulary.md`
5. 最近一天的 `notes/day-*.md`
6. 最近一天的 `practice/day-*/`

必须以 `plan/weekly-plan.md` 中当天安排为准，不得只根据聊天记忆生成。


## 5. 原始作答保留规则

每天验收、练习或复盘归档时，必须保留用户自己的原始回答。

要求：

1. `practice/day-XX/answer/验收整理.md` 必须逐题保留“原回答”。
2. `practice/day-XX/answer/练习答案.md` 如果来自用户作答，也必须先保留用户原文，再写整理版。
3. 不要用标准答案覆盖用户原回答。
4. 每题推荐结构：

```text
### 题目 N

原回答：
> 用户原文

评分：x / 10

整理：
标准或修正版解释。

需要记住：
一句最短记忆。
```

5. 如果用户原回答中有错别字、口语化表达或不完整表达，也要原样保留；修正内容写在“整理”部分。
6. 如果用户没有提供某题原回答，只能标注“未提供原回答”，不要伪造。
## 6. 验收通过后归档规则

用户完成验收并通过后，Codex 必须按 `plan/day-completion-checklist.md` 补全项目文件。

至少包含：

```text
notes/day-XX-主题英文短名.md
practice/day-XX/answer/练习答案.md
practice/day-XX/answer/验收整理.md
dictionary/tech-dictionary.md
english/vocabulary.md
```

其中：

- `dictionary/tech-dictionary.md` 是技术词典主位置。
- `english/vocabulary.md` 是英文词汇主位置。
- `notes/` 放正式每日笔记。
- `practice/day-XX/answer/` 放练习答案和验收整理。

不要额外创建这些冗余文件，除非用户明确要求：

```text
practice/day-XX/技术词典.md
english/day-XX-*.md
```

## 7. 内容完整性检查规则

写完归档后，必须对照 `plan/weekly-plan.md` 检查当天内容是否完整。

检查项：

- 主题是否一致。
- 核心问题是否覆盖。
- 核心词是否进入技术词典。
- 动手任务是否有练习答案或观察记录。
- 重点观察是否写进笔记或练习答案。
- 验收重点是否写进验收整理。
- English 是否进入 `english/vocabulary.md`。

如果 weekly plan 中的关键词没有出现在当天归档里，必须先补齐，再汇报完成。

## 8. 路径和冗余检查规则

最终汇报前，必须确认：

```text
notes/day-XX-*.md 存在
practice/day-XX/answer/练习答案.md 存在
practice/day-XX/answer/验收整理.md 存在
dictionary/tech-dictionary.md 包含 ## Day XX
english/vocabulary.md 包含 ## Day XX
```

并确认没有无意生成的冗余文件：

```text
practice/day-XX/技术词典.md
english/day-XX-*.md
```

如果发现冗余，应删除或说明为什么保留。

## 9. 最终汇报规则

最终回复必须简短说明：

- 实际识别到的项目根目录。
- 写入或修改了哪些项目文件。
- 是否删除或避免了冗余文件。
- 已覆盖 weekly plan 的哪些要求。
- 如果已提交或推送，给出 commit hash。

不要只说“好了”。



# Day Completion Checklist

用途：每天学习验收通过后，Codex 必须按这个清单补全项目文件，避免漏文件、写错目录或生成冗余内容。长期规则见 `plan/codex-workflow-rules.md`。

## 0. 权威项目根目录

主项目根目录不能写死盘符。以当前机器上检出的 `java-harmonyos-growth` 仓库根目录为准。

识别标准：该目录必须同时包含：

```text
README.md
plan/current-plan.md
plan/weekly-plan.md
dictionary/tech-dictionary.md
english/vocabulary.md
```

在命令示例中，用 `$PROJECT_ROOT` 表示当前机器上的实际项目根目录。

禁止把正式学习归档写到临时线程目录、旧副本、或仅仅名字相似但不包含上述项目标记文件的目录。

## 1. 开始补全前必须读取

每次生成 Day XX 归档前，先从 `$PROJECT_ROOT` 读取：

1. `plan/current-plan.md`
2. `plan/weekly-plan.md`
3. `dictionary/tech-dictionary.md`
4. `english/vocabulary.md`
5. 前一天的 `notes/day-XX-*.md`
6. 前一天的 `practice/day-XX/`

必须从 `plan/weekly-plan.md` 提取当天的：

- 主题
- 核心问题
- 核心词
- 动手任务
- 重点观察
- 验收重点

不得只根据聊天记忆补文件。

## 2. Prompt 生成检查

当用户要“生成 Day XX 学习计划 / ChatGPT 提示词 / 可直接复制内容”时：

- 只输出一个 `text` 代码块。
- 代码块外不写任何解释。
- 提示词必须完整放在同一个代码块里。
- 提示词内部不要使用三反引号代码块。
- 必须覆盖 weekly plan 里的动手任务、重点观察、验收重点。

## 3. 验收通过后必需文件

验收通过后，至少补齐：

```text
notes/day-XX-主题英文短名.md
practice/day-XX/answer/练习答案.md
practice/day-XX/answer/验收整理.md
dictionary/tech-dictionary.md
english/vocabulary.md
```

说明：

- `dictionary/tech-dictionary.md` 是技术词典主位置。
- `english/vocabulary.md` 是英文词汇主位置。
- 不要额外创建每日单独技术词典文件，除非用户明确要求。
- 不要额外创建每日单独 English 文件，除非用户明确要求。


## 4. 原始作答保留检查

写 `练习答案.md` 和 `验收整理.md` 时，必须保留用户自己的原始回答。

检查项：

- 验收整理是否包含每题“原回答”。
- 原回答是否尽量保留用户原文，而不是被改写成标准答案。
- 每题是否有“评分 / 整理 / 需要记住”之类的后续修正。
- 用户没有提供原回答的题目，是否明确标注“未提供原回答”。

推荐结构：

```text
### 题目 N

原回答：
> 用户原文

评分：x / 10

整理：
修正后的理解。
```
## 5. 内容完整性检查

写完后必须检查当天 weekly plan 中的每个要求都已覆盖。

检查方式：

1. 从 `plan/weekly-plan.md` 找出 Day XX 的核心词、动手任务、重点观察、验收重点。
2. 在当天 notes、practice answer、acceptance、dictionary、english 中搜索这些关键词。
3. 如果某个关键词没有出现，先补内容，再告诉用户完成。

## 6. 路径和冗余检查

写完后必须执行检查。示例命令中的 `$PROJECT_ROOT` 需要先替换为当前机器上的实际项目根目录：

```powershell
Test-Path $PROJECT_ROOT
Get-ChildItem "$PROJECT_ROOT\notes" -Filter "day-XX*"
Get-ChildItem "$PROJECT_ROOT\practice\day-XX" -Recurse
Select-String -Path "$PROJECT_ROOT\dictionary\tech-dictionary.md" -Pattern "## Day XX"
Select-String -Path "$PROJECT_ROOT\english\vocabulary.md" -Pattern "## Day XX"
```

还要确认没有这些冗余：

```text
practice/day-XX/技术词典.md
english/day-XX-*.md
```

除非用户明确要求保留每日独立文件。

## 7. 最终汇报格式

最终回复必须简短说明：

- 实际识别到的项目根目录。
- 补齐了哪些文件。
- 删除或避免了哪些冗余。
- 哪些 weekly plan 要求已覆盖。

不要只说“好了”。必须给出可核对的相对路径或实际路径。



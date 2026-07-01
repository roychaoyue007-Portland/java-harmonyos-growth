# 日程管理卡片 - HarmonyOS NEXT 服务卡片

基于 HarmonyOS NEXT (API 12+) 的服务卡片（Form/Service Widget）示例项目，使用 ArkTS + ArkUI 声明式 UI 开发。

## 项目概述

本项目实现了一个"今日日程"桌面服务卡片，用户可以将其添加到手机桌面、负一屏等位置，快速浏览日程安排。

## 功能特性

### 信息展示
- 标题、内容摘要、时间、优先级标签
- 今日日期和星期显示
- 完成进度统计（4x4 大卡片）
- 优先级颜色指示（紧急-红、一般-黄、空闲-绿）

### 交互操作
- **分类切换按钮**：工作 / 生活 / 学习，点击切换展示不同分类日程
- **上下滑动浏览**：4x4 大卡片使用 List 组件，支持手势滑动查看全部日程
- **点击跳转**：点击卡片或日程条目跳转主应用详情页
- **刷新按钮**：手动触发数据刷新

### 多尺寸适配
| 尺寸 | 尺寸名称 | 展示内容 |
|------|----------|----------|
| 2*2 | 小卡片 | 日期 + 分类标签 + 1条日程摘要 |
| 2*4 | 中卡片（默认） | 日期 + 分类按钮 + 3条日程列表 |
| 4*4 | 大卡片 | 完整标题 + 分类按钮 + 可滑动日程列表 + 刷新 |

## 项目结构

```
ScheduleCard/
├── AppScope/                          # 应用级配置
├── build-profile.json5                # 项目构建配置
├── oh-package.json5                   # 项目依赖配置
├── hvigorfile.ts                      # Hvigor 构建脚本
└── entry/                             # 入口模块
    ├── build-profile.json5            # 模块构建配置
    ├── oh-package.json5               # 模块依赖配置
    ├── hvigorfile.ts                  # 模块构建脚本
    └── src/main/
        ├── module.json5               # 模块配置（abilities + extensionAbilities）
        ├── ets/
        │   ├── common/
        │   │   └── ScheduleData.ets   # 公共数据模型和工具函数
        │   ├── entryability/
        │   │   └── EntryAbility.ets   # 主应用 UIAbility
        │   ├── formextension/
        │   │   └── ScheduleFormAbility.ets  # 卡片 FormExtensionAbility
        │   └── pages/
        │       ├── Index.ets          # 主应用页面
        │       ├── ScheduleCard2x2.ets # 2x2 小卡片
        │       ├── ScheduleCard2x4.ets # 2x4 中卡片
        │       └── ScheduleCard4x4.ets # 4x4 大卡片
        └── resources/
            └── base/
                ├── element/
                │   ├── color.json     # 颜色资源
                │   └── string.json    # 字符串资源
                └── profile/
                    ├── form_config.json  # 卡片配置
                    └── main_pages.json   # 页面路由配置
```

## 核心技术点

### 1. 卡片生命周期管理（ScheduleFormAbility）
- `onAddForm()`: 卡片创建时初始化数据，通过 `formBindingData.createFormBindingData()` 传递初始数据
- `onUpdateForm()`: 定时/手动更新时重新获取数据，通过 `formProvider.updateFormData()` 推送
- `onFormEvent()`: 处理卡片交互事件，解析 `postCardAction` 发送的消息

### 2. 卡片页面交互（postCardAction）
```typescript
// 发送分类切换事件
postCardAction(this, {
  action: 'form-event',
  params: { action: 'switchCategory', category: 'life' }
})

// 跳转主应用
postCardAction(this, {
  action: 'router',
  abilityName: 'EntryAbility'
})
```

### 3. 滑动列表（4x4 卡片）
使用 ArkUI `List` 组件实现上下滑动：
```typescript
List({ space: 8 }) {
  ForEach(this.currentItems, (item: ScheduleItem) => {
    ListItem() { /* 日程卡片内容 */ }
  })
}
.edgeEffect(EdgeEffect.Spring)  // 弹性回弹
.scrollBar(BarState.Off)        // 隐藏滚动条
.cachedCount(3)                 // 预加载优化
```

### 4. 数据流
```
FormExtensionAbility ──(formBindingData)──> 卡片页面 aboutToAppear()
卡片页面 ──(postCardAction)──> FormExtensionAbility onFormEvent()
FormExtensionAbility ──(updateFormData)──> 卡片页面刷新
```

## 使用方法

1. 使用 **DevEco Studio** (NEXT 版本) 打开项目
2. 确保 SDK 版本 >= 5.0.0 (API 12)
3. 同步项目依赖
4. 构建并运行到模拟器或真机
5. 在桌面长按 → 添加卡片 → 选择"今日日程"

## 自定义扩展

- **添加更多分类**：修改 `ScheduleData.ets` 中的 `CATEGORIES` 数组
- **接入真实数据**：替换 `getAllSchedules()` 为网络请求或数据库查询
- **自定义卡片样式**：修改 `color.json` 中的颜色主题
- **添加更多尺寸**：在 `form_config.json` 的 `supportDimensions` 中添加尺寸，并创建对应的页面文件
- **定时刷新**：修改 `form_config.json` 中的 `updateDuration` 和 `scheduledUpdateTime`

## 注意事项

- 卡片页面使用 `@Entry struct`，不使用 `@Component` 装饰器
- 卡片内不支持 `animateTo` 等复杂动画
- `postCardAction` 是卡片与宿主通信的唯一方式
- 4x4 卡片的 List 组件需注意内存优化，合理使用 `cachedCount`
- form_config.json 中 `src` 指向默认尺寸的页面，其他尺寸通过 `supportDimensions` 自动匹配

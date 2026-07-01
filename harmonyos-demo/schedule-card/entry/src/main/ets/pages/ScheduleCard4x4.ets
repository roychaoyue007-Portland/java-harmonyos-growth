/**
 * 日程管理卡片 - 4x4 大卡片
 *
 * 展示内容：完整的日程列表，支持上下滑动浏览
 * 交互：
 *   - 分类切换按钮（工作/生活/学习）
 *   - List 组件支持上下滑动浏览全部日程
 *   - 点击单条日程跳转主应用详情
 *   - 按钮点击通过 postCardAction 与 FormExtensionAbility 通信
 *
 * 卡片尺寸约 360×360 vp，空间充裕，可展示完整列表
 */
import {
  ScheduleItem,
  CategoryType,
  CATEGORIES,
  CategoryTab,
  getAllSchedules,
  getByCategory,
  getTodayString,
  getPriorityColor,
  PRIORITY_LABELS
} from '../common/ScheduleData'

@Entry
struct ScheduleCard4x4 {
  // 各分类日程数据
  @State workItems: ScheduleItem[] = []
  @State lifeItems: ScheduleItem[] = []
  @State studyItems: ScheduleItem[] = []
  // 当前选中分类
  @State activeCategory: CategoryType = 'work'
  // 当前分类的日程列表（驱动 List 渲染）
  @State currentItems: ScheduleItem[] = []
  // 今日日期
  @State todayDate: string = ''
  // 当前分类的统计
  @State totalCount: number = 0
  @State completedCount: number = 0

  aboutToAppear(): void {
    this.todayDate = getTodayString()
    this.loadAllData()
  }

  /**
   * 一次性加载全部分类数据
   */
  loadAllData(): void {
    const allItems: ScheduleItem[] = getAllSchedules()
    this.workItems = getByCategory(allItems, 'work')
    this.lifeItems = getByCategory(allItems, 'life')
    this.studyItems = getByCategory(allItems, 'study')
    this.updateCurrentItems()
  }

  /**
   * 更新当前分类的展示列表和统计数据
   */
  updateCurrentItems(): void {
    if (this.activeCategory === 'work') {
      this.currentItems = this.workItems
    } else if (this.activeCategory === 'life') {
      this.currentItems = this.lifeItems
    } else {
      this.currentItems = this.studyItems
    }
    this.totalCount = this.currentItems.length
    this.completedCount = this.currentItems.filter(item => item.completed).length
  }

  /**
   * 切换分类并通知 FormExtensionAbility
   */
  switchCategory(category: CategoryType): void {
    if (this.activeCategory === category) {
      return
    }
    this.activeCategory = category
    this.updateCurrentItems()

    postCardAction(this, {
      action: 'form-event',
      params: {
        action: 'switchCategory',
        category: category
      }
    })
  }

  /**
   * 获取当前分类标签名
   */
  getCurrentLabel(): string {
    for (const cat of CATEGORIES) {
      if (cat.key === this.activeCategory) {
        return cat.label
      }
    }
    return ''
  }

  build() {
    Column() {
      // ============ 顶部标题栏 ============
      Row() {
        Column({ space: 2 }) {
          Text('今日日程')
            .fontSize(18)
            .fontWeight(FontWeight.Bold)
            .fontColor('#1A1A1A')

          Text(this.todayDate)
            .fontSize(11)
            .fontColor('#999999')
        }
        .alignItems(HorizontalAlign.Start)

        Blank()

        // 完成进度
        if (this.totalCount > 0) {
          Column({ space: 2 }) {
            Text(`${this.completedCount}/${this.totalCount}`)
              .fontSize(16)
              .fontWeight(FontWeight.Bold)
              .fontColor('#0A59F7')

            Text('已完成')
              .fontSize(9)
              .fontColor('#999999')
          }
          .alignItems(HorizontalAlign.Center)
        }
      }
      .width('100%')
      .margin({ bottom: 10 })

      // ============ 分类切换按钮 ============
      Row({ space: 8 }) {
        ForEach(CATEGORIES, (tab: CategoryTab) => {
          Row({ space: 4 }) {
            Text(tab.icon)
              .fontSize(12)

            Text(tab.label)
              .fontSize(12)
              .fontColor(this.activeCategory === tab.key ? '#FFFFFF' : '#666666')
          }
          .height(28)
          .padding({ left: 12, right: 12 })
          .borderRadius(14)
          .backgroundColor(this.activeCategory === tab.key ? '#0A59F7' : '#F2F2F2')
          .onClick(() => {
            this.switchCategory(tab.key)
          })
        })
      }
      .width('100%')
      .justifyContent(FlexAlign.Start)
      .margin({ bottom: 10 })

      // ============ 日程列表（支持上下滑动） ============
      if (this.currentItems.length > 0) {
        List({ space: 8 }) {
          ForEach(this.currentItems, (item: ScheduleItem, index: number) => {
            ListItem() {
              // 单条日程卡片
              Row() {
                // 左侧：优先级色条
                Row()
                  .width(4)
                  .height(48)
                  .backgroundColor(getPriorityColor(item.priority))
                  .borderRadius(2)
                  .margin({ right: 10 })

                // 中间：日程信息
                Column({ space: 4 }) {
                  Row() {
                    // 标题
                    Text(item.title)
                      .fontSize(14)
                      .fontWeight(FontWeight.Medium)
                      .fontColor(item.completed ? '#BBBBBB' : '#1A1A1A')
                      .maxLines(1)
                      .textOverflow({ overflow: TextOverflow.Ellipsis })
                      .layoutWeight(1)
                      .decoration({
                        type: item.completed ? TextDecorationType.LineThrough : TextDecorationType.None
                      })

                    // 时间
                    Text(item.time)
                      .fontSize(11)
                      .fontColor('#999999')
                  }
                  .width('100%')

                  Row() {
                    // 摘要
                    Text(item.summary)
                      .fontSize(11)
                      .fontColor('#999999')
                      .maxLines(1)
                      .textOverflow({ overflow: TextOverflow.Ellipsis })
                      .layoutWeight(1)

                    // 优先级标签
                    Text(PRIORITY_LABELS[item.priority] ?? '')
                      .fontSize(9)
                      .fontColor(getPriorityColor(item.priority))
                      .border({
                        width: 0.5,
                        color: getPriorityColor(item.priority),
                        radius: 2
                      })
                      .padding({ left: 4, right: 4, top: 1, bottom: 1 })
                      .borderRadius(2)
                  }
                  .width('100%')
                }
                .layoutWeight(1)
                .alignItems(HorizontalAlign.Start)

                // 右侧：完成状态
                if (item.completed) {
                  Text('\u2713')
                    .fontSize(16)
                    .fontColor('#52C41A')
                    .fontWeight(FontWeight.Bold)
                    .margin({ left: 8 })
                }
              }
              .width('100%')
              .padding({ left: 8, right: 8, top: 6, bottom: 6 })
              .backgroundColor('#FAFAFA')
              .borderRadius(8)
              .onClick(() => {
                // 点击单条日程跳转详情
                postCardAction(this, {
                  action: 'router',
                  abilityName: 'EntryAbility',
                  params: {
                    action: 'viewDetail',
                    scheduleId: item.id.toString(),
                    category: this.activeCategory
                  }
                })
              })
            }
          }, (item: ScheduleItem) => item.id.toString())
        }
        .width('100%')
        .layoutWeight(1)
        .scrollBar(BarState.Off)
        .edgeEffect(EdgeEffect.Spring) // 弹性回弹效果
        .cachedCount(3) // 预加载缓存数量
      } else {
        // 空状态
        Column({ space: 8 }) {
          Text('\u{1F4CB}')
            .fontSize(36)

          Text(`${this.getCurrentLabel()}暂无日程`)
            .fontSize(14)
            .fontColor('#CCCCCC')

          Text('享受闲暇时光吧~')
            .fontSize(12)
            .fontColor('#DDDDDD')
        }
        .width('100%')
        .layoutWeight(1)
        .justifyContent(FlexAlign.Center)
      }

      // ============ 底部：刷新按钮 ============
      Row() {
        Button('\u{1F504} 刷新')
          .fontSize(10)
          .height(24)
          .padding({ left: 10, right: 10 })
          .borderRadius(12)
          .fontColor('#666666')
          .backgroundColor('#F2F2F2')
          .onClick(() => {
            // 触发全量刷新
            postCardAction(this, {
              action: 'form-event',
              params: {
                action: 'refreshAll'
              }
            })
          })

        Blank()

        Text(`共 ${this.totalCount} 项`)
          .fontSize(10)
          .fontColor('#CCCCCC')
      }
      .width('100%')
      .margin({ top: 6 })
    }
    .width('100%')
    .height('100%')
    .padding(16)
  }
}

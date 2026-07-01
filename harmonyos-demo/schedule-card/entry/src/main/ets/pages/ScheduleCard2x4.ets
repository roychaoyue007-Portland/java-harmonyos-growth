/**
 * 日程管理卡片 - 2x4 中等卡片
 *
 * 展示内容：日期、分类切换按钮、2-3 条日程摘要
 * 交互：
 *   - 按钮点击切换分类（工作/生活/学习）
 *   - 点击卡片跳转主应用
 *   - 通过 postCardAction 与 FormExtensionAbility 通信
 *
 * 卡片尺寸约 360×168 vp
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
struct ScheduleCard2x4 {
  // 各分类日程数据
  @State workItems: ScheduleItem[] = []
  @State lifeItems: ScheduleItem[] = []
  @State studyItems: ScheduleItem[] = []
  // 当前选中分类
  @State activeCategory: CategoryType = 'work'
  // 当前分类的日程列表
  @State currentItems: ScheduleItem[] = []
  // 今日日期
  @State todayDate: string = ''

  aboutToAppear(): void {
    this.todayDate = getTodayString()
    this.loadAllData()
  }

  /**
   * 加载全部分类数据
   * 一次性加载所有分类，切换时无需重新请求
   */
  loadAllData(): void {
    const allItems: ScheduleItem[] = getAllSchedules()
    this.workItems = getByCategory(allItems, 'work')
    this.lifeItems = getByCategory(allItems, 'life')
    this.studyItems = getByCategory(allItems, 'study')
    this.updateCurrentItems()
  }

  /**
   * 根据当前分类更新展示列表
   */
  updateCurrentItems(): void {
    if (this.activeCategory === 'work') {
      this.currentItems = this.workItems
    } else if (this.activeCategory === 'life') {
      this.currentItems = this.lifeItems
    } else {
      this.currentItems = this.studyItems
    }
  }

  /**
   * 切换分类
   * 更新本地状态 + 通知 FormExtensionAbility 记录当前分类
   */
  switchCategory(category: CategoryType): void {
    if (this.activeCategory === category) {
      return
    }
    this.activeCategory = category
    this.updateCurrentItems()

    // 通知 FormExtensionAbility 当前分类已切换
    postCardAction(this, {
      action: 'form-event',
      params: {
        action: 'switchCategory',
        category: category
      }
    })
  }

  build() {
    Column() {
      // ======== 顶部栏：日期 + 标题 ========
      Row() {
        Column({ space: 2 }) {
          Text('今日日程')
            .fontSize(15)
            .fontWeight(FontWeight.Bold)
            .fontColor('#1A1A1A')

          Text(this.todayDate)
            .fontSize(10)
            .fontColor('#999999')
        }
        .alignItems(HorizontalAlign.Start)
        .layoutWeight(1)
      }
      .width('100%')
      .margin({ bottom: 8 })

      // ======== 分类切换按钮 ========
      Row({ space: 6 }) {
        ForEach(CATEGORIES, (tab: CategoryTab) => {
          Button(tab.label)
            .fontSize(11)
            .height(24)
            .padding({ left: 10, right: 10 })
            .borderRadius(12)
            .fontColor(this.activeCategory === tab.key ? '#FFFFFF' : '#666666')
            .backgroundColor(this.activeCategory === tab.key ? '#0A59F7' : '#F2F2F2')
            .onClick(() => {
              this.switchCategory(tab.key)
            })
        })
      }
      .width('100%')
      .justifyContent(FlexAlign.Start)
      .margin({ bottom: 8 })

      // ======== 日程列表区域 ========
      Column({ space: 6 }) {
        ForEach(this.currentItems.slice(0, 3), (item: ScheduleItem) => {
          Row() {
            // 优先级色条
            Row()
              .width(3)
              .height(28)
              .backgroundColor(getPriorityColor(item.priority))
              .borderRadius(1.5)
              .margin({ right: 8 })

            // 日程信息
            Column({ space: 2 }) {
              Row() {
                Text(item.title)
                  .fontSize(12)
                  .fontWeight(FontWeight.Medium)
                  .fontColor(item.completed ? '#BBBBBB' : '#1A1A1A')
                  .maxLines(1)
                  .textOverflow({ overflow: TextOverflow.Ellipsis })
                  .decoration({
                    type: item.completed ? TextDecorationType.LineThrough : TextDecorationType.None
                  })

                Blank()

                Text(item.time)
                  .fontSize(10)
                  .fontColor('#999999')
              }
              .width('100%')

              Text(item.summary)
                .fontSize(10)
                .fontColor('#999999')
                .maxLines(1)
                .textOverflow({ overflow: TextOverflow.Ellipsis })
            }
            .layoutWeight(1)
            .alignItems(HorizontalAlign.Start)
          }
          .width('100%')
          .padding({ left: 4, right: 4 })
        })

        // 无日程提示
        if (this.currentItems.length === 0) {
          Row() {
            Text('该分类下暂无日程安排')
              .fontSize(12)
              .fontColor('#CCCCCC')
          }
          .width('100%')
          .justifyContent(FlexAlign.Center)
          .height(40)
        }
      }
      .layoutWeight(1)
      .width('100%')

      // ======== 底部：更多提示 ========
      if (this.currentItems.length > 3) {
        Row() {
          Text(`还有 ${this.currentItems.length - 3} 项日程`)
            .fontSize(10)
            .fontColor('#0A59F7')
        }
        .width('100%')
        .justifyContent(FlexAlign.End)
        .onClick(() => {
          postCardAction(this, {
            action: 'router',
            abilityName: 'EntryAbility',
            params: {
              category: this.activeCategory
            }
          })
        })
      }
    }
    .width('100%')
    .height('100%')
    .padding(14)
  }
}

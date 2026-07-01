/**
 * 日程管理卡片 - 2x2 小卡片
 *
 * 展示内容：当前分类的第一条日程 + 时间 + 分类标签
 * 交互：点击卡片跳转主应用查看详情
 *
 * 卡片尺寸约 168×168 vp，布局紧凑
 */
import { ScheduleItem, getByCategory, getAllSchedules, getTodayString, CATEGORIES, getPriorityColor, CategoryType } from '../common/ScheduleData'

@Entry
struct ScheduleCard2x2 {
  @State scheduleItems: ScheduleItem[] = []
  @State activeCategory: string = 'work'
  @State todayDate: string = ''
  @State currentLabel: string = '工作'

  aboutToAppear(): void {
    // 从 formLink 存储中读取数据
    this.loadData()
  }

  loadData(): void {
    // 解析 fromStores 传入的表单数据
    const allItems: ScheduleItem[] = getAllSchedules()
    const category: CategoryType = this.activeCategory as CategoryType
    this.scheduleItems = getByCategory(allItems, category)
    this.todayDate = getTodayString()

    // 获取当前分类标签
    for (const cat of CATEGORIES) {
      if (cat.key === this.activeCategory) {
        this.currentLabel = cat.label
        break
      }
    }
  }

  build() {
    Column() {
      // 顶部：日期 + 分类
      Row() {
        Text(this.todayDate)
          .fontSize(11)
          .fontColor('#666666')

        Blank()

        Text(this.currentLabel)
          .fontSize(10)
          .fontColor('#FFFFFF')
          .backgroundColor('#0A59F7')
          .borderRadius(4)
          .padding({ left: 6, right: 6, top: 2, bottom: 2 })
      }
      .width('100%')
      .margin({ bottom: 6 })

      // 主内容区：显示第一条未完成日程
      if (this.scheduleItems.length > 0) {
        Column() {
          // 优先级色条
          Row() {
            Row()
              .width(3)
              .height('100%')
              .backgroundColor(getPriorityColor(this.scheduleItems[0].priority))
              .borderRadius(1.5)
              .margin({ right: 6 })

            Column({ space: 2 }) {
              Text(this.scheduleItems[0].title)
                .fontSize(14)
                .fontWeight(FontWeight.Bold)
                .fontColor('#1A1A1A')
                .maxLines(1)
                .textOverflow({ overflow: TextOverflow.Ellipsis })

              Text(this.scheduleItems[0].time)
                .fontSize(11)
                .fontColor('#999999')
            }
            .layoutWeight(1)
            .alignItems(HorizontalAlign.Start)
          }
          .width('100%')
          .height(36)
        }
        .margin({ bottom: 4 })
      } else {
        Column() {
          Text('暂无日程')
            .fontSize(13)
            .fontColor('#999999')
        }
        .margin({ bottom: 4 })
      }

      // 底部：日程数量指示
      Row() {
        Text(`${this.scheduleItems.length} 项日程`)
          .fontSize(10)
          .fontColor('#999999')
      }
      .width('100%')
      .justifyContent(FlexAlign.End)
    }
    .width('100%')
    .height('100%')
    .padding(12)
    .onClick(() => {
      // 点击卡片跳转主应用
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

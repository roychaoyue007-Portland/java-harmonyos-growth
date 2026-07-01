/**
 * 日程管理 - 主应用页面
 *
 * 应用启动后展示的主页面，包含：
 * - 今日日程概览
 * - 分类筛选
 * - 日程详情列表
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
@Component
struct Index {
  @State allItems: ScheduleItem[] = []
  @State currentItems: ScheduleItem[] = []
  @State activeCategory: CategoryType = 'work'
  @State todayDate: string = ''

  aboutToAppear(): void {
    this.todayDate = getTodayString()
    this.allItems = getAllSchedules()
    this.filterItems()
  }

  filterItems(): void {
    this.currentItems = getByCategory(this.allItems, this.activeCategory)
  }

  build() {
    Column() {
      // 顶部标题栏
      Row() {
        Column({ space: 4 }) {
          Text('今日日程')
            .fontSize(24)
            .fontWeight(FontWeight.Bold)
            .fontColor('#1A1A1A')

          Text(this.todayDate)
            .fontSize(14)
            .fontColor('#999999')
        }
        .alignItems(HorizontalAlign.Start)
        .layoutWeight(1)
      }
      .width('100%')
      .padding({ left: 20, right: 20, top: 16, bottom: 16 })

      // 分类标签
      Row({ space: 12 }) {
        ForEach(CATEGORIES, (tab: CategoryTab) => {
          Row({ space: 6 }) {
            Text(tab.icon)
              .fontSize(14)
            Text(`${tab.label} (${getByCategory(this.allItems, tab.key).length})`)
              .fontSize(14)
              .fontColor(this.activeCategory === tab.key ? '#FFFFFF' : '#666666')
          }
          .height(36)
          .padding({ left: 16, right: 16 })
          .borderRadius(18)
          .backgroundColor(this.activeCategory === tab.key ? '#0A59F7' : '#F2F2F2')
          .onClick(() => {
            this.activeCategory = tab.key
            this.filterItems()
          })
        })
      }
      .width('100%')
      .padding({ left: 20, right: 20 })
      .margin({ bottom: 16 })

      // 日程列表
      List({ space: 12 }) {
        ForEach(this.currentItems, (item: ScheduleItem) => {
          ListItem() {
            Row() {
              // 优先级色条
              Column()
                .width(4)
                .height('100%')
                .backgroundColor(getPriorityColor(item.priority))
                .borderRadius(2)
                .margin({ right: 12 })

              // 日程内容
              Column({ space: 6 }) {
                Row() {
                  Text(item.title)
                    .fontSize(16)
                    .fontWeight(FontWeight.Medium)
                    .fontColor(item.completed ? '#BBBBBB' : '#1A1A1A')
                    .layoutWeight(1)
                    .decoration({
                      type: item.completed ? TextDecorationType.LineThrough : TextDecorationType.None
                    })

                  Text(item.time)
                    .fontSize(13)
                    .fontColor('#999999')
                }
                .width('100%')

                Text(item.summary)
                  .fontSize(13)
                  .fontColor('#999999')
                  .maxLines(2)
                  .textOverflow({ overflow: TextOverflow.Ellipsis })

                Row() {
                  Text(PRIORITY_LABELS[item.priority] ?? '')
                    .fontSize(11)
                    .fontColor(getPriorityColor(item.priority))
                    .padding({ left: 6, right: 6, top: 2, bottom: 2 })
                    .borderRadius(4)
                    .backgroundColor(`${getPriorityColor(item.priority)}15`)

                  if (item.completed) {
                    Blank()
                    Text('已完成')
                      .fontSize(11)
                      .fontColor('#52C41A')
                  }
                }
                .width('100%')
              }
              .layoutWeight(1)
              .alignItems(HorizontalAlign.Start)
            }
            .width('100%')
            .padding(16)
            .backgroundColor('#FFFFFF')
            .borderRadius(12)
            .shadow({ radius: 4, color: '#0D000000', offsetX: 0, offsetY: 2 })
          }
        }, (item: ScheduleItem) => item.id.toString())
      }
      .width('100%')
      .layoutWeight(1)
      .padding({ left: 20, right: 20 })
      .scrollBar(BarState.Auto)
      .edgeEffect(EdgeEffect.Spring)
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F5F5F5')
  }
}

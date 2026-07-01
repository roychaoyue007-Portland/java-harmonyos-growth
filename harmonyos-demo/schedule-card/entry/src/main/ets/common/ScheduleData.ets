/**
 * 日程管理卡片 - 公共数据模型
 * 定义日程项、分类等数据结构和工具函数
 */

export type CategoryType = 'work' | 'life' | 'study'

export interface ScheduleItem {
  id: number
  title: string
  summary: string
  time: string
  category: CategoryType
  priority: 'high' | 'medium' | 'low'
  completed: boolean
}

export interface CategoryTab {
  key: CategoryType
  label: string
  icon: string
}

// 分类标签配置
export const CATEGORIES: CategoryTab[] = [
  { key: 'work', label: '工作', icon: '\u{1F4BC}' },
  { key: 'life', label: '生活', icon: '\u{1F3E0}' },
  { key: 'study', label: '学习', icon: '\u{1F4DA}' }
]

// 优先级颜色映射
export const PRIORITY_COLORS: Record<string, string> = {
  'high': '#FF4D4F',
  'medium': '#FAAD14',
  'low': '#52C41A'
}

// 优先级标签映射
export const PRIORITY_LABELS: Record<string, string> = {
  'high': '紧急',
  'medium': '一般',
  'low': '空闲'
}

/**
 * 示例日程数据
 * 实际项目中应从网络或本地数据库获取
 */
export function getAllSchedules(): ScheduleItem[] {
  return [
    // 工作分类
    {
      id: 1,
      title: '项目周会',
      summary: '讨论本周开发进度与下周计划',
      time: '09:00',
      category: 'work',
      priority: 'high',
      completed: false
    },
    {
      id: 2,
      title: '代码评审',
      summary: 'Review 鸿蒙卡片模块 PR',
      time: '14:00',
      category: 'work',
      priority: 'medium',
      completed: false
    },
    {
      id: 3,
      title: '需求对齐',
      summary: '与产品经理确认 Q3 功能规划',
      time: '16:30',
      category: 'work',
      priority: 'high',
      completed: true
    },
    // 生活分类
    {
      id: 4,
      title: '健身训练',
      summary: '上肢力量 + 有氧 30 分钟',
      time: '07:00',
      category: 'life',
      priority: 'medium',
      completed: true
    },
    {
      id: 5,
      title: '超市采购',
      summary: '蔬菜、水果、牛奶、全麦面包',
      time: '18:30',
      category: 'life',
      priority: 'low',
      completed: false
    },
    {
      id: 6,
      title: '家庭晚餐',
      summary: '和家人一起做饭',
      time: '19:30',
      category: 'life',
      priority: 'medium',
      completed: false
    },
    // 学习分类
    {
      id: 7,
      title: 'ArkTS 进阶',
      summary: '学习 @Reusable 和 LazyForEach 性能优化',
      time: '20:00',
      category: 'study',
      priority: 'high',
      completed: false
    },
    {
      id: 8,
      title: '阅读文档',
      summary: 'HarmonyOS 服务卡片开发指南',
      time: '21:00',
      category: 'study',
      priority: 'medium',
      completed: false
    },
    {
      id: 9,
      title: '算法练习',
      summary: 'LeetCode 每日一题 - 动态规划',
      time: '22:00',
      category: 'study',
      priority: 'low',
      completed: false
    }
  ]
}

/**
 * 根据分类筛选日程
 */
export function getByCategory(items: ScheduleItem[], category: CategoryType): ScheduleItem[] {
  return items.filter(item => item.category === category)
}

/**
 * 获取优先级颜色
 */
export function getPriorityColor(priority: string): string {
  return PRIORITY_COLORS[priority] || '#999999'
}

/**
 * 获取优先级标签
 */
export function getPriorityLabel(priority: string): string {
  return PRIORITY_LABELS[priority] || '未知'
}

/**
 * 格式化今日日期
 */
export function getTodayString(): string {
  const now = new Date()
  const month = now.getMonth() + 1
  const day = now.getDate()
  const weekDays: string[] = ['日', '一', '二', '三', '四', '五', '六']
  const weekDay = weekDays[now.getDay()]
  return `${month}月${day}日 周${weekDay}`
}

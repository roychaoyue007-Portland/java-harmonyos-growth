/**
 * 日程管理卡片 - FormExtensionAbility
 *
 * 负责卡片生命周期管理：创建、更新、销毁等。
 * 处理卡片交互事件（按钮点击切换分类等）。
 * 通过 formLink 持久化存储与卡片页面共享数据。
 */
import { AbilityConstant, Configuration, ConfigurationConstant, UIAbility, Want } from '@kit.AbilityKit'
import { common } from '@kit.AbilityKit'
import { formBindingData, FormExtensionAbility, formProvider } from '@kit.FormKit'
import { hilog } from '@kit.PerformanceAnalysisKit'
import { preferences } from '@kit.ArkData'
import { getAllSchedules, getByCategory, ScheduleItem, CategoryType, getTodayString } from '../common/ScheduleData'

const TAG: string = 'ScheduleFormAbility'
const DOMAIN: number = 0x0001
const STORE_NAME: string = 'schedule_store'

// 持久化存储的 key 常量
const KEY_ALL_ITEMS: string = 'allItems'
const KEY_ACTIVE_CATEGORY: string = 'activeCategory'
const KEY_TODAY_DATE: string = 'todayDate'

export default class ScheduleFormAbility extends FormExtensionAbility {

  /**
   * 卡片创建时调用
   * 初始化日程数据，写入 formLink 存储，返回初始数据给卡片页面
   */
  onAddForm(want: Want): formBindingData.FormBindingData {
    hilog.info(DOMAIN, TAG, 'onAddForm: 卡片创建, formId=%{public}s', want.parameters?.['ohos.extra.form.id'] as string ?? '')

    // 准备初始数据：默认展示工作分类
    const allItems: ScheduleItem[] = getAllSchedules()
    const defaultCategory: CategoryType = 'work'

    // 将数据序列化后写入 formLink 持久化存储
    const formData: Record<string, string> = {
      'allItems': JSON.stringify(allItems),
      'activeCategory': defaultCategory,
      'todayDate': getTodayString(),
      'workItems': JSON.stringify(getByCategory(allItems, 'work')),
      'lifeItems': JSON.stringify(getByCategory(allItems, 'life')),
      'studyItems': JSON.stringify(getByCategory(allItems, 'study')),
      'workCount': String(getByCategory(allItems, 'work').length),
      'lifeCount': String(getByCategory(allItems, 'life').length),
      'studyCount': String(getByCategory(allItems, 'study').length)
    }

    return formBindingData.createFormBindingData(formData)
  }

  /**
   * 卡片更新时调用（定时更新或手动刷新）
   * 重新获取最新数据并推送到卡片页面
   */
  onUpdateForm(formId: string): void {
    hilog.info(DOMAIN, TAG, 'onUpdateForm: 卡片更新, formId=%{public}s', formId)

    const allItems: ScheduleItem[] = getAllSchedules()

    const formData: Record<string, string> = {
      'allItems': JSON.stringify(allItems),
      'todayDate': getTodayString(),
      'workItems': JSON.stringify(getByCategory(allItems, 'work')),
      'lifeItems': JSON.stringify(getByCategory(allItems, 'life')),
      'studyItems': JSON.stringify(getByCategory(allItems, 'study')),
      'workCount': String(getByCategory(allItems, 'work').length),
      'lifeCount': String(getByCategory(allItems, 'life').length),
      'studyCount': String(getByCategory(allItems, 'study').length)
    }

    formProvider.updateFormData(formId, formData)
  }

  /**
   * 卡片事件回调（处理按钮点击等交互）
   * 卡片页面通过 postCardAction 发送 form-event 消息触发此方法
   */
  onFormEvent(formId: string, message: string): void {
    hilog.info(DOMAIN, TAG, 'onFormEvent: formId=%{public}s, message=%{public}s', formId, message)

    try {
      const eventData: Record<string, string> = JSON.parse(message)
      const actionType: string = eventData['action'] ?? ''
      const newCategory: string = eventData['category'] ?? 'work'

      if (actionType === 'switchCategory') {
        // 切换分类后，将新的当前分类数据推送给卡片
        const allItems: ScheduleItem[] = getAllSchedules()
        const categoryItems: ScheduleItem[] = getByCategory(allItems, newCategory as CategoryType)

        const updateData: Record<string, string> = {
          'activeCategory': newCategory,
          'currentItems': JSON.stringify(categoryItems),
          'currentCount': String(categoryItems.length)
        }

        formProvider.updateFormData(formId, updateData)
        hilog.info(DOMAIN, TAG, '分类切换为: %{public}s, 条目数: %{public}d', newCategory, categoryItems.length)
      }

      if (actionType === 'refreshAll') {
        // 全量刷新
        this.onUpdateForm(formId)
      }
    } catch (e) {
      hilog.error(DOMAIN, TAG, 'onFormEvent 解析失败: %{public}s', JSON.stringify(e))
    }
  }

  /**
   * 卡片销毁时调用
   * 清理相关资源
   */
  onRemoveForm(formId: string): void {
    hilog.info(DOMAIN, TAG, 'onRemoveForm: 卡片销毁, formId=%{public}s', formId)
  }

  /**
   * 卡片从临时态转为常态时调用
   */
  onCastToNormalForm(formId: string): void {
    hilog.info(DOMAIN, TAG, 'onCastToNormalForm: formId=%{public}s', formId)
  }
}

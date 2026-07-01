/**
 * 日程管理 - 主应用 EntryAbility
 *
 * 主应用的入口 Ability，负责：
 * 1. 应用生命周期管理
 * 2. 与卡片共享日程数据（通过 Preferences）
 * 3. 提供数据更新接口
 */
import { AbilityConstant, Configuration, ConfigurationConstant, UIAbility, Want } from '@kit.AbilityKit'
import { hilog } from '@kit.PerformanceAnalysisKit'
import { window } from '@kit.ArkUI'
import { preferences } from '@kit.ArkData'
import { getAllSchedules, ScheduleItem } from '../common/ScheduleData'

const TAG: string = 'EntryAbility'
const DOMAIN: number = 0x0001
const STORE_NAME: string = 'schedule_preferences'

export default class EntryAbility extends UIAbility {
  async onCreate(want: Want, launchParam: AbilityConstant.LaunchParam): Promise<void> {
    hilog.info(DOMAIN, TAG, 'onCreate: 应用启动')

    // 初始化日程数据到 Preferences，供卡片读取
    try {
      const store = await preferences.getPreferences(this.context, STORE_NAME)
      const allItems: ScheduleItem[] = getAllSchedules()
      await store.put('allItems', JSON.stringify(allItems))
      await store.put('lastUpdateTime', Date.now().toString())
      await store.flush()
      hilog.info(DOMAIN, TAG, '日程数据初始化完成, 共 %d 条', allItems.length)
    } catch (e) {
      hilog.error(DOMAIN, TAG, '数据初始化失败: %{public}s', JSON.stringify(e))
    }
  }

  onDestroy(): void {
    hilog.info(DOMAIN, TAG, 'onDestroy: 应用销毁')
  }

  onWindowStageCreate(windowStage: window.WindowStage): void {
    hilog.info(DOMAIN, TAG, 'onWindowStageCreate')

    // 加载主页面
    windowStage.loadContent('pages/Index', (err) => {
      if (err.code) {
        hilog.error(DOMAIN, TAG, '页面加载失败: %{public}s', JSON.stringify(err))
        return
      }
      hilog.info(DOMAIN, TAG, '主页面加载成功')
    })
  }

  onWindowStageDestroy(): void {
    hilog.info(DOMAIN, TAG, 'onWindowStageDestroy')
  }

  onForeground(): void {
    hilog.info(DOMAIN, TAG, 'onForeground: 应用前台')
  }

  onBackground(): void {
    hilog.info(DOMAIN, TAG, 'onBackground: 应用后台')
  }

  onConfigurationUpdate(newConfig: Configuration): void {
    hilog.info(DOMAIN, TAG, 'onConfigurationUpdate')
  }
}

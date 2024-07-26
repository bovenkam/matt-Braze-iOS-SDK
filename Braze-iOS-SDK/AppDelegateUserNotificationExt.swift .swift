import UserNotifications
import BrazeKit


extension AppDelegate: UNUserNotificationCenterDelegate {


  func userNotificationCenter(
    _ center: UNUserNotificationCenter,
    didReceive response: UNNotificationResponse,
    withCompletionHandler completionHandler: @escaping () -> Void
  ) {
    if let braze = AppDelegate.braze, braze.notifications.handleUserNotification(
      response: response,
      withCompletionHandler: completionHandler
    ) {
      return
    }
    completionHandler()
  }


  func userNotificationCenter(
    _ center: UNUserNotificationCenter,
    willPresent notification: UNNotification,
    withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void
  ) {
    if #available(iOS 14.0, *) {
      completionHandler([.list, .banner])
    } else {
      completionHandler(.alert)
    }
  }


}

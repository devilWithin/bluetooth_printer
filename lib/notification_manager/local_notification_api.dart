// import 'dart:async';
//
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
//
//
// /// Local Notification Api
// class LocalNotificationApi {
//   /// init local notification
//   static final FlutterLocalNotificationsPlugin localNotifications =
//       FlutterLocalNotificationsPlugin();
//
//   /// init channel
//   static const AndroidNotificationChannel androidNotificationChannel =
//       AndroidNotificationChannel(
//     'high_importance_channel', // id
//     'High Importance Notifications', // title
//     description:
//         'This channel is used for important notifications.', // description
//     importance: Importance.max,
//   );
//
//   /// when tap in notification to open specific screen or anything
//   static Future init() async {
//     const android = AndroidInitializationSettings('@mipmap/ic_launcher');
//     const ios = IOSInitializationSettings();
//     const settings = InitializationSettings(android: android, iOS: ios);
//     await localNotifications.initialize(
//       settings,
//       onSelectNotification: (payload) async {
//         /// deal with UI
//         // Dialogs.showSnackBar(
//         //     context: navigatorKey.currentContext!,
//         //     message: "message from Foreground Notification");
//       },
//     );
//   }
//
//   /// show notification
//   static Future showNotification({
//     int id = 0,
//     String? title,
//     String? body,
//     String? payload,
//   }) async {
//     localNotifications.show(
//       id,
//       title,
//       body,
//       _notificationDetails(),
//       payload: payload,
//     );
//   }
//
//   /// notification Details
//   static NotificationDetails _notificationDetails() {
//     return NotificationDetails(
//       android: AndroidNotificationDetails(
//         androidNotificationChannel.id, // channel id
//         androidNotificationChannel.name, // channel name
//         channelDescription:
//             androidNotificationChannel.description, //channel description
//         importance: Importance.max,
//         playSound: true,
//         icon: '@mipmap/ic_launcher',
//       ),
//       iOS: const IOSNotificationDetails(),
//     );
//   }
// }

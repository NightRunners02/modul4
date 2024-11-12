import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';
import 'package:open_app_settings/open_app_settings.dart';

class HomeController extends GetxController {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin _localNotifications = FlutterLocalNotificationsPlugin();

  @override
  void onInit() {
    super.onInit();
    _initializeNotifications();
    _checkAndRequestNotificationPermission();
    _initializeFirebaseMessaging();
  }

  void _initializeNotifications() {
    const AndroidInitializationSettings androidInitSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const InitializationSettings initSettings = InitializationSettings(android: androidInitSettings);

    _localNotifications.initialize(initSettings);
  }

  void _checkAndRequestNotificationPermission() async {
    NotificationSettings settings = await _firebaseMessaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print("User granted notification permission");
    } else if (settings.authorizationStatus == AuthorizationStatus.provisional) {
      print("User granted provisional notification permission");
    } else {
      print("User declined or has not accepted notification permission");

      Get.defaultDialog(
        title: "Notification Permission Needed",
        middleText:
            "Please enable notifications in the app settings.",
        onConfirm: () {
          OpenAppSettings.openAppSettings();
          Get.back();
        },
        textConfirm: "Open Settings",
        textCancel: "Cancel",
      );
    }
  }

  void _initializeFirebaseMessaging() {
    _firebaseMessaging.getToken().then((token) {
      print("FCM Token: $token");
    });

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print("Foreground message received: ${message.notification?.title}");
      _showFirebaseNotification(message);
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print("Notification clicked in background: ${message.notification?.title}");
    });
  }

  void _showFirebaseNotification(RemoteMessage message) async {
    List<Message> notificationMessages = [
      Message(
        message.notification?.body ?? '',
        DateTime.now(),
        Person(
          name: message.notification?.title ?? 'New Message',
          icon: const DrawableResourceAndroidIcon('@mipmap/ic_launcher'),
        ),
      ),
    ];

    final AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
      'channel_id',
      'channel_name',
      channelDescription: 'Channel description',
      importance: Importance.max,
      priority: Priority.high,
      styleInformation: MessagingStyleInformation(
        Person(
          name: message.notification?.title ?? 'Message',
          icon: const DrawableResourceAndroidIcon('@mipmap/ic_launcher'),
        ),
        messages: notificationMessages,
        groupConversation: true,
      ),
      showWhen: true,
      autoCancel: true,
      timeoutAfter: 10000, // Set the duration to 10 seconds (10,000 milliseconds)
    );

    final NotificationDetails platformDetails = NotificationDetails(android: androidDetails);

    await _localNotifications.show(
      message.hashCode,
      message.notification?.title ?? "Notification",
      "You have new messages",
      platformDetails,
    );
  }

  void logout() {
    Get.offAllNamed('/login');
  }
}

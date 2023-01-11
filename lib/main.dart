import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:freeflow/app_config.dart';
import 'package:freeflow/helpers/shared_preference_data.dart';
import 'package:freeflow/screens/webview_screen.dart';
import 'screens/enter_username_screen.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  const AndroidNotificationChannel channel = AndroidNotificationChannel(
    'high_importance_channel',
    'High Importance Notifications',
    importance: Importance.max,
  );

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    RemoteNotification? notification = message.notification;
    AndroidNotification? android = message.notification?.android;
    if (notification != null && android != null) {
      flutterLocalNotificationsPlugin.show(
          notification.hashCode,
          notification.title,
          notification.body,
          NotificationDetails(
            android: AndroidNotificationDetails(
              channel.id,
              channel.name,
              channelDescription : channel.description,
              color: Colors.blue,
              playSound: true,
              icon: '@mipmap/ic_launcher_notification',
            ),
          ));
    }
  });

  String? identifier = await FirebaseMessaging.instance.getToken();

  if (identifier == null || identifier == '') identifier = '';
  await setIdentifierInStorage(identifier);

  runApp(LandingScreen());
}

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print("Handling a background message: ${message.messageId}");
}

class LandingScreen extends StatefulWidget with WidgetsBindingObserver {
  @override
  _LandingScreenState createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  String username = '';

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      getUsername();
    });
  }

  Future<void> getUsername() async {
    String? user = await getNameInStorage();
    username = user;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'FreeFlow',
        debugShowCheckedModeBanner: false,
        home: username != ''
            ? WebViewScreen(url: 'https://' + username + AppConfig().freeFlowUrl())
            : EnterUsernameScreen());
  }
}

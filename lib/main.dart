import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:lexit/pages/homePgae.dart';
import 'package:lexit/pages/indexPage.dart';
import 'package:lexit/pages/splash/splashScreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  // Initialize settings for each platform (Android and iOS)
  const AndroidInitializationSettings androidInitializationSettings =
      AndroidInitializationSettings(
          '@mipmap/ic_launcher'); // Replace 'app_icon' with your app's launcher icon name

  const InitializationSettings initializationSettings = InitializationSettings(
    android: androidInitializationSettings,
  );

  await flutterLocalNotificationsPlugin.initialize(initializationSettings,
      onDidReceiveNotificationResponse: (NotificationResponse payload) async {
    // This callback is triggered when the user taps on the notification
    // You can implement the behavior you want when the notification is tapped.
  });
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    const MaterialColor customPrimaryColor = MaterialColor(
      0xFF007BFF, // Custom primary color value (blue)
      <int, Color>{
        50: Color(0xFFE3F2FD),
        100: Color(0xFFBBDEFB),
        200: Color(0xFF90CAF9),
        300: Color(0xFF64B5F6),
        400: Color(0xFF42A5F5),
        500: Color(0xFF007BFF), // The main custom primary color
        600: Color(0xFF0074E8),
        700: Color(0xFF0067C2),
        800: Color(0xFF00549B),
        900: Color(0xFF003A6D),
      },
    );
    return GetMaterialApp(
      title: 'Lexit',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: customPrimaryColor,
      ),
      home: SplashScreen(),
    );
  }
}

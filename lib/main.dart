
// ignore_for_file: unnecessary_import
import 'dart:developer';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';
import 'package:school_app/splash_screen.dart';

import 'package:month_year_picker/month_year_picker.dart';

var payloadData;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  await flutterLocalNotificationsPlugin
      ?.resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);
  runApp(
     GetMaterialApp(
        debugShowCheckedModeBanner: false,
        localizationsDelegates: [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
          MonthYearPickerLocalizations.delegate,
        ],
        supportedLocales: [
          Locale('en', ''),
        ],
        home: MyApp()),
  );
}

AndroidNotificationChannel channel = const AndroidNotificationChannel(
  'high_importance_channel',
  'High Importance Notifications',

  importance: Importance.high,
  description: 'Channel Description',
  playSound: true,
);
FlutterLocalNotificationsPlugin? flutterLocalNotificationsPlugin;

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message,
    [Widget? widget]) async {
  try {
    await Firebase.initializeApp();

    payloadData = message.data;
    if (payloadData != null) {}
  } catch (e) {
log('E ${e}');
  }
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const SplashScreen();
  }
}
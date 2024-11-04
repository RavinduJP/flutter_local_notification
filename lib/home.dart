import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:local_notification/local_notification_service.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  void initStatus() {
    // when app is terminated
    FirebaseMessaging.instance.getInitialMessage().then((message) {
      print("app is terminated");
      if (message != null) {
        print("New notification");
      }
    });

// when app is an foreground
    FirebaseMessaging.onMessage.listen((message) {
      print("app is on foreground");
      if (message.notification != null) {
        print(message.notification!.title);
        print(message.notification!.body);

        LocalNotificationService.createeNotification(message);
      }
    });

    // when app is in background not terminated
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      print("app is running in the background");
      if (message.notification != null) {
        print(message.notification!.title);
        print(message.notification!.body);

        LocalNotificationService.createeNotification(message);
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Firebase LocalNotification"),
      ),
      body: Center(
        child: GestureDetector(
          child: const Text("Push Notification"),
          onTap: () {},
        ),
      ),
    );
  }
}

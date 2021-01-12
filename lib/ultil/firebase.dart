import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';

FirebaseMessaging fcm;

void initFcm() {
  if (fcm == null) {
    fcm = FirebaseMessaging.instance;
  }

  fcm.getToken().then((token) {
    print("\n******\nFirebase Token $token\n******\n");
  });

  fcm.subscribeToTopic("all");

  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    RemoteNotification notification = message.notification;
    AndroidNotification android = message.notification?.android;

   print(message);
  });


}
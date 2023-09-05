import 'dart:convert';


import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:sofproject/app/controllers/controller.dart';
import 'package:sofproject/app/ui/screens/demo/notification_screen.dart';

import '../data/repository/http/auth_repository.dart';
import '../ui/widgets/common_snackbar.dart';



class FcmService{
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  late AndroidNotificationChannel channel;
  late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  getFcmNotificationPermission()async {
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
    if (kDebugMode) {
      print('User granted permission: ${settings.authorizationStatus}');
    }
  }

  localNotification({required RemoteMessage message})async{

   try {
     RemoteNotification? notification = message.notification;
     AndroidNotification? android = message.notification?.android;
     if (notification != null && !kIsWeb) {
       debugPrint("entry notification");
      await  setNotificationChannel();
       flutterLocalNotificationsPlugin.show(
         notification.hashCode,
         notification.title,
         notification.body,
         NotificationDetails(
           android: AndroidNotificationDetails(
             channel.id,
             channel.name,
             playSound: true,
             enableVibration: true,
             //      one that already exists in example app.
             icon: 'img',
             importance: Importance.max,
             styleInformation: BigTextStyleInformation(''),
           ),
         ),
         payload: jsonEncode(message.data)
       );
       debugPrint("exit notification");

     }
   }catch(e){
     debugPrint("local notification error $e");
   }

  }

  fcmStart()async{
    await setNotificationChannel();
    getFcmNotificationPermission();
    fcmOnMessage();
  }


  getFcmToken({required String token})async{
    String? token = await messaging.getToken(
    );
     print("fcm token ${token}");
     AuthController.to.token.text= "${token}";
    // var body={
    //   "fcm":"$token"
    // };
    // var res=await AuthRepository().fcmUpdate(body:body);
    // if(res.status==200 || res.status==201){
    //   if (kDebugMode) {
    //     print("Fcm token updated successfully");
    //   }
    // }else{
    //   commonSnackBar(title:"error".tr,msg: "fcm_tok_error".tr);
    // }
  }

fcmOnMessage()async{



  // FirebaseMessaging.instance.getInitialMessage().then(
  //       (value) =>
  //           print('Got a message initial $value')
  //
  // );
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    //
    // FirebaseMessaging.instance.getInitialMessage().then((RemoteMessage? message) {
    //   if (message != null) {
    //     debugPrint("direction from screen ");
    //       }
    // });


    if (kDebugMode) {
      print('Got a message whilst in the foreground!');
      print('Message data: ${message.data}');
    }
    if (message.notification != null) {
      if (kDebugMode) {
        print('Message also contained a notification: ${message.notification}');
      }
      localNotification(message: message);
    }
  });


}

setNotificationChannel()async {
  if (!kIsWeb) {
    channel = const AndroidNotificationChannel(
      'high_importance_channel', // id
      'High Importance Notifications', // title
      importance: Importance.high,
      enableVibration: true
    );
    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    /// Create an Android Notification Channel.
    ///
    /// We use this channel in the `AndroidManifest.xml` file to override the
    /// default FCM channel to enable heads up notifications.
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);
    /// Update the iOS foreground notification presentation options to allow
    /// heads up notifications.
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
  }
}

  }
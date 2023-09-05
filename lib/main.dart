import 'dart:io';
import 'dart:isolate';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

import 'app/routes/routes.dart';
import 'app/services/FCM_service.dart';
import 'app/translations/app_translations.dart';
import 'app/ui/screens/demo/IncidentScreenDashboard.dart';
import 'app/ui/screens/demo/dashboard.dart';
import 'app/ui/screens/demo/incident_view_form_screen.dart';
import 'app/ui/screens/demo/sagawa_login.dart';
import 'app/ui/screens/splash/splash.dart';
import 'app/ui/themes/app_theme.dart';

@pragma('vm:entry-point')


Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
}
class MyHttpOverrides extends HttpOverrides{
  @override
  HttpClient createHttpClient(SecurityContext? context){
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port)=> true;
  }
}
void main() async{
  HttpOverrides.global = MyHttpOverrides();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();


  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  await FcmService().fcmStart();
  runApp(
      GetMaterialApp(
        debugShowCheckedModeBanner: false,
        translations: AppTranslations(),
        locale: const Locale('en'),
        initialRoute: '/',
        getPages: AppRoutes.routes,
       // home:
       // MyDasboardScreen(),
      // OnBoardingPage(),
       // IncidentViewFormScreen(ignoring: true,),
        //IncidentScreenDashboard(),
        navigatorKey: Get.key,
        theme:appThemeData,
      ));
  final int helloAlarmID = 0;
  //await AndroidAlarmManager.periodic(const Duration(minutes: 1), helloAlarmID,backgroundFetchLocation);
}




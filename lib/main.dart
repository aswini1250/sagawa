//Packages
import 'dart:io';

import 'package:sofproject/app/ui/screens/demo/login_page.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'app/routes/routes.dart';
import 'app/translations/app_translations.dart';
import 'app/ui/screens/Error/incidentDashboardMyForm.dart';
import 'app/ui/screens/demo/sagawa_login.dart';
import 'app/ui/screens/inicident_dashboardForms.dart';




class MyHttpOverrides extends HttpOverrides{
  @override
  HttpClient createHttpClient(SecurityContext? context){
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port)=> true;
  }
}
void main() async {
  HttpOverrides.global = MyHttpOverrides();
  WidgetsFlutterBinding.ensureInitialized();
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();

  runApp(

 GetMaterialApp(
  debugShowCheckedModeBanner: false,
  theme: ThemeData(primarySwatch: Colors.grey),
  initialRoute: '/',
  getPages: AppRoutes.routes,
  translations: AppTranslations(),
  home:
 // IncidentDashboardMyForms(),
  // IncidentDashboardForms(),

   SagawaLogin(),
 //AllCommonWidgets(),
  //LoginPage(),
    // HomeScreen(),
  locale: const Locale('en'),
  )
  );
}

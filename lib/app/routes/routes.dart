

import 'package:get/get.dart';
import 'package:sofproject/app/ui/screens/demo/login_page.dart';



class AppRoutes{
  static final routes= [
    GetPage(name: '/', page:()=>  LoginPage(),),
   // // GetPage(name: '/', page:()=>  InitialLoginTest(),),
   //  GetPage(name: '/profile', page:()=>  ProfilePage(),)
  ];
}
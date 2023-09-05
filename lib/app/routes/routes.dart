

import 'package:get/get.dart';
import 'package:sofproject/app/ui/screens/demo/login_page.dart';

import '../ui/screens/demo/initial_loading.dart';
import '../ui/screens/demo/sagawa_login.dart';



class AppRoutes{
  static final routes= [
    GetPage(name: '/', page:()=>  InitialLoginTest(),),
   // // GetPage(name: '/', page:()=>  InitialLoginTest(),),
   //  GetPage(name: '/profile', page:()=>  ProfilePage(),)
  ];
}
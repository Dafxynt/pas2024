import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pas_mobile_11pplg1_10/binding/binding.dart';
import 'package:pas_mobile_11pplg1_10/login/logView.dart';
import 'package:pas_mobile_11pplg1_10/menu/efootball/efootball_api.dart';
import 'package:pas_mobile_11pplg1_10/menu/favorite.dart';
import 'package:pas_mobile_11pplg1_10/menu/profile.dart';
import 'package:pas_mobile_11pplg1_10/register/postview.dart' as register;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      getPages: [
        GetPage(name: '/', page: () => register.PostView()),
        GetPage(name: '/login', page: () => LogView()),
        GetPage(
          name: '/efootball',
          page: () => efootballView(),
          binding: HomeBinding(),
        ),
        GetPage(
          name: '/favorite',
          page: () => FavoritePage(),
          binding: HomeBinding(),
        ),
        GetPage(
          name: '/profile',
          page: () => Profile(),
          binding: HomeBinding(),
        ),
      ],
      initialRoute: '/',
      home: register.PostView(),
    );
  }
}

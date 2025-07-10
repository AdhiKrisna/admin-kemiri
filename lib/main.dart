import 'package:admin_kemiri/routes/route_names.dart';
import 'package:admin_kemiri/routes/route_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/get_navigation.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Admin Kemiri',
      debugShowCheckedModeBanner: false,
      initialRoute: RouteNames.home,
      getPages: RoutePages.routes,
    );
  }
}
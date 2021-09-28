import 'package:f_authentication_template/ui/pages/authentication/login_page.dart';
import 'package:f_authentication_template/ui/pages/home/content.dart';
import 'package:f_authentication_template/domain/controllers/authentication_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    AuthenticationController controller = Get.find<AuthenticationController>();
    return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Authentication Flow',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        //El sistema debe elegir entre estas dos páginas, si el estado del usuario es logged in
        home: Obx(() => controller.logged ? Content() : LoginPage()));
  }
}

import 'package:f_authentication_template/ui/pages/authentication/login_page.dart';
import 'package:f_authentication_template/ui/pages/home/content.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'pages/authentication/signup_page.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Authentication Flow',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      //home: Content(),
      home: SignUpPage(),
    );
  }
}

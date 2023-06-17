import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_kel_6/config/asset.dart';
import 'package:project_kel_6/model/user.dart';
import 'package:project_kel_6/screen/admin/dashboard_admin.dart';

import 'screen/login.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData(
        primaryColor: Asset.colorPrimaryDark,
        scaffoldBackgroundColor: Colors.white,
      ),
      debugShowCheckedModeBanner: false,
      home: FutureBuilder(builder: (context, AsyncSnapshot<User?> snapshot) {
        return DashboardAdmin();
      }),
    );
  }
}

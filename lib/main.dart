import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tricycle/routes/routes.dart';

void main() {
  runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: Routes.splash,
      getPages: getPages,
    )
  );
}


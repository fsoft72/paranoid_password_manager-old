import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paranoid_password_manager/screens/home.dart';
import 'package:paranoid_password_manager/config/store.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    appStore.value.loadVault();
    appStore.value.createVaultDemo();

    return GetMaterialApp(
      title: 'Paranoid Password Manager',
      theme: ThemeData.dark(),
      home: const HomeScreen(),
    );
  }
}

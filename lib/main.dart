import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/Edit/EditInv.dart';
import 'package:flutter_application_1/Menu/menu.dart';
import 'package:flutter_application_1/Stock/stock.dart';
import 'package:flutter_application_1/fetch.dart';
import 'package:flutter_application_1/Menu/inventorypage.dart';
import 'package:flutter_application_1/Inventory/outstock.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_application_1/Login/signup.dart';
import 'package:flutter_application_1/Inventory/navInv.dart';
import 'package:flutter_application_1/Inventory/inventorystock.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  // Firebase.initializeApp();

  runApp(new MaterialApp(
    home: MenuScreen(),
    debugShowCheckedModeBanner: false,
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final Future<FirebaseApp> _fApp = Firebase.initializeApp();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
    );
  }
}

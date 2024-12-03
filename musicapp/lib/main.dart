import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:musicapp/views/home.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        home: const Home(),
        title: "Beats",
        theme: ThemeData(
            fontFamily: "regular",
            appBarTheme: const AppBarTheme(
                backgroundColor: Colors.transparent, elevation: 0)));
  }
}

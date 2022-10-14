import 'package:flutter/material.dart';
// import 'package:gsheets/gsheets.dart';
import 'package:sheet/google_sheets_api.dart';
import 'package:sheet/home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  GoogleSheetsApi().init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
    );
  }
}

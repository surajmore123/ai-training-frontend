import 'package:flutter/material.dart';
import 'screens/upload_screen.dart';
import 'screens/topics_screen.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        '/': (context) => const UploadScreen(),
        '/topics': (context) => const TopicsScreen(),
     
      },
    );
  }
}

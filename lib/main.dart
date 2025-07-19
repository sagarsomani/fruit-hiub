import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fruitapp/screens/splash_screen.dart';

void main() {
  runApp(ProviderScope(child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        useMaterial3: true,
        textTheme: TextTheme(
          bodyMedium: TextStyle(
            fontSize: 18,
            color: Color(0xFF27214D),
            fontFamily: 'Brandon Grotesque',
            fontWeight: FontWeight.w600,
          ),
          bodySmall: TextStyle(
            fontSize: 14,
            color: Color(0xFF5D577E),
            fontFamily: 'Brandon Grotesque',
          ),
        ),
      ),
      home: SplashScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

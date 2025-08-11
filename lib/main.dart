import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/auth_provider.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(
    ChangeNotifierProvider(create: (_) => AuthProvider(), child: const MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Change Networks Desktop',
      theme: ThemeData(
        colorScheme: ColorScheme.light(
          primary: const Color(0xFF0078D7), // Bright blue from logo
          secondary: const Color(0xFFFF4A5B), // Vibrant red-pink from arrow
        ),
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFFF2F4F8), // Light background for header
          elevation: 0,
          iconTheme: IconThemeData(color: Color(0xFF2C3E50)), // Dark neutral
          titleTextStyle: TextStyle(
            color: Color(0xFF2C3E50),
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        textTheme: const TextTheme(
          bodyMedium: TextStyle(
            fontSize: 16.0,
            color: Color(0xFF2C3E50), // Universal text tone
          ),
          headlineSmall: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Color(0xFF0078D7),
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF0078D7),
            foregroundColor: Colors.white,
            textStyle: const TextStyle(fontWeight: FontWeight.bold),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
        inputDecorationTheme: const InputDecorationTheme(
          border: OutlineInputBorder(),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xFF0078D7)),
          ),
          labelStyle: TextStyle(color: Color(0xFF2C3E50)),
        ),
      ),

      debugShowCheckedModeBanner: false,
      home: const HomeScreen(),
    );
  }
}

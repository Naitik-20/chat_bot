import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'chat_bot_home.dart';
import 'forgot.dart';
import 'login.dart';
import 'sign-up.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MindCare AI',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(0xFFE6F2FF),
        colorScheme: const ColorScheme(
          brightness: Brightness.light,
          primary: Color(0xFF1E3A8A), // Deep blue
          onPrimary: Colors.white,
          secondary: Color(0xFF38B6FF), // Sky blue
          onSecondary: Colors.white,
          background: Color(0xFFE6F2FF),
          onBackground: Color(0xFF1F2937),
          surface: Colors.white,
          onSurface: Color(0xFF1F2937),
          error: Colors.red,
          onError: Colors.white,
        ),
        textTheme: GoogleFonts.poppinsTextTheme().copyWith(
          titleLarge: GoogleFonts.poppins(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: const Color(0xFF1F2937),
          ),
          bodyMedium: GoogleFonts.poppins(
            fontSize: 16,
            color: const Color(0xFF6B7280),
          ),
          labelLarge: GoogleFonts.poppins(
            fontSize: 16,
            color: Colors.white,
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF1E3A8A),
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 14),
            elevation: 6,
          ),
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF1E3A8A),
          foregroundColor: Colors.white,
          elevation: 0,
        ),
        cardTheme: CardThemeData(
          color: Colors.white,
          elevation: 4,
          margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
      ),
      home: const ChatBotHomePage(),
    );
  }
}

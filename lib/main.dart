import 'package:ai_chatbot/onboarding.dart';
import 'package:ai_chatbot/theme.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const GeminiChatApp());
}

class GeminiChatApp extends StatelessWidget {
  const GeminiChatApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Gemini Chat",
      theme: lightMode,
      darkTheme: darkMode,
      // themeMode: ThemeMode.dark,
      home: const OnboardingPage(),
    );
  }
}

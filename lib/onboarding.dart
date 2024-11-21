import 'package:ai_chatbot/home.dart';
import 'package:ai_chatbot/responsive.dart';
import 'package:flutter/material.dart';

class OnboardingPage extends StatelessWidget {
  const OnboardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: SizedBox(
            width: context.isTabletScreen
                ? context.screenWidth
                : context.responsiveScreenWidth,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const Column(
                  children: [
                    Text(
                      "Your AI Assistant",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                      ),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Text(
                      "Use this app to ask Gemini about everything that come to your mind. Powered by the lastest Gemini model (kind of?)",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 32,
                ),
                SizedBox(
                  width: 400,
                  child: Image.asset("assets/gemini_splash.png"),
                ),
                const SizedBox(
                  height: 32,
                ),
                Align(
                  alignment: context.isPhoneScreen
                      ? Alignment.bottomRight
                      : Alignment.center,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const HomePage(),
                        ),
                        (route) => false,
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      padding: const EdgeInsets.symmetric(
                        vertical: 16,
                        horizontal: 32,
                      ),
                    ),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text("Continue"),
                        SizedBox(
                          height: 8,
                        ),
                        Icon(
                          Icons.arrow_forward,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:ai_chatbot/message.dart';
import 'package:ai_chatbot/responsive.dart';
import 'package:ai_chatbot/theme_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _textEditingController = TextEditingController();

  final List<Message> _message = [];

  bool _isLoading = false;
  callGeminiModel() async {
    try {
      String prompt = "";
      if (_textEditingController.text.isNotEmpty) {
        _message.add(Message(text: _textEditingController.text, isUser: true));
        _isLoading = true;

        prompt = _textEditingController.text.trim();
        _textEditingController.clear();

        setState(() {});
      }

      final model = GenerativeModel(
        model: dotenv.env['GEMINI_MODEL']!,
        apiKey: dotenv.env['GOOGLE_API_KEY']!,
      );

      final content = [Content.text(prompt)];
      final response = await model.generateContent(content);

      setState(() {
        _message.add(Message(text: response.text!, isUser: false));
        _isLoading = false;
      });
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        actions: [
          PopupMenuButton(
            offset: const Offset(0, 50),
            itemBuilder: (context) {
              return [
                PopupMenuItem(
                  child: Row(
                    children: [
                      Theme.of(context).brightness == Brightness.dark
                          ? const Icon(Icons.dark_mode)
                          : const Icon(Icons.light_mode),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        Theme.of(context).brightness == Brightness.dark
                            ? "Light Mode"
                            : "Dark Mode",
                      ),
                    ],
                  ),
                  onTap: () {
                    context.read<ThemeCubit>().updateTheme(
                          Theme.of(context).brightness == Brightness.dark
                              ? ThemeMode.light
                              : ThemeMode.dark,
                        );
                  },
                )
              ];
            },
          ),
        ],
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                SizedBox(
                  width: 40,
                  child: Image.asset(
                    "assets/gemini_icon.png",
                    isAntiAlias: true,
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                const Text(
                  "Gemini GPT",
                ),
              ],
            ),
          ],
        ),
      ),
      body: Center(
        child: SizedBox(
          width: context.isTabletScreen
              ? context.screenWidth
              : context.responsiveScreenWidth,
          child: Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: _message.length,
                  itemBuilder: (context, index) {
                    final message = _message[index];
                    return ListTile(
                      title: Align(
                        alignment: message.isUser
                            ? Alignment.centerRight
                            : Alignment.centerLeft,
                        child: Container(
                          padding: const EdgeInsets.all(
                            10,
                          ),
                          decoration: BoxDecoration(
                            color:
                                message.isUser ? Colors.blue : Colors.grey[350],
                            borderRadius: message.isUser
                                ? const BorderRadius.only(
                                    topLeft: Radius.circular(20),
                                    bottomLeft: Radius.circular(20),
                                    bottomRight: Radius.circular(20),
                                  )
                                : const BorderRadius.only(
                                    topRight: Radius.circular(20),
                                    bottomLeft: Radius.circular(20),
                                    bottomRight: Radius.circular(20),
                                  ),
                          ),
                          child: Text(
                            message.text,
                            style: TextStyle(
                              color:
                                  message.isUser ? Colors.white : Colors.black,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  bottom: 32,
                  top: 16,
                  left: 16,
                  right: 16,
                ),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(32),
                    border: Border.all(
                      color: Colors.grey.withOpacity(0.8),
                    ),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _textEditingController,
                          decoration: const InputDecoration(
                            hintText: "Ask me anything",
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: 20,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      _isLoading
                          ? const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: SizedBox(
                                width: 25,
                                height: 25,
                                child: CircularProgressIndicator(),
                              ),
                            )
                          : IconButton(
                              onPressed: () => callGeminiModel(),
                              icon: const Icon(
                                Icons.send,
                                color: Colors.blue,
                              ),
                            ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

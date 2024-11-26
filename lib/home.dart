import 'package:ai_chatbot/dio_config.dart';
import 'package:ai_chatbot/message.dart';
import 'package:ai_chatbot/responsive.dart';
import 'package:ai_chatbot/theme_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _textEditingController = TextEditingController();

  final List<Message> _message = [];

  final dio = createDioInstance();

  bool _isLoading = false;
  fetchApi() async {
    try {
      String prompt = "";
      prompt = _textEditingController.text.trim();
      if (prompt.isEmpty) {
        return;
      }

      _message.add(Message(text: prompt, isUser: true));
      _textEditingController.clear();
      setState(() {
        _isLoading = true;
      });

      final response = await dio.post(
        "/",
        data: {
          "message": prompt,
        },
      );

      _message.add(Message(text: response.data["message"], isUser: false));
      setState(() {
        _isLoading = false;
      });
    } catch (e) {
      _message.add(
        Message(
            text: "There is an error right now: ${e.toString()}",
            isUser: false,
            isErrorMessage: true),
      );
      setState(() {
        _isLoading = false;
      });
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
                            border: message.isUser
                                ? null
                                : Border.all(
                                    color: Colors.grey.withOpacity(0.8),
                                  ),
                            color: message.isUser
                                ? Colors.blue
                                : (message.isErrorMessage
                                    ? Colors.red[700]
                                    : Colors.transparent),
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
                          child: message.isUser
                              ? Text(
                                  message.text,
                                )
                              : MarkdownBody(
                                  data: message.text,
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
                          onSubmitted: (value) => fetchApi(),
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
                              onPressed: () => fetchApi(),
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

import 'package:ai_chatbot/message.dart';
import 'package:ai_chatbot/responsive.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _textEditingController = TextEditingController();

  final List<Message> _message = [
    Message(text: "Hi", isUser: true),
    Message(text: "What's up", isUser: false),
    Message(text: "good", isUser: true),
    Message(text: "same", isUser: false),
  ];

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
                  child: const Text("Change mode"),
                  onTap: () {
                    //didnt work, might need to implement with hydrated_bloc later
                    Theme.of(context).brightness == Brightness.light
                        ? MediaQuery.platformBrightnessOf(context) ==
                            Brightness.light
                        : MediaQuery.platformBrightnessOf(context) ==
                            Brightness.dark;
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
                      IconButton(
                        onPressed: () {},
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

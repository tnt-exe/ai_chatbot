class Message {
  final String text;
  final bool isUser;
  final bool isErrorMessage;

  Message({
    required this.text,
    required this.isUser,
    this.isErrorMessage = false,
  });
}

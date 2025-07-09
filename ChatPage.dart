import 'package:flutter/material.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _controller = TextEditingController();
  final List<Map<String, dynamic>> _messages = [];

  final List<String> _aiResponses = [
    "Take a deep breath, you're doing okay. 💜",
    "I'm here for you, always. 🤗",
    "Remember: You are enough. 🌸",
    "Let's take things one step at a time. 🧘",
    "Would you like to reflect on your day?"
  ];

  void _sendMessage() {
    final text = _controller.text.trim();
    if (text.isEmpty) return;

    setState(() {
      _messages.add({'sender': 'user', 'text': text});
    });

    _controller.clear();

    Future.delayed(const Duration(milliseconds: 600), () {
      final response = (_aiResponses..shuffle()).first;
      setState(() {
        _messages.add({'sender': 'bot', 'text': response});
      });
    });
  }

  Widget _buildMessage(String text, bool isUser) {
    return Align(
      alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isUser
              ? const Color(0xFFB2DFDB) // Teal Blue light
              : const Color(0xFFFFCDD2), // Coral Pink light
          borderRadius: BorderRadius.circular(15),
        ),
        child: Text(
          text,
          style: const TextStyle(
            fontFamily: 'Nunito',
            fontSize: 15,
            color: Color(0xFF333333), // Charcoal
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEDE7F6), // Soft Lavender
      appBar: AppBar(
        title: const Text(
          'Chat with MANKU',
          style: TextStyle(
            fontFamily: 'Nunito',
            fontWeight: FontWeight.bold,
            fontSize: 18,
            color: Colors.white,
          ),
        ),
        backgroundColor: const Color(0xFFFF8A80), // Coral Pink
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _messages.length,
              itemBuilder: (_, index) {
                final msg = _messages[index];
                return _buildMessage(msg['text'], msg['sender'] == 'user');
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            color: const Color(0xFFF5F5F5), // Soft Gray
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: const InputDecoration.collapsed(
                      hintText: 'express your feelings buddy ...',
                      hintStyle: TextStyle(
                        fontFamily: 'Nunito',
                        color: Color(0xFF333333),
                      ),
                    ),
                    style: const TextStyle(
                      fontFamily: 'Nunito',
                      color: Color(0xFF333333),
                    ),
                    onSubmitted: (_) => _sendMessage(),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send, color: Color(0xFF333333)),
                  onPressed: _sendMessage,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

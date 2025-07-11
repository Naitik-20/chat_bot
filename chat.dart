import 'package:chat_bot/landing.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'dart:async';
import 'package:model_viewer_plus/model_viewer_plus.dart'; // <--- NEW IMPORT
import 'explore.dart';

// ... (ChatMessage class is the same)
class ChatMessage {
  final String text;
  final bool isUserMessage;
  ChatMessage({required this.text, required this.isUserMessage});
}

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  // ... (controllers and lists are the same)
  final TextEditingController _textController = TextEditingController();
  final List<ChatMessage> _messages = [];
  final ScrollController _scrollController = ScrollController();

  final SpeechToText _speechToText = SpeechToText();
  bool _speechEnabled = false;
  bool _isListening = false;

  @override
  void initState() {
    super.initState();
    _initSpeech();
  }

  void _initSpeech() async {
    print("--- Initializing SpeechToText ---");
    try {
      _speechEnabled = await _speechToText.initialize(
        onStatus: (status) => print('SpeechToText status: $status'),
        onError: (error) => print('SpeechToText error: $error'),
      );
      if (_speechEnabled) {
        print("--- SpeechToText Initialized Successfully ---");
      } else {
        print("--- SpeechToText Initialization Failed ---");
      }
    } catch (e) {
      print("--- EXCEPTION during SpeechToText initialization: $e ---");
      _speechEnabled = false;
    }
    setState(() {});
  }

  void _toggleListening() async {
    print("--- Mic button tapped ---");
    if (!_speechEnabled) {
      print("Speech recognition is not enabled/initialized.");
      return;
    }

    if (_isListening) {
      print("Stopping listening...");
      await _speechToText.stop();
      setState(() => _isListening = false);
      print("Stopped listening.");
    } else {
      print("Starting listening...");
      setState(() => _isListening = true);
      _speechToText.listen(
        onResult: (result) {
          print("Words recognized: ${result.recognizedWords}");
          setState(() {
            _textController.text = result.recognizedWords;
            if (result.finalResult) {
              print("Final result received.");
              _isListening = false;
            }
          });
        },
      );
    }
  }

  void _handleSubmitted(String text) {
    if (text.isEmpty) return;
    _textController.clear();
    setState(() {
      _messages.insert(0, ChatMessage(text: text, isUserMessage: true));
      if (_isListening) {
        _speechToText.stop();
        _isListening = false;
      }
    });
    Timer(const Duration(milliseconds: 800), () {
      String botResponse = _getBotResponse(text);
      setState(() {
        _messages.insert(0, ChatMessage(text: botResponse, isUserMessage: false));
      });
    });
  }

  String _getBotResponse(String userInput) {
    String input = userInput.toLowerCase();
    if (input.contains('hello') || input.contains('hi')) {
      return 'Hello there, jaggu! How can I assist you?';
    } else if (input.contains('how are you')) {
      return 'I am just a bunch of code, but I am functioning perfectly! Thanks for asking.';
    } else if (input.contains('help')) {
      return 'Of course! You can ask me about the weather, set a reminder, or just chat.';
    } else if (input.contains('time')) {
      return 'The current time is ${TimeOfDay.now().format(context)}.';
    } else {
      return 'Sorry, I am not smart enough to understand that yet. I am still learning!';
    }
  }

  @override
  void dispose() {
    _textController.dispose();
    _scrollController.dispose();
    _speechToText.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xFF4B0082), // Darker purple (similar to top-left in image)
                  Color(0xFF8A2BE2), // Medium purple
                  Color(0xFF4682B4),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
          SafeArea(
            child: Column(
              children: [
                _buildAppBar(),
                const SizedBox(height: 10),
                _buildRobotAvatar(), // This will now display your 3D model
                _buildWelcomeText(),
                const SizedBox(height: 20),
                Expanded(
                  child: ListView.builder(
                    controller: _scrollController,
                    reverse: true,
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    itemCount: _messages.length,
                    itemBuilder: (context, index) {
                      return _buildMessageBubble(_messages[index]);
                    },
                  ),
                ),
                _buildTextInputArea(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // --- WIDGET WITH THE CHANGE ---
  // --- THE GUARANTEED FIX ---
  Widget _buildAppBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 10.0), // Adjusted padding for IconButton
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // THE BEST SOLUTION: Use an IconButton and give it our custom widget as the 'icon'.
          // IconButton is designed to be tappable and handles its own padding and hitbox.
          IconButton(
            onPressed: () {
              print("Custom menu icon tapped! (IconButton)"); // For debugging
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const LandingPage()),
              );
            },
            // The 'icon' property can be any widget, not just an Icon.
            icon: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min, // Important to keep the column size tight
              children: [
                Container(
                  height: 3,
                  width: 15,
                  margin: const EdgeInsets.only(bottom: 4),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                Container(
                  height: 3,
                  width: 25,
                  margin: const EdgeInsets.only(bottom: 4),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                Container(
                  height: 3,
                  width: 18,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ],
            ),
          ),
          Text(
            "Cosmic Soul",
            style: GoogleFonts.poppins(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w500),
          ),
          // A placeholder to keep the title centered.
          // It's 48 because the default IconButton size is 48x48.
          const SizedBox(width: 48),
        ],
      ),
    );
  }

  Widget _buildRobotAvatar() {
    // --- THIS IS THE UPDATED PART ---
    return const SizedBox( // Using SizedBox to control the dimensions for the 3D model
      height: 420, // Keep original height
      width: double.infinity, // Allow it to take full width
      child: ModelViewer(
        src: 'assets/avtar.glb', // ✨ IMPORTANT: Replace 'assets/your_model.glb' with the actual path to your GLB file ✨
        alt: 'A 3D chat assistant model',
        ar: true,
        autoRotate: true,
        cameraControls: true,
        shadowIntensity: 1,
        backgroundColor: Colors.transparent, // Make background transparent to blend with gradient
      ),
    );
  }

  Widget _buildWelcomeText() {
    return Column(
      children: [
        Text("Welcome back", style: GoogleFonts.poppins(color: Colors.white.withOpacity(0.7), fontSize: 16)),
        Text("How may I help you today?", textAlign: TextAlign.center, style: GoogleFonts.poppins(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold)),
      ],
    );
  }

  Widget _buildMessageBubble(ChatMessage message) {
    final isUser = message.isUserMessage;
    return Align(
      alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 5.0),
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
        constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.7),
        decoration: BoxDecoration(
          color: isUser ? const Color(0xFF6A5AE0) : Colors.white.withOpacity(0.15),
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(20), topRight: const Radius.circular(20),
            bottomLeft: isUser ? const Radius.circular(20) : const Radius.circular(0),
            bottomRight: isUser ? const Radius.circular(0) : const Radius.circular(20),
          ),
        ),
        child: Text(message.text, style: GoogleFonts.poppins(color: Colors.white, fontSize: 15)),
      ),
    );
  }

  Widget _buildTextInputArea() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
      margin: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(30.0),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _textController,
              onSubmitted: _handleSubmitted,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: _isListening ? "Listening..." : "Type a message...",
                hintStyle: TextStyle(color: Colors.white.withOpacity(0.5)),
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(horizontal: 15),
              ),
            ),
          ),
          IconButton(
            icon: Icon(Icons.mic, color: _isListening ? Colors.pinkAccent : Colors.white70),
            onPressed: _toggleListening,
          ),
          IconButton(
            icon: Icon(Icons.send, color: Colors.white.withOpacity(0.8)),
            onPressed: () => _handleSubmitted(_textController.text),
          ),
        ],
      ),
    );
  }
}
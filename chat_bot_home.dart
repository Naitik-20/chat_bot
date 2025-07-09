import 'package:flutter/material.dart';
import 'ChatPage.dart';
import 'profile_page.dart';
import 'avatar_page.dart';
import 'settings_page.dart';
import 'login.dart';

class ChatBotHomePage extends StatelessWidget {
  const ChatBotHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // 🌈 Gradient background
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(0xFFDD92EF),
                  Color(0xFFD7CBEF),
                  Color(0xFFEDD8F4),
                ],
              ),
            ),
          ),

          // 📦 Top-left mobile-style icon buttons
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.only(top: 12.0, left: 12.0),
              child: Column(
                children: [
                  _buildMobileIconButton(
                    icon: Icons.person,
                    label: "Profile",
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const ProfilePage()),
                      );
                    },
                  ),
                  const SizedBox(height: 16),
                  _buildMobileIconButton(
                    icon: Icons.face_retouching_natural,
                    label: "Avatar",
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const AvatarPage()),
                      );
                    },
                  ),
                  const SizedBox(height: 16),
                  _buildMobileIconButton(
                    icon: Icons.settings,
                    label: "Settings",
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const SettingsPage()),
                      );
                    },
                  ),
                  const SizedBox(height: 16),
                  _buildMobileIconButton(
                    icon: Icons.logout,
                    label: "Logout",
                    onTap: () {
                      // Clear session here if needed
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (_) => const LoginPage()),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),

          // 💬 Chat button near bottom center
          Positioned(
            bottom: 80,
            left: 0,
            right: 0,
            child: Center(
              child: Container(
                decoration: BoxDecoration(
                  color: const Color(0xFFBB60D5),
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0xFFB38ED1),
                      blurRadius: 12,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: ElevatedButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const ChatPage()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    shadowColor: Colors.transparent,
                    padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  icon: const Icon(Icons.chat_rounded, size: 22, color: Colors.white),
                  label: const Text(
                    "Start Chat Now",
                    style: TextStyle(
                      fontFamily: 'Nunito',
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // 🔘 Mobile-style icon button
  Widget _buildMobileIconButton({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(
              color: const Color(0xFFEE84CA),
              borderRadius: BorderRadius.circular(50),
              border: Border.all(color: Color(0xFFC89EDC), width: 1.5),
              boxShadow: const [
                BoxShadow(
                  color: Color(0xFFB38ED1),
                  blurRadius: 6,
                  offset: Offset(2, 4),
                ),
              ],
            ),
            child: Center(
              child: Icon(
                icon,
                size: 30,
                color: Colors.white,
              ),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: const TextStyle(
              fontSize: 12,
              color: Color(0xFF5A2B72),
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

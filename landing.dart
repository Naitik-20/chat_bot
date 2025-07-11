import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:model_viewer_plus/model_viewer_plus.dart'; // <--- NEW IMPORT
import 'chat.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        // Use a BoxDecoration with LinearGradient for the background
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF4B0082), // Darker purple (similar to top-left in image)
              Color(0xFF8A2BE2), // Medium purple
              Color(0xFF4682B4), // Steel blue (similar to bottom-right in image)
            ],
          ),
        ),
        child: SingleChildScrollView( // Makes the content scrollable if it overflows
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 70.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center, // Center content vertically
              children: [
                // Add some top padding to push content down from status bar
                SizedBox(height: MediaQuery.of(context).padding.top + 20),

                // "Make It Awesome" Text
                Text(
                  'Make It\nAwesome',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.nunito(
                    fontSize: 48,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    height: 1.2, // Adjust line height for better appearance
                  ),
                ),
                const SizedBox(height: 10),

                // --- 3D Model Section (Replaced Image.asset) ---
                SizedBox( // Use SizedBox to control the dimensions for the 3D model
                  height: 350, // Keep original height
                  width: 250,  // Keep original width
                  child: const ModelViewer(
                    src: 'assets/avtar.glb', // ✨ IMPORTANT: Ensure this path is correct for your GLB file ✨
                    alt: '3D Avatar for Landing Page',
                    ar: true, // Enable AR if desired on the landing page
                    autoRotate: true, // Automatically rotate the model
                    cameraControls: true, // Allow user to control camera
                    shadowIntensity: 1,
                    backgroundColor: Colors.transparent, // Blend with gradient background
                    loading: Loading.eager, // Load the model eagerly
                    autoPlay: true, // Play animations if present
                  ),
                ),
                const SizedBox(height: 60),

                // V2.24 Button/Text
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2), // Semi-transparent white
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.white.withOpacity(0.3), width: 1),
                  ),
                  child: Text(
                    'V2.24',
                    style: GoogleFonts.nunito(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(height: 80),

                // "Nice to meet you! How can I help you?" Text
                Text(
                  'Nice to meet you! How can I help you?',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.nunito(
                    fontSize: 18,
                    color: Colors.white.withOpacity(0.8),
                  ),
                ),
                const SizedBox(height: 30),

                // "Get started" Button
                SizedBox(
                  width: double.infinity, // Make button full width
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const ChatScreen()), // Navigate to ChatPage
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white, // White background
                      foregroundColor: Colors.black, // Black text
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0), // Rounded corners
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      elevation: 5, // Add a subtle shadow
                    ),
                    child: Text(
                      'Get started',
                      style: GoogleFonts.nunito(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20), // Bottom padding
              ],
            ),
          ),
        ),
      ),
    );
  }
}
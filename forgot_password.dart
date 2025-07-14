import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  // Controller for the email input field
  final TextEditingController _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose(); // Dispose the controller
    super.dispose();
  }

  // Method to handle the submission logic
  void _sendResetInstructions() {
    if (_emailController.text.isNotEmpty) {
      print('Password reset instructions sent to: ${_emailController.text}');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'If an account exists for ${_emailController.text}, you will receive reset instructions.',
            style: GoogleFonts.nunito(),
          ),
          backgroundColor: Colors.green,
        ),
      );
      // Navigate back after a short delay
      Future.delayed(const Duration(seconds: 3), () {
        if (mounted) {
          Navigator.of(context).pop();
        }
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please enter your email address.', style: GoogleFonts.nunito()),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // Get screen dimensions for responsive layout, same as LoginPage
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      // The background color from the banner image
      backgroundColor: const Color(0xFF192352),
      body: Stack(
        children: [
          // The main scrollable content
          SingleChildScrollView(
            child: Column(
              children: [
                // --- Banner Image Section (Identical to LoginPage) ---
                Container(
                  height: screenHeight * 0.4,
                  width: double.infinity,
                  color: const Color(0xFF192352),
                  child: Padding(
                    padding: const EdgeInsets.all(.0),
                    child: Image.asset(
                      'assets/images/login_banner.jpg',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),

                // --- Form Section (Layout identical to LoginPage) ---
                // Using a Stack to place the white rounded container on top of a white background
                Stack(
                  children: [
                    // This container ensures the white background fills the rest of the screen
                    Container(
                      color: Colors.white,
                      constraints: BoxConstraints(minHeight: screenHeight * 0.6),
                      width: double.infinity,
                    ),
                    // The main form container with rounded corners
                    Container(
                      width: double.infinity,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30.0),
                          topRight: Radius.circular(30.0),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20.0),
                        child: _buildForgotPasswordForm(), // Form content
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          // --- Floating Back Button ---
          // Positioned on top of all other content
          Positioned(
            top: 40, // Adjust for status bar height
            left: 16,
            child: SafeArea( // Ensures it doesn't overlap with notches
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.2),
                  shape: BoxShape.circle,
                ),
                child: IconButton(
                  icon: const Icon(Icons.arrow_back, color: Colors.white),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Helper widget to build the form content for better organization
  Widget _buildForgotPasswordForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const SizedBox(height: 20),
        Text(
          'Reset Password',
          textAlign: TextAlign.center,
          style: GoogleFonts.nunito(
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        Text(
          'Enter the email associated with your account and we\'ll send an email with instructions to reset your password.',
          textAlign: TextAlign.center,
          style: GoogleFonts.nunito(
            fontSize: 16,
            color: Colors.grey.shade700,
          ),
        ),
        const SizedBox(height: 40),
        TextField(
          controller: _emailController,
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
            labelText: 'Email address',
            labelStyle: GoogleFonts.nunito(),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30.0),
            ),
            prefixIcon: const Icon(Icons.email_outlined),
          ),
        ),
        const SizedBox(height: 30),
        ElevatedButton(
          onPressed: _sendResetInstructions,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.black,
            foregroundColor: Colors.white,
            shape: const StadiumBorder(),
            padding: const EdgeInsets.symmetric(vertical: 16),
          ),
          child: Text(
            'Send Instructions',
            style: GoogleFonts.nunito(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(height: 40), // Add some bottom padding
      ],
    );
  }
}
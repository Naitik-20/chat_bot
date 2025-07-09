
import 'dart:ui'; // Required for ImageFilter.blur
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  // --- Unified Theme Colors (from login.dart) ---
  static const Color accentColor = Colors.black;
  static const Color mainTextColor = Colors.black;
  static const Color hintTextColor = Colors.black;
  static const Color headerTextColor = Color(0xff63432d); // Dark blue/green from SignUpPage header
  static const Color buttonColor = Color(0xff78533a);
  static const Color iconColor =  Color(0xff039af8);// Warm brown from SignUpPage button

  // Form key for validation
  final _formKey = GlobalKey<FormState>();

  // Controller for the email text field
  final _emailController = TextEditingController();

  // State variables
  bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  // The main logic to send a password reset link
  Future<void> _sendResetLink() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      // Simulate a network call to a password reset API
      await Future.delayed(const Duration(seconds: 2));

      setState(() {
        _isLoading = false;
      });

      // Show a success message using the theme colors
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Password reset link sent to your email!',
            style: GoogleFonts.nunito(color: Colors.black87),
          ),
          backgroundColor: accentColor, // Consistent snackbar color
        ),
      );

      // Optionally, pop the screen after a delay
      await Future.delayed(const Duration(milliseconds: 500));
      if (mounted) {
        Navigator.of(context).pop();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // The body is wrapped in a Container with the same gradient as other pages
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xff7ccaf8),
              Color(0xff66cbd9), // Light teal
              Color(0xfff2cca2),// Darker teal from SignUpPage
            ],
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _buildHeader(),
                const SizedBox(height: 32.0),
                ClipRRect( // Added ClipRRect for rounded corners
                  borderRadius: BorderRadius.circular(20.0),
                  child: BackdropFilter( // Added BackdropFilter for the frosted glass effect
                    filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                    child: Container(
                      padding: const EdgeInsets.all(24.0),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.8), // Semi-transparent white
                        borderRadius: BorderRadius.circular(20.0),
                        border: Border.all(
                          color: Colors.white.withOpacity(0.3),
                          width: 1.5,
                        ),
                      ),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            _buildEmailField(),
                            const SizedBox(height: 24.0),
                            _buildSendLinkButton(),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 24.0),
                _buildLoginLink(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Header for the Forgot Password page, styled consistently
  Widget _buildHeader() {
    return Column(
      children: [
        Icon(
          Icons.lock_reset_rounded,
          size: 80,
          color: headerTextColor, // Using the consistent header color
        ),
        const SizedBox(height: 16.0),
        Text(
          'Forgot Password?',
          style: GoogleFonts.nunito(
            fontSize: 32, // Consistent font size
            fontWeight: FontWeight.bold,
            color: headerTextColor,
          ),
        ),
        const SizedBox(height: 8.0),
        Text(
          "Enter your email and we'll send you a link to reset your password.",
          style: GoogleFonts.nunito(
            fontSize: 20,
            color: headerTextColor, fontWeight: FontWeight.w500,  // Consistent style
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  // This helper is identical to the one in the other files for consistent styling
  InputDecoration _buildInputDecoration(String label, IconData icon) {
    return InputDecoration(
      labelText: label,
      labelStyle: GoogleFonts.nunito(color: hintTextColor, fontWeight: FontWeight.w700),
      prefixIcon: Icon(icon, color: iconColor, size: 24),
      border: InputBorder.none,
      focusedBorder: InputBorder.none,
      enabledBorder: InputBorder.none,
      errorBorder: InputBorder.none,
      disabledBorder: InputBorder.none,
      errorStyle: GoogleFonts.nunito(color: Colors.amber.shade400, fontWeight: FontWeight.bold),
    );
  }

  // Email input field, styled consistently
  Widget _buildEmailField() {
    return TextFormField(
      controller: _emailController,
      keyboardType: TextInputType.emailAddress,
      decoration: _buildInputDecoration('Email', Icons.email_outlined),
      style: GoogleFonts.nunito(color: mainTextColor, fontSize: 18),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your email';
        }
        if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value)) {
          return 'Please enter a valid email address';
        }
        return null;
      },
    );
  }

  // Button to send the reset link, styled consistently
  Widget _buildSendLinkButton() {
    return SizedBox(
      height: 50,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          backgroundColor: buttonColor, // Consistent button color
          foregroundColor: Colors.white,
        ),
        onPressed: _isLoading ? null : _sendResetLink,
        child: _isLoading
            ? const SizedBox(
          height: 24,
          width: 24,
          child: CircularProgressIndicator(
            color: Colors.white,
            strokeWidth: 3,
          ),
        )
            : Text(
          'Send Reset Link',
          style: GoogleFonts.nunito(
            fontSize: 18, // Consistent font size
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  // Link to navigate back to the login page, styled consistently
  Widget _buildLoginLink() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Remembered your password?",
          style: GoogleFonts.nunito(
            color: mainTextColor, // Consistent color and opacity
            fontSize: 18,
          ),
        ),
        TextButton(
          onPressed: () {
            // Simply pop the current screen to go back to the login page
            Navigator.of(context).pop();
          },
          child: Text(
            'Log In',
            style: GoogleFonts.nunito(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              color: accentColor, // Consistent link color
              decoration: TextDecoration.underline,
              decorationColor: accentColor,
            ),
          ),
        ),
      ],
    );
  }
}
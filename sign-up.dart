import 'dart:ui'; // Required for ImageFilter.blur
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'login.dart'; // Assuming you have a login.dart file

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  // --- Unified Theme Colors ---
  static const Color accentColor = Colors.black;
  static const Color mainTextColor = Colors.black;
  static const Color hintTextColor = Colors.black;
  static const Color iconColor =  Color(0xff039af8);
  // Form key for validation
  final _formKey = GlobalKey<FormState>();

  // Controllers for text fields
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  // State variables
  bool _isLoading = false;
  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> _signUp() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      // Simulate a network request or backend call
      await Future.delayed(const Duration(seconds: 2));

      setState(() {
        _isLoading = false;
      });

      // Show a success message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Sign-up successful!',
            style: GoogleFonts.nunito(color: Colors.black87),
          ),
          backgroundColor: accentColor,
        ),
      );

      // In a real application, after successful sign-up, you might navigate
      // to a home page or a verification screen.
      // Example: Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomePage()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xff7ccaf8),
              Color(0xff66cbd9), // Light teal
              Color(0xfff2cca2), // Darker teal
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
                ClipRRect(
                  borderRadius: BorderRadius.circular(20.0),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                    child: Container(
                      padding: const EdgeInsets.all(24.0),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.8), // Semi-transparent white for frosted glass effect
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
                            _buildNameField(),
                            const SizedBox(height: 16.0),
                            _buildEmailField(),
                            const SizedBox(height: 16.0),
                            _buildPasswordField(),
                            const SizedBox(height: 16.0),
                            _buildConfirmPasswordField(),
                            const SizedBox(height: 24.0),
                            _buildSignUpButton(),
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

  Widget _buildHeader() {
    return Column(
      children: [
        const SizedBox(height: 16.0),
        Text(
          'Create Your Account',
          style: GoogleFonts.nunito(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: const Color(0xff63432d), // Dark blue/green for header text
          ),
        ),
        const SizedBox(height: 8.0),
        Text(
          'Join our chat community today!',
          style: GoogleFonts.nunito(
              fontSize: 20,
              color: const Color(0xff63432d), fontWeight: FontWeight.w500
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  // Helper for the new BORDERLESS input decoration
  InputDecoration _buildInputDecoration(String label, IconData icon) {
    return InputDecoration(
      labelText: label,
      labelStyle: GoogleFonts.nunito(color: mainTextColor ,fontWeight: FontWeight.w700),
      prefixIcon: Icon(icon, color: iconColor, size: 24, ),

      // --- KEY CHANGE: REMOVING ALL BORDERS ---
      // This removes the border in all states: normal, focused, and error.
      border: InputBorder.none,
      focusedBorder: InputBorder.none,
      enabledBorder: InputBorder.none,
      errorBorder: InputBorder.none,
      disabledBorder: InputBorder.none,

      // The style for the validation error text remains
      errorStyle: GoogleFonts.nunito(color: Colors.amber.shade400, fontWeight: FontWeight.bold),
    );
  }

  Widget _buildNameField() {
    return TextFormField(
      controller: _nameController,
      decoration: _buildInputDecoration('Full Name', Icons.person_outline),
      style: GoogleFonts.nunito(color: mainTextColor, fontSize: 20, ),
      validator: (value) => (value == null || value.isEmpty) ? 'Please enter your full name' : null,
    );
  }

  Widget _buildEmailField() {
    return TextFormField(
      controller: _emailController,
      keyboardType: TextInputType.emailAddress,
      decoration: _buildInputDecoration('Email', Icons.email_outlined),
      style: GoogleFonts.nunito(color: mainTextColor, fontSize: 18),
      validator: (value) {
        if (value == null || value.isEmpty) return 'Please enter your email';
        if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value)) return 'Please enter a valid email address';
        return null;
      },
    );
  }

  Widget _buildPasswordField() {
    return TextFormField(
      controller: _passwordController,
      obscureText: !_isPasswordVisible,
      decoration: _buildInputDecoration('Password', Icons.lock_outline).copyWith(
        suffixIcon: IconButton(
          icon: Icon(
            _isPasswordVisible ? Icons.visibility_off : Icons.visibility,
            color: iconColor,
          ),
          onPressed: () => setState(() => _isPasswordVisible = !_isPasswordVisible),
        ),
      ),
      style: GoogleFonts.nunito(color: mainTextColor, fontSize: 18),
      validator: (value) {
        if (value == null || value.isEmpty) return 'Please enter a password';
        if (value.length < 6) return 'Password must be at least 6 characters long';
        return null;
      },
    );
  }

  Widget _buildConfirmPasswordField() {
    return TextFormField(
      controller: _confirmPasswordController,
      obscureText: !_isConfirmPasswordVisible,
      decoration: _buildInputDecoration('Confirm Password', Icons.lock_outline).copyWith( // Changed from Icons.lock_person_outline
        suffixIcon: IconButton(
          icon: Icon(
            _isConfirmPasswordVisible ? Icons.visibility_off : Icons.visibility,
            color: iconColor,
          ),
          onPressed: () => setState(() => _isConfirmPasswordVisible = !_isConfirmPasswordVisible),
        ),
      ),
      style: GoogleFonts.nunito(color: mainTextColor, fontSize: 18),
      validator: (value) {
        if (value == null || value.isEmpty) return 'Please confirm your password';
        if (value != _passwordController.text) return 'Passwords do not match';
        return null;
      },
    );
  }

  Widget _buildSignUpButton() {
    return SizedBox(
      height: 50,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
          backgroundColor: const Color(0xff78533a), // A warm brown for the button
          foregroundColor: Colors.white,
        ),
        onPressed: _isLoading ? null : _signUp,
        child: _isLoading
            ? const SizedBox(
          height: 24,
          width: 24,
          child: CircularProgressIndicator(color: Colors.white, strokeWidth: 3),
        )
            : Text(
          'Sign Up',
          style: GoogleFonts.nunito(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget _buildLoginLink() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Already have an account?",
          style: GoogleFonts.nunito(color: mainTextColor, fontSize: 22),
        ),
        TextButton(
          onPressed: () => Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const LoginPage()),
          ),
          child: Text(
            'Log In',
            style: GoogleFonts.nunito(
              fontWeight: FontWeight.bold,
              fontSize: 22,
              color: accentColor,
              decoration: TextDecoration.underline,
              decorationColor: accentColor,
            ),
          ),
        ),
      ],
    );
  }
}

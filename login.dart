import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'sign-up.dart';
import 'forgot.dart';
import 'chat_bot_home.dart'; // ✅ Make sure this is imported

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  static const Color accentColor = Colors.black;
  static const Color mainTextColor = Colors.black;
  static const Color iconColor = Color(0xff039af8);
  static const Color hintTextColor = Colors.black;
  static const Color headerTextColor = Color(0xff63432d);
  static const Color buttonColor = Color(0xff78533a);

  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _isLoading = false;
  bool _isPasswordVisible = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _logIn() async {
    if (_formKey.currentState!.validate()) {
      setState(() => _isLoading = true);
      await Future.delayed(const Duration(seconds: 2));
      setState(() => _isLoading = false);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Login successful!',
            style: GoogleFonts.nunito(color: Colors.black87),
          ),
          backgroundColor: accentColor,
        ),
      );

      // ✅ Navigate to home after login
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const ChatBotHomePage()),
        );
      }
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
              Color(0xff66cbd9),
              Color(0xfff2cca2),
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
                        color: Colors.white.withOpacity(0.8),
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
                            const SizedBox(height: 16.0),
                            _buildPasswordField(),
                            const SizedBox(height: 8.0),
                            _buildForgotPasswordLink(),
                            const SizedBox(height: 24.0),
                            _buildLoginButton(),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 24.0),
                _buildSignUpLink(),
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
        Icon(Icons.lock_open_rounded, size: 80, color: headerTextColor),
        const SizedBox(height: 16.0),
        Text(
          'Welcome Back!',
          style: GoogleFonts.nunito(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: headerTextColor,
          ),
        ),
        const SizedBox(height: 8.0),
        Text(
          'Log in to continue your journey.',
          style: GoogleFonts.nunito(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: headerTextColor,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

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
        return null;
      },
    );
  }

  Widget _buildForgotPasswordLink() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        TextButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const ForgotPasswordPage()),
            );
          },
          child: Text(
            'Forgot Password?',
            style: GoogleFonts.nunito(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: accentColor,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildLoginButton() {
    return SizedBox(
      height: 50,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
          backgroundColor: buttonColor,
          foregroundColor: Colors.white,
        ),
        onPressed: _isLoading ? null : _logIn,
        child: _isLoading
            ? const SizedBox(
          height: 26,
          width: 24,
          child: CircularProgressIndicator(
            color: Colors.white,
            strokeWidth: 3,
          ),
        )
            : Text(
          'Log In',
          style: GoogleFonts.nunito(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Widget _buildSignUpLink() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Don't have an account?",
          style: GoogleFonts.nunito(color: mainTextColor, fontSize: 20),
        ),
        TextButton(
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const SignUpPage()),
            );
          },
          child: Text(
            'Sign Up',
            style: GoogleFonts.nunito(
              fontWeight: FontWeight.bold,
              fontSize: 20,
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

import 'package:chat_bot/login.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart'; // Import google_fonts
import 'package:model_viewer_plus/model_viewer_plus.dart'; // <--- NEW IMPORT

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> with SingleTickerProviderStateMixin {
  // Animation controller to manage the animation
  late AnimationController _controller;
  // Animation for the slide-up effect of the form
  late Animation<Offset> _slideAnimation;
  // Animation for the fade-in effect of the form
  late Animation<double> _fadeAnimation;

  // TextEditingController for the password fields (initially empty)
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  // State variables to control password visibility
  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;

  @override
  void initState() {
    super.initState();

    // Initialize the animation controller
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000), // Total animation duration
    );

    // Define the slide animation (from bottom to center)
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 1), // Start off-screen (bottom)
      end: Offset.zero,          // End at its natural position
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut, // A nice easing curve
    ));

    // Define the fade animation (from transparent to opaque)
    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeIn,
    ));

    // Start the animation after a short delay to show the banner first
    Future.delayed(const Duration(milliseconds: 500), () {
      _controller.forward();
    });
  }

  @override
  void dispose() {
    _controller.dispose(); // Don't forget to dispose the controller
    _passwordController.dispose(); // Dispose the text editing controller
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Get screen dimensions for responsive layout
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      // The background color from the banner image
      backgroundColor: const Color(0xFF192352),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // --- Banner Section (now with 3D Model) ---
            Container(
              height: screenHeight * 0.4, // Occupies 40% of the screen height
              width: double.infinity,
              color: const Color(0xFF192352),
              child: const Padding( // Changed padding to 0.0 to let model fill
                padding: EdgeInsets.all(0.0),
                child: ModelViewer( // <--- REPLACED WITH ModelViewer
                  src: 'assets/avtar.glb', // ✨ IMPORTANT: Ensure this path is correct for your GLB file ✨
                  alt: '3D Avatar for Signup Screen',
                  ar: true, // Set to true if you want AR capabilities here
                  autoRotate: true, // Automatically rotate the model
                  cameraControls: true, // Allow user to control camera (zoom, pan, rotate)
                  shadowIntensity: 1,
                  backgroundColor: Colors.transparent, // Make background transparent to blend with container color
                  loading: Loading.eager, // Use the enum for eager loading
                  autoPlay: true, // If your model has animations, this will play them
                ),
              ),
            ),

            // --- Animated Form Section ---
            // This stack allows the form to slide up over the blue background
            Stack(
              children: [
                // A container to create the white background that fills the rest of the screen
                Container(
                  height: screenHeight * 0.6,
                  color: Colors.white,
                ),
                // The animated part
                SlideTransition(
                  position: _slideAnimation,
                  child: FadeTransition(
                    opacity: _fadeAnimation,
                    child: Container(
                      height: screenHeight * 0.6, // Must match the container above
                      width: double.infinity,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30.0),
                          topRight: Radius.circular(30.0),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 24.0, vertical: 20.0),
                        child: _buildSignupForm(),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Helper widget to build the form content for Signup
  Widget _buildSignupForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'Create Account',
          textAlign: TextAlign.center,
          style: GoogleFonts.nunito(
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 20),
        TextField(
          decoration: InputDecoration(
            labelText: 'Email address',
            labelStyle: GoogleFonts.nunito(),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30.0),
            ),
          ),
        ),
        const SizedBox(height: 20),
        TextField(
          controller: _passwordController,
          obscureText: !_isPasswordVisible, // Toggles visibility
          decoration: InputDecoration(
            labelText: 'Password',
            labelStyle: GoogleFonts.nunito(),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30.0),
            ),
            suffixIcon: IconButton(
              icon: Icon(
                _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                color: Colors.grey,
              ),
              onPressed: () {
                setState(() {
                  _isPasswordVisible = !_isPasswordVisible;
                });
              },
            ),
          ),
        ),
        const SizedBox(height: 20),
        TextField(
          controller: _confirmPasswordController,
          obscureText: !_isConfirmPasswordVisible, // Toggles visibility
          decoration: InputDecoration(
            labelText: 'Confirm Password',
            labelStyle: GoogleFonts.nunito(),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30.0),
            ),
            suffixIcon: IconButton(
              icon: Icon(
                _isConfirmPasswordVisible ? Icons.visibility : Icons.visibility_off,
                color: Colors.grey,
              ),
              onPressed: () {
                setState(() {
                  _isConfirmPasswordVisible = !_isConfirmPasswordVisible;
                });
              },
            ),
          ),
        ),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: () {
            // Handle signup
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const LoginPage()),
            );
            print('Signing up with Email: YourEmail@example.com, Password: ${_passwordController.text}');
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.black,
            foregroundColor: Colors.white,
            shape: const StadiumBorder(),
            padding: const EdgeInsets.symmetric(vertical: 16),
          ),
          child: Text(
            'Sign Up',
            style: GoogleFonts.nunito(fontSize: 16),
          ),
        ),
        const SizedBox(height: 20),
        RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            style: GoogleFonts.nunito(color: Colors.black, fontSize: 18),
            children: [
              const TextSpan(text: "Already have an account? "),
              TextSpan(
                text: 'Login',
                style: GoogleFonts.nunito(
                  color: Colors.blue,
                  fontWeight: FontWeight.bold,
                ),
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    // Handle navigation back to login
                    Navigator.pop(context); // Goes back to the previous route
                    print('Login tapped!');
                  },
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),

        const Spacer(), // Use Spacer to push the bottom elements down
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
              onPressed: () {},
              child: Text(
                'Terms of Use',
                style: GoogleFonts.nunito(),
              ),
            ),
            Text(
              '|',
              style: GoogleFonts.nunito(),
            ),
            TextButton(
              onPressed: () {},
              child: Text(
                'Privacy Policy',
                style: GoogleFonts.nunito(),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
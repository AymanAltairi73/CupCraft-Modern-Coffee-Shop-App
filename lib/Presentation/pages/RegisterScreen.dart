import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'authService.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
    final AuthService _authService = AuthService();

  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;
  bool _isLoading = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  String _getErrorMessage(String code) {
    switch (code) {
      case 'email-already-in-use':
        return 'This email is already registered';
      case 'invalid-email':
        return 'Invalid email address';
      case 'operation-not-allowed':
        return 'Email/password accounts are not enabled';
      case 'weak-password':
        return 'Password is too weak';
      default:
        return 'An error occurred during registration';
    }
  }

  Future<void> _register() async {
    if (!_formKey.currentState!.validate()) return;

    try {
      setState(() => _isLoading = true);

      // Create user account
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );

      // Update user profile with name
      await userCredential.user?.updateDisplayName(_nameController.text.trim());

      // Navigate to home screen
     if (mounted) {
        Navigator.pushNamedAndRemoveUntil(
          context, 
          '/home',
          (route) => false,
        );
      }
    } on FirebaseAuthException catch (e) {
      print("Firebase Auth Error: ${e.code} - ${e.message}"); // For debugging
      Get.snackbar(
        'Error',
        _getErrorMessage(e.code),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
        duration: const Duration(seconds: 3),
        margin: const EdgeInsets.all(8),
        borderRadius: 8,
      );
    } catch (e) {
      print("Unexpected Error: $e"); // For debugging
      Get.snackbar(
        'Error',
        'An unexpected error occurred',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }
    Future<void> _handleGoogleSignIn() async {
    try {
      setState(() => _isLoading = true);

      final UserCredential? userCredential = await _authService.signInWithGoogle();

      if (userCredential != null && mounted) {
        // Show success message
        Get.snackbar(
          'Success',
          'Successfully signed in with Google',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white,
          duration: const Duration(seconds: 2),
          margin: const EdgeInsets.all(8),
          borderRadius: 8,
        );

        // Navigate to home screen
        Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
      }
    } catch (e) {
      print("Google Sign In Error in LoginScreen: $e");
      Get.snackbar(
        'Error',
        'Failed to sign in with Google. Please try again.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
        duration: const Duration(seconds: 3),
        margin: const EdgeInsets.all(8),
        borderRadius: 8,
      );
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background Image
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/login-bg.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Black Overlay
          Container(color: Colors.black.withOpacity(0.5)),
          // Main Content
          SafeArea(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      const SizedBox(height: 40),
                      // Logo
                      Image.asset(
                        'assets/images/logo.png',
                        width: 60,
                        height: 60,
                        color: const Color(0xFFCE9760),
                      ),
                      const SizedBox(height: 20),
                      // Title
                      const Text(
                        'Register your Account',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Poppins',
                        ),
                      ),
                      const SizedBox(height: 40),
                      // Full Name TextField
                      TextFormField(
                        controller: _nameController,
                        style: const TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          hintText: 'Full Name',
                          hintStyle: TextStyle(color: Colors.grey[600]),
                          filled: true,
                          fillColor: const Color(0xFF1E1E1E),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide.none,
                          ),
                          prefixIcon: const Icon(
                            Icons.person,
                            color: Color(0xFFCE9760),
                          ),
                          contentPadding: const EdgeInsets.all(16),
                          errorStyle: const TextStyle(color: Color(0xFFCE9760)),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your full name';
                          }
                          if (value.length < 3) {
                            return 'Name must be at least 3 characters';
                          }
                          if (!RegExp(r'^[a-zA-Z\s]+$').hasMatch(value)) {
                            return 'Name can only contain letters and spaces';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      // Email TextField
                      TextFormField(
                        controller: _emailController,
                        style: const TextStyle(color: Colors.white),
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          hintText: 'E-mail Address',
                          hintStyle: TextStyle(color: Colors.grey[600]),
                          filled: true,
                          fillColor: const Color(0xFF1E1E1E),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide.none,
                          ),
                          prefixIcon: const Icon(
                            Icons.email,
                            color: Color(0xFFCE9760),
                          ),
                          contentPadding: const EdgeInsets.all(16),
                          errorStyle: const TextStyle(color: Color(0xFFCE9760)),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your email';
                          }
                          if (!GetUtils.isEmail(value)) {
                            return 'Please enter a valid email address';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      // Password TextField
                      TextFormField(
                        controller: _passwordController,
                        style: const TextStyle(color: Colors.white),
                        obscureText: _obscurePassword,
                        decoration: InputDecoration(
                          hintText: 'Password',
                          hintStyle: TextStyle(color: Colors.grey[600]),
                          filled: true,
                          fillColor: const Color(0xFF1E1E1E),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide.none,
                          ),
                          prefixIcon: const Icon(
                            Icons.lock,
                            color: Color(0xFFCE9760),
                          ),
                          suffixIcon: IconButton(
                            icon: Icon(
                              _obscurePassword
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: const Color(0xFFCE9760),
                            ),
                            onPressed: () => setState(
                                () => _obscurePassword = !_obscurePassword),
                          ),
                          contentPadding: const EdgeInsets.all(16),
                          errorStyle: const TextStyle(color: Color(0xFFCE9760)),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a password';
                          }
                          if (value.length < 8) {
                            return 'Password must be at least 8 characters';
                          }
                          if (!value.contains(RegExp(r'[A-Z]'))) {
                            return 'Password must contain at least one uppercase letter';
                          }
                          if (!value.contains(RegExp(r'[a-z]'))) {
                            return 'Password must contain at least one lowercase letter';
                          }
                          if (!value.contains(RegExp(r'[0-9]'))) {
                            return 'Password must contain at least one number';
                          }
                          if (!value
                              .contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
                            return 'Password must contain at least one special character';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      // Confirm Password TextField
                      TextFormField(
                        controller: _confirmPasswordController,
                        style: const TextStyle(color: Colors.white),
                        obscureText: _obscureConfirmPassword,
                        decoration: InputDecoration(
                          hintText: 'Confirm Password',
                          hintStyle: TextStyle(color: Colors.grey[600]),
                          filled: true,
                          fillColor: const Color(0xFF1E1E1E),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide.none,
                          ),
                          prefixIcon: const Icon(
                            Icons.lock_outline,
                            color: Color(0xFFCE9760),
                          ),
                          suffixIcon: IconButton(
                            icon: Icon(
                              _obscureConfirmPassword
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: const Color(0xFFCE9760),
                            ),
                            onPressed: () => setState(() =>
                                _obscureConfirmPassword = !_obscureConfirmPassword),
                          ),
                          contentPadding: const EdgeInsets.all(16),
                          errorStyle: const TextStyle(color: Color(0xFFCE9760)),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please confirm your password';
                          }
                          if (value != _passwordController.text) {
                            return 'Passwords do not match';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 24),
                      // Register Button
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: _isLoading ? null : _register,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFCE9760),
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            disabledBackgroundColor:
                                const Color(0xFFCE9760).withOpacity(0.6),
                          ),
                          child: _isLoading
                              ? const SizedBox(
                                  height: 20,
                                  width: 20,
                                  child: CircularProgressIndicator(
                                    color: Colors.black,
                                    strokeWidth: 2,
                                  ),
                                )
                              : const Text(
                                  'Register',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                        ),
                      ),
                      const SizedBox(height: 30),
                      // Social Login Section
                      Row(
                        children: [
                          const Expanded(
                              child: Divider(color: Color(0xFFCE9760))),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Text(
                              'Or Register with',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          const Expanded(
                              child: Divider(color: Color(0xFFCE9760))),
                        ],
                      ),
                      const SizedBox(height: 30),
                      // Social Login Buttons
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _socialLoginButton(
                            'assets/images/facebook.png',
                            onTap: () {
                            },
                          ),
                          _socialLoginButton(
                            'assets/images/google.png',
                          onTap: _handleGoogleSignIn,
                          ),
                          _socialLoginButton(
                            'assets/images/twitter.png',
                            onTap: () {
                            },
                          ),
                        ],
                      ),
                      const SizedBox(height: 40),
                      // Login Link
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'Already have an account?',
                            style: TextStyle(color: Colors.white),
                          ),
                          TextButton(
                            onPressed: () =>
                                Navigator.pushReplacementNamed(context, '/login'),
                            child: const Text(
                              'Login',
                              style: TextStyle(
                                color: Color(0xFFCE9760),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _socialLoginButton(String iconPath, {VoidCallback? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 65,
        height: 65,
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.7),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Center(
          child: Image.asset(
            iconPath,
            width: 24,
            height: 24,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
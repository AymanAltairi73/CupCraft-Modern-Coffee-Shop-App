import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:developer' as developer;

import 'authService.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final AuthService _authService = AuthService();
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;
  bool _isLoading = false;
  bool _rememberMe = false;

  // Keys for SharedPreferences
  static const String _savedEmailKey = 'saved_email';
  static const String _savedPasswordKey = 'saved_password';
  static const String _rememberMeKey = 'remember_me';

  @override
  void initState() {
    super.initState();
    // Load saved credentials if they exist
    _loadSavedCredentials();
  }

  // WARNING: Storing passwords locally is not secure for production
  // This should only be used during development or with proper encryption
  Future<void> _loadSavedCredentials() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final savedEmail = prefs.getString(_savedEmailKey);
      final savedPassword = prefs.getString(_savedPasswordKey);
      final rememberMeValue = prefs.getBool(_rememberMeKey);

      if (savedEmail != null && savedPassword != null && rememberMeValue == true) {
        setState(() {
          _emailController.text = savedEmail;
          _passwordController.text = savedPassword;
          _rememberMe = true;
        });
        developer.log('Loaded saved credentials for development convenience', name: 'LoginScreen');
      }
    } catch (e) {
      developer.log('Error loading saved credentials: $e', name: 'LoginScreen');
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  String _getErrorMessage(String code) {
    switch (code) {
      case 'user-not-found':
        return 'No account found with this email';
      case 'wrong-password':
        return 'Incorrect password';
      case 'invalid-email':
        return 'Invalid email address';
      case 'user-disabled':
        return 'This account has been disabled';
      case 'too-many-requests':
        return 'Too many attempts. Please try again later';
      case 'operation-not-allowed':
        return 'Email/password sign in is not enabled';
      case 'network-request-failed':
        return 'Network connection failed';
      case 'invalid-credential':
        return 'Invalid credentials';
      case 'account-exists-with-different-credential':
        return 'An account already exists with this email using different sign-in method';
      default:
        return 'An unexpected error occurred: $code';
    }
  }

  // WARNING: Storing passwords locally is not secure for production
  // This should only be used during development or with proper encryption
  Future<void> _saveCredentials() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      if (_rememberMe) {
        // Save credentials only if "Remember Me" is checked
        await prefs.setString(_savedEmailKey, _emailController.text.trim());
        await prefs.setString(_savedPasswordKey, _passwordController.text.trim());
        await prefs.setBool(_rememberMeKey, true);
        developer.log('Credentials saved for development convenience', name: 'LoginScreen');
      } else {
        // Clear saved credentials if "Remember Me" is unchecked
        await prefs.remove(_savedEmailKey);
        await prefs.remove(_savedPasswordKey);
        await prefs.remove(_rememberMeKey);
        developer.log('Credentials cleared', name: 'LoginScreen');
      }
    } catch (e) {
      developer.log('Error saving credentials: $e', name: 'LoginScreen');
    }
  }

  Future<void> _signIn() async {
    if (!_formKey.currentState!.validate()) return;

    try {
      setState(() => _isLoading = true);

      // Sign in user
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
            email: _emailController.text.trim(),
            password: _passwordController.text.trim(),
          );

      if (userCredential.user != null) {
        // Save credentials if "Remember Me" is checked
        await _saveCredentials();

        // Navigate to home screen if still mounted
        if (mounted) {
          Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
        }
      }
    } on FirebaseAuthException catch (e) {
      developer.log("Firebase Auth Error: ${e.code} - ${e.message}", name: 'LoginScreen');
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
      developer.log("Unexpected Error: $e", name: 'LoginScreen');
      Get.snackbar(
        'Error',
        'An unexpected error occurred. Please try again',
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

  Future<void> _resetPassword() async {
    if (_emailController.text.isEmpty) {
      Get.snackbar(
        'Error',
        'Please enter your email address first',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
        duration: const Duration(seconds: 3),
        margin: const EdgeInsets.all(8),
        borderRadius: 8,
      );
      return;
    }

    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(
        email: _emailController.text.trim(),
      );
      Get.snackbar(
        'Success',
        'Password reset link has been sent to your email',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
        duration: const Duration(seconds: 3),
        margin: const EdgeInsets.all(8),
        borderRadius: 8,
      );
    } on FirebaseAuthException catch (e) {
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
    }
  }
  Future<void> _handleGoogleSignIn() async {
    try {
      setState(() => _isLoading = true);

      final UserCredential? userCredential =
          await _authService.signInWithGoogle();

      if (userCredential != null) {
        if (mounted) {
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
      }
    } catch (e) {
      developer.log("Google Sign In Error in LoginScreen: $e", name: 'LoginScreen');
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
          Image.asset(
            'assets/images/login-bg.png',
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
          // Black Overlay
          Container(color: Colors.black.withAlpha(128)), // 0.5 * 255 = 128
          // Main Content
          SafeArea(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.all(24.0),
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
                    // Welcome Text
                    const Text(
                      'Welcome Back',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Poppins',
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Sign in to continue',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 16,
                        fontFamily: 'Poppins',
                      ),
                    ),
                    const SizedBox(height: 40),
                    // Login Form
                    Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          // Email Field
                          TextFormField(
                            controller: _emailController,
                            style: const TextStyle(color: Colors.white),
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                              hintText: 'Email Address',
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
                              errorStyle: const TextStyle(
                                color: Color(0xFFCE9760),
                              ),
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
                          // Password Field
                          TextFormField(
                            controller: _passwordController,
                            obscureText: _obscurePassword,
                            style: const TextStyle(color: Colors.white),
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
                                onPressed:
                                    () => setState(
                                      () =>
                                          _obscurePassword = !_obscurePassword,
                                    ),
                              ),
                              contentPadding: const EdgeInsets.all(16),
                              errorStyle: const TextStyle(
                                color: Color(0xFFCE9760),
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your password';
                              }
                              return null;
                            },
                          ),
                        ],
                      ),
                    ),
                    // Remember Me and Forgot Password Row
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Remember Me Checkbox
                        Row(
                          children: [
                            Checkbox(
                              value: _rememberMe,
                              onChanged: (value) {
                                setState(() {
                                  _rememberMe = value ?? false;
                                });
                              },
                              activeColor: const Color(0xFFCE9760),
                              checkColor: Colors.black,
                              side: const BorderSide(color: Color(0xFFCE9760)),
                            ),
                            const Text(
                              'Remember Me',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                        // Forgot Password
                        TextButton(
                          onPressed: _resetPassword,
                          child: const Text(
                            'Forgot Password?',
                            style: TextStyle(
                              color: Color(0xFFCE9760),
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ],
                    ),
                    //@Abd-a966#
                    // Warning about storing credentials
                    if (_rememberMe)
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Text(
                          'Warning: Storing credentials is not secure for production use.',
                          style: TextStyle(
                            color: Colors.amber[700],
                            fontSize: 12,
                            fontStyle: FontStyle.italic,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    const SizedBox(height: 24),
                    // Sign in Button
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: _isLoading ? null : _signIn,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFCE9760),
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          disabledBackgroundColor: const Color(
                            0xFFCE9760,
                          ).withAlpha(153), // 0.6 * 255 = 153
                        ),
                        child:
                            _isLoading
                                ? const SizedBox(
                                  height: 20,
                                  width: 20,
                                  child: CircularProgressIndicator(
                                    color: Colors.black,
                                    strokeWidth: 2,
                                  ),
                                )
                                : const Text(
                                  'Sign in',
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
                          child: Divider(color: Color(0xFFCE9760)),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Text(
                            'Or Login with',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        const Expanded(
                          child: Divider(color: Color(0xFFCE9760)),
                        ),
                      ],
                    ),
                    const SizedBox(height: 30),
                    // Social Login Buttons
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _socialLoginButton(
                          'assets/images/facebook.png',
                          onTap: () {},
                        ),
                        _socialLoginButton(
                          'assets/images/google.png',
                          onTap: _handleGoogleSignIn,
                        ),
                        _socialLoginButton(
                          'assets/images/twitter.png',
                          onTap: () {},
                        ),
                      ],
                    ),
                    const SizedBox(height: 40),
                    // Register Link
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Don\'t have an account?',
                          style: TextStyle(color: Colors.white),
                        ),
                        TextButton(
                          onPressed:
                              () => Navigator.pushReplacementNamed(
                                context,
                                '/register',
                              ),
                          child: const Text(
                            'Register',
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
          color: Colors.black.withAlpha(179), // 0.7 * 255 = 179
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

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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

      if (userCredential.user != null && mounted) {
        Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
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

  // Future<void> _signIn() async {
  //   if (!_formKey.currentState!.validate()) return;

  //   try {
  //     setState(() => _isLoading = true);

  //     // Sign in user
  //     UserCredential userCredential = await FirebaseAuth.instance
  //         .signInWithEmailAndPassword(
  //           email: _emailController.text.trim(),
  //           password: _passwordController.text.trim(),
  //         );

  //     // Print user info for verification
  //     print("Logged in user: ${userCredential.user?.email}");

  //     // Navigate to home screen
  //     if (mounted) {
  //       Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
  //     }
  //   } on FirebaseAuthException catch (e) {
  //     print("Firebase Auth Error: ${e.code} - ${e.message}"); // For debugging
  //     Get.snackbar(
  //       'Error',
  //       _getErrorMessage(e.code),
  //       snackPosition: SnackPosition.BOTTOM,
  //       backgroundColor: Colors.red,
  //       colorText: Colors.white,
  //       duration: const Duration(seconds: 3),
  //       margin: const EdgeInsets.all(8),
  //       borderRadius: 8,
  //     );
  //   } catch (e) {
  //     print("Unexpected Error: $e"); // For debugging
  //     Get.snackbar(
  //       'Error',
  //       'An unexpected error occurred',
  //       snackPosition: SnackPosition.BOTTOM,
  //       backgroundColor: Colors.red,
  //       colorText: Colors.white,
  //     );
  //   } finally {
  //     if (mounted) setState(() => _isLoading = false);
  //   }
  // }

  // Future<void> _resetPassword() async {
  //   if (_emailController.text.isEmpty) {
  //     Get.snackbar(
  //       'Error',
  //       'Please enter your email address first',
  //       snackPosition: SnackPosition.BOTTOM,
  //       backgroundColor: Colors.red,
  //       colorText: Colors.white,
  //     );
  //     return;
  //   }

  //   try {
  //     await FirebaseAuth.instance.sendPasswordResetEmail(
  //       email: _emailController.text.trim(),
  //     );
  //     Get.snackbar(
  //       'Success',
  //       'Password reset email sent. Please check your inbox',
  //       snackPosition: SnackPosition.BOTTOM,
  //       backgroundColor: Colors.green,
  //       colorText: Colors.white,
  //     );
  //   } on FirebaseAuthException catch (e) {
  //     Get.snackbar(
  //       'Error',
  //       _getErrorMessage(e.code),
  //       snackPosition: SnackPosition.BOTTOM,
  //       backgroundColor: Colors.red,
  //       colorText: Colors.white,
  //     );
  //   }
  // }


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
          Image.asset(
            'assets/images/login-bg.png',
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
          // Black Overlay
          Container(color: Colors.black.withOpacity(0.5)),
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
                    // Forgot Password
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: _resetPassword,
                        child: const Text(
                          'Forgot Password?',
                          style: TextStyle(
                            color: Color(0xFFCE9760),
                            fontSize: 14,
                          ),
                        ),
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
                          ).withOpacity(0.6),
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

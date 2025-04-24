import 'package:flutter/material.dart';
import 'home_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/login-bg.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            color: Colors.black.withOpacity(0.5),
          ),
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    const SizedBox(height: 60),
                    Image.asset(
                      'assets/images/logo.png',
                      width: 60,
                      height: 60,
                      color: const Color(0xFFCE9760),
                    ),
                    const SizedBox(height: 20),
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
                        final emailRegex = RegExp(
                          r'^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+',
                        );
                        if (!emailRegex.hasMatch(value)) {
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
                          onPressed: () {
                            setState(() {
                              _obscurePassword = !_obscurePassword;
                            });
                          },
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
                        if (!value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
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
                          onPressed: () {
                            setState(() {
                              _obscureConfirmPassword = !_obscureConfirmPassword;
                            });
                          },
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
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            // TODO: Implement registration logic
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const HomeScreen(),
                              ),
                            );
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFCE9760),
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: const Text(
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
                    Row(
                      children: [
                        Expanded(
                          child: Divider(color: const Color(0xFFCE9760)),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Text(
                            'Or Register with',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        Expanded(
                          child: Divider(color: const Color(0xFFCE9760)),
                        ),
                      ],
                    ),
                    const SizedBox(height: 30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _socialLoginButton('assets/images/facebook.png'),
                        const SizedBox(width: 20),
                        _socialLoginButton('assets/images/google.png'),
                        const SizedBox(width: 20),
                        _socialLoginButton('assets/images/twitter.png'),
                      ],
                    ),
                    const SizedBox(height: 40),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Already have an account?',
                          style: TextStyle(color: Colors.white),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pushReplacementNamed(context, '/login');
                          },
                          child: Text(
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
        ],
      ),
    );
  }

  Widget _socialLoginButton(String iconPath) {
    return Container(
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
    );
  }
}
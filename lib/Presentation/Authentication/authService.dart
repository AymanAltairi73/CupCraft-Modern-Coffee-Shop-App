import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Future<UserCredential?> signInWithGoogle() async {
    try {
      // Trigger the authentication flow
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

      // If user cancels the sign-in flow
      if (googleUser == null) {
        print('Google Sign In: User cancelled the sign-in flow');
        return null;
      }

      try {
        // Obtain the auth details from the request
        final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

        // Create a new credential
        final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );

        // Sign in to Firebase with the Google credential
        final UserCredential userCredential = await _auth.signInWithCredential(credential);
        
        print('Google Sign In Successful: ${userCredential.user?.email}');
        return userCredential;
      } catch (authError) {
        print('Error during Google authentication: $authError');
        throw Exception('Failed to authenticate with Google credentials');
      }
    } catch (e) {
      print('Google Sign In Error: $e');
      throw Exception('Failed to sign in with Google');
    }
  }

  // Method to sign out
  Future<void> signOut() async {
    await _auth.signOut();
    await _googleSignIn.signOut();
  }
}
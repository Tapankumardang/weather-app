import 'package:flutter/material.dart';

import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:weather/searchScreen.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailTextEditingController =
      new TextEditingController();
  TextEditingController passwordTextEditingController =
      new TextEditingController();
  FirebaseAuth auth = FirebaseAuth.instance;

  //google sigin in method

  Future<void> signInWithGoogle() async {
    final userCredential;
    final googleSignIn = GoogleSignIn();
    final googleUser = await googleSignIn.signIn();
    if (googleUser != null) {
      final googleAuth = await googleUser.authentication;
      if (googleAuth.idToken != null) {
        final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );
        final UserCredential = await auth.signInWithCredential(
          credential,
        );
        userCredential = UserCredential;
        String username = userCredential.user!.displayName.toString();
        if (username != null) {
          //pushing to search screen
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => SearchScreen(username)));
        } else {
          print("unable to login");
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            "Login",
            style: GoogleFonts.ubuntu(),
          ),
        ),
      ),
      body: Container(
        width: width,
        color: Colors.black,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 30),
              child: Text("Welcome to your Weather App",
                  style: GoogleFonts.ubuntu(
                    color: Colors.white,
                    fontSize: 20,
                  )),
            ),
            Text("Please SignIn with Google to Continue",
                style: GoogleFonts.ubuntu(
                  color: Colors.white,
                  fontSize: 20,
                )),
            SizedBox(
              height: 50,
            ),
            GestureDetector(
              onTap: () async {
                signInWithGoogle();
              },
              child: Container(
                alignment: Alignment.center,
                width: width / 2,
                padding: EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                    gradient: const LinearGradient(
                        colors: [Color(0xff007EF4), Color(0xff2A75BC)]),
                    borderRadius: BorderRadius.circular(38)),
                child: Text(
                  "Sign In",
                  style: GoogleFonts.ubuntu(
                    color: Colors.white,
                    fontSize: 30,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

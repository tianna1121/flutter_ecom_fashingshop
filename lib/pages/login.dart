import 'package:flutter/material.dart';
import 'package:flutter_ecomm/main.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'home.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final GoogleSignIn googleSignIn = new GoogleSignIn();
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  SharedPreferences preferences;
  bool loading = false;
  bool isLogedin = false;

  @override
  void initState() {
    super.initState();
    isSignedIn();
  }

  Future handleSignIn() async {
    preferences = await SharedPreferences.getInstance();
    setState(() {
      loading = true;
    });
    final GoogleSignInAccount googleUser = await googleSignIn.signIn();
    if (googleUser == null) return;

    // final GoogleSignInAuthentication googleAuth =
    //     await googleUser.authentication;

    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: (await googleUser.authentication).accessToken,
      idToken: (await googleUser.authentication).idToken,
    );
    // final FirebaseUser firebaseUser =
    //     (await firebaseAuth.signInWithCredential(credential)) as FirebaseUser;
    AuthResult res = await firebaseAuth.signInWithCredential(credential);
    if (res.user == null) {
      print("+++++++++++++++++++++++++++Failed");
      Fluttertoast.showToast(msg: "Login failed :(");
    } else {
      final QuerySnapshot result = await Firestore.instance
          .collection("users")
          .where("id", isEqualTo: res.user.uid)
          .getDocuments();
      final List<DocumentSnapshot> documents = result.documents;
      if (documents.length == 0) {
        print("docs length equals to 0");
        // * insert the new user to our collection
        Firestore.instance.collection("users").document(res.user.uid).setData({
          "id": res.user.uid,
          "username": res.user.displayName,
          "profilePicture": res.user.photoUrl
        });
        await preferences.setString("id", res.user.uid);
        await preferences.setString("username", res.user.displayName);
        await preferences.setString("photoUrl", res.user.photoUrl);
      } else {
        print("docs length NOT equals to 0");
        await preferences.setString("id", documents[0]["id"]);
        await preferences.setString("username", documents[0]["username"]);
        await preferences.setString("photoUrl", documents[0]["photoUrl"]);
      }
      Fluttertoast.showToast(msg: "Login was successful");
      setState(() {
        loading = false;
      });
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => HomePage()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          centerTitle: true,
          title: Text(
            "Login",
            style: TextStyle(color: Colors.red.shade900),
          ),
          elevation: 0.5,
        ),
        body: Stack(
          children: <Widget>[
            Center(
              child: FlatButton(
                color: Colors.red.shade900,
                onPressed: () {
                  handleSignIn();
                },
                child: Text(
                  'Sign in / Sign up with Google',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            Visibility(
              visible: loading ?? true,
              child: Center(
                child: Container(
                  color: Colors.white.withOpacity(0.9),
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.red),
                  ),
                ),
              ),
            )
          ],
        ));
  }

  void isSignedIn() async {
    setState(() {
      loading = true;
    });

    preferences = await SharedPreferences.getInstance();
    isLogedin = await googleSignIn.isSignedIn();
    if (isLogedin) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => HomePage()));
    }
    setState(() {
      loading = false;
    });
  }
}

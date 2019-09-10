import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ecomm/pages/home.dart';
import '../db/users.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final _formKey = GlobalKey<FormState>();
  TextEditingController _emailTextController = TextEditingController();
  TextEditingController _passwordTextController = TextEditingController();
  TextEditingController _nameTextController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();

  bool loading = false;
  bool hidepass = true;
  String gender;
  String groupvalue = "male";
  UserServices _userServices = UserServices();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: Center(
              child: Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Container(
                        alignment: Alignment.topCenter,
                        child: Image.asset(
                          "assets/images/logo.png",
                          width: 180.0,
                          height: 180.0,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Material(
                        borderRadius: BorderRadius.circular(10.0),
                        color: Colors.black.withOpacity(0.1),
                        elevation: 0.0,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 12.0),
                          child: ListTile(
                            title: TextFormField(
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "Name",
                                icon: Icon(Icons.person_outline),
                              ),
                              controller: _nameTextController,
                              validator: (value) {
                                if (value.isEmpty) {
                                  return "The Name field cannot be empty";
                                }
                                return null;
                              },
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Material(
                        borderRadius: BorderRadius.circular(10.0),
                        color: Colors.black.withOpacity(0.1),
                        elevation: 0.0,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 12.0),
                          child: ListTile(
                            title: TextFormField(
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "Email",
                                icon: Icon(Icons.alternate_email),
                              ),
                              keyboardType: TextInputType.emailAddress,
                              controller: _emailTextController,
                              validator: (value) {
                                if (value.isEmpty) {
                                  Pattern pattern =
                                      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                                  RegExp regExp = new RegExp(pattern);
                                  if (!regExp.hasMatch(value))
                                    return 'Please make sure your email address is valid';
                                  else
                                    return null;
                                }
                              },
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Material(
                        borderRadius: BorderRadius.circular(10.0),
                        color: Colors.grey.withOpacity(0.2),
                        elevation: 0.0,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 12.0),
                          child: ListTile(
                            trailing: IconButton(
                              icon: Icon(
                                Icons.remove_red_eye,
                              ),
                              onPressed: () {
                                setState(() {
                                  hidepass = false;
                                });
                              },
                            ),
                            title: TextFormField(
                              obscureText: hidepass,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "Password",
                                icon: Icon(Icons.lock_outline),
                              ),
                              keyboardType: TextInputType.emailAddress,
                              controller: _passwordTextController,
                              validator: (value) {
                                if (value.isEmpty) {
                                  return "The Password field cannot be empty";
                                } else if (value.length < 6) {
                                  return "The password should be at least 6 characters long";
                                }
                                return null;
                              },
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Material(
                        borderRadius: BorderRadius.circular(20.0),
                        color: Colors.deepOrange,
                        elevation: 0.0,
                        child: MaterialButton(
                          onPressed: () async {
                            validateForm();
                          },
                          minWidth: MediaQuery.of(context).size.width,
                          child: Text(
                            "Sign up",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 20.0),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Text("I already have an account",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.deepOrange,
                              fontSize: 16.0,
                            )),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Divider(),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'Or Sign up with',
                              style:
                                  TextStyle(fontSize: 20, color: Colors.grey),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Divider(),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Padding(
                          padding:
                              const EdgeInsets.fromLTRB(14.0, 8.0, 14.0, 8.0),
                          child: Material(
                            child: MaterialButton(
                              onPressed: () {},
                              child: Image.asset(
                                'assets/images/fb.png',
                                width: 60,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.fromLTRB(14.0, 8.0, 14.0, 8.0),
                          child: Material(
                            child: MaterialButton(
                              onPressed: () {},
                              child: Image.asset(
                                'assets/images/ggg.png',
                                width: 40,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Expanded(
                      child: Container(),
                    ),
                    Divider(
                      color: Colors.white,
                    ),
                  ],
                ),
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
      ),
    );
  }

  valueChange(e) {
    setState(() {
      if (e == "male") {
        groupvalue = e;
        gender = e;
      } else if (e == "female") {
        groupvalue = e;
        gender = e;
      }
    });
  }

  Future validateForm() async {
    FormState formState = _formKey.currentState;

    if (formState.validate()) {
      formState.reset();
      FirebaseUser user = await firebaseAuth.currentUser();
      if (user == null) {
        firebaseAuth
            .createUserWithEmailAndPassword(
                email: _emailTextController.text,
                password: _passwordTextController.text)
            .then((user) => {
                  _userServices.createUser({
                    "username": _nameTextController.text,
                    "email": _emailTextController.text,
                    //      "userId": user.uid,
                    "gender": gender,
                  })
                })
            .catchError((err) => {print(err.toString())});
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => HomePage()));
      }
    }
  }
}

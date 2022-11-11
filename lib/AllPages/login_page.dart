import 'package:blue_gradient_wireframe/AllPages/home_page.dart';
import 'package:blue_gradient_wireframe/AllPages/password_reset_page.dart';
import 'package:blue_gradient_wireframe/AllPages/signup_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    TextEditingController passwordTextEditingController =
        TextEditingController();
    TextEditingController emailTextEditingController = TextEditingController();

    //login user.................
    logInUserNow() async {
      try {
        final credential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(
                email: emailTextEditingController.text,
                password: passwordTextEditingController.text);

        final User? firebaseUser = (await FirebaseAuth.instance
                .signInWithEmailAndPassword(
          email: emailTextEditingController.text,
          password: passwordTextEditingController.text,
        )
                .catchError((msg) {
          //Navigator.pop(context);
          Fluttertoast.showToast(
            msg: "Error" + msg.toString(),
          );
        }))
            .user;

        if (firebaseUser != null) {
          DatabaseReference driverRef =
              FirebaseDatabase.instance.ref().child("users");

          driverRef.child(firebaseUser.uid).once().then((driverKey) {
            final snap = driverKey.snapshot;
            if (snap.value != null) {
              Fluttertoast.showToast(msg: "Login successful");
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (c) => HomePage(),
                ),
              );
            } else {
              Fluttertoast.showToast(msg: "No record exist with this email.");
            }
          });
        } else {
          //Navigator.pop(context);
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (c) => HomePage(),
            ),
          );
          Fluttertoast.showToast(msg: "Error occured during login.");
        }
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          print('No user found for that email.');
          Fluttertoast.showToast(msg: "Error occured during login.");
        } else if (e.code == 'wrong-password') {
          print('Wrong password provided for that user.');
          Fluttertoast.showToast(msg: "Error occured during login.");
        }
      }
    }

    return Scaffold(
      body: Container(
        constraints: const BoxConstraints.expand(),
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage("lib/img/bg1.jpg"), fit: BoxFit.cover)),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 65.0,
              ),
              const Text("Aqua \nScanner",
                  style: TextStyle(
                      fontSize: 64.0,
                      color: CupertinoColors.white,
                      fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center),
              const SizedBox(
                height: 100.0,
              ),

              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 25, vertical: 5),
                child: TextField(
                  controller: emailTextEditingController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(25.0)),
                    ),
                    hintText: 'Phone Number, Username or Email',
                    filled: true,
                    fillColor: CupertinoColors.white,
                  ),
                ),
              ),

              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 25, vertical: 5),
                child: TextField(
                  obscureText: true,
                  controller: passwordTextEditingController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(25.0)),
                    ),
                    hintText: 'Password',
                    filled: true,
                    fillColor: CupertinoColors.white,
                  ),
                ),
              ),
              const SizedBox(
                height: 10.0,
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 25, vertical: 5),
                child: ElevatedButton(
                  style: ButtonStyle(
                    shape:
                        MaterialStateProperty.resolveWith<OutlinedBorder>((_) {
                      return RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25));
                    }),
                    backgroundColor:
                        MaterialStateProperty.all(Colors.indigoAccent),
                  ),
                  child: Container(
                    height: 50.0,
                    child: const Center(
                      child: Text(
                        "Login",
                        style: TextStyle(
                            fontSize: 18.0,
                            fontFamily: "Brand Bold",
                            color: Colors.white),
                      ),
                    ),
                  ),
                  onPressed: () {
                    if (passwordTextEditingController.text != '' &&
                        emailTextEditingController.text != '') {
                      print("ok");
                      logInUserNow();
                    }
                  },
                ),
              ),
              TextButton(
                style: ButtonStyle(
                  foregroundColor:
                      MaterialStateProperty.all<Color>(Colors.white),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const PasswordReset()),
                  );
                },
                child: const Text('Forgot Password?'),
              ),
              //const SizedBox(height: 160.0, ),

              TextButton(
                style: ButtonStyle(
                  foregroundColor:
                      MaterialStateProperty.all<Color>(Colors.white),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SignupPage()),
                  );
                },
                child: const Text('Don\'t have an account?'),
              )
            ],
          ),
        ),
      ),
    );
  }
}

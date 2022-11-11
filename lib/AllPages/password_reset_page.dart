import 'package:blue_gradient_wireframe/AllPages/signup_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PasswordReset extends StatefulWidget {
  const PasswordReset({Key? key}) : super(key: key);

  @override
  _PasswordResetState createState() => _PasswordResetState();
}

class _PasswordResetState extends State<PasswordReset> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        constraints: const BoxConstraints.expand(),
        decoration: const BoxDecoration(
            image: DecorationImage(image: AssetImage("lib/img/bg1.jpg"),fit: BoxFit.cover)
        ),
        child: SingleChildScrollView(
          child: Column(
            children:  [
              const SizedBox(height: 65.0,),
              const Text(
                  "Aqua \nScanner",
                  style: TextStyle(
                      fontSize: 64.0,
                      color: CupertinoColors.white,
                      fontWeight: FontWeight.bold
                  ),
                  textAlign: TextAlign.center
              ),
              const Image(image: AssetImage("lib/img/lock.png"),
                width: 120.0,
                height: 120.0,
                alignment: Alignment.center,),
              const Text(
                  "Enter your email,phone,or username.\n App will automatically"
                      "send a link to reset the password",
                  style: TextStyle(
                      fontSize: 16.0,
                      color: CupertinoColors.white,
                  ),
                  textAlign: TextAlign.center
              ),
              const SizedBox(height: 10.0,),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 25, vertical: 5),
                child: TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(25.0)),),
                    hintText: 'Phone Number, Username or Email',
                    filled: true,
                    fillColor: CupertinoColors.white,
                  ),
                ),
              ),
              const SizedBox(height: 10.0,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 5),
                child: ElevatedButton(
                  style: ButtonStyle(
                    shape: MaterialStateProperty.resolveWith<OutlinedBorder>((_) {
                      return RoundedRectangleBorder(borderRadius: BorderRadius.circular(20));
                    }),
                    backgroundColor: MaterialStateProperty.all(Colors.indigoAccent),
                  ),
                  child: Container(
                    height: 50.0,
                    child: const Center(
                      child: Text(
                        "Forgot Password",
                        style: TextStyle(fontSize: 18.0, fontFamily: "Brand Bold",color: Colors.white),
                      ),
                    ),
                  ),

                  onPressed: null,
                ),
              ),
              const SizedBox(height: 180.0,),
              TextButton(
                style: ButtonStyle(
                  foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) =>  SignupPage()),
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

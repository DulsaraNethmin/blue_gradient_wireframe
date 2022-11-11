import 'dart:convert';

import 'package:blue_gradient_wireframe/main.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'home_page.dart';

class WaterQuality extends StatefulWidget {
  const WaterQuality({Key? key}) : super(key: key);

  @override
  _WaterQualityState createState() => _WaterQualityState();
}

class _WaterQualityState extends State<WaterQuality> {
  var current_user = FirebaseAuth.instance.currentUser;
  //DatabaseReference userRef = FirebaseDatabase.instance.ref().child("users");
  CollectionReference usersRef =
      FirebaseFirestore.instance.collection('waterquality');

  Future<dynamic> getUser() async {
    return await usersRef.doc(current_user!.uid).get();
  }

  //userRef.child(firebaseUser.uid).set(userMap);
  @override
  Widget build(BuildContext context) {
    print(current_user!.uid);
    //var user = ;
    //print(user);
    return Scaffold(
      body: Container(
        constraints: const BoxConstraints.expand(),
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage("lib/img/5565016.jpg"), fit: BoxFit.cover)),
        child: SingleChildScrollView(
          child: FutureBuilder(
            future: getUser(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasError) {
                return CircularProgressIndicator.adaptive();
              }
              if (snapshot.hasData) {
                //print(snapshot.data['username']);

                return Column(
                  children: [
                    const SizedBox(
                      height: 75.0,
                    ),
                    Container(
                      width: 290.0,
                      height: 130.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(14.0),
                        color: const Color(0xFF002352),
                      ),
                      child: const Center(
                        child: Text(
                          'Water \n\nQuality',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Arial',
                            fontSize: 28,
                            color: Colors.white,
                            height: 1,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 40.0,
                    ),
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                      const SizedBox(
                        width: 15.0,
                      ),
                      Container(
                        width: 150.0,
                        height: 60.0,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(14.0),
                          color: const Color(0xFF002352),
                        ),
                        child: const Center(
                          child: Text(
                            'PH VALUE',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Arial',
                              fontSize: 18,
                              color: Color(0xFF89BCC4),
                              height: 1,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      const Expanded(
                        child: SizedBox.shrink(),
                      ),
                      Container(
                        width: 80.0,
                        height: 60.0,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(14.0),
                          color: const Color(0xFF002352),
                        ),
                        child: Center(
                          child: Text(
                            snapshot.data['PH value'],
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Arial',
                              fontSize: 18,
                              color: Color(0xFF89BCC4),
                              height: 1,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 15.0,
                      ),
                    ]),
                    const SizedBox(
                      height: 20.0,
                    ),
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                      const SizedBox(
                        width: 15.0,
                      ),
                      Container(
                        width: 150.0,
                        height: 60.0,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(14.0),
                          color: const Color(0xFF002352),
                        ),
                        child: const Center(
                          child: Text(
                            'WATER VISIBILITY',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Arial',
                              fontSize: 15,
                              color: Color(0xFF89BCC4),
                              height: 1,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      const Expanded(
                        child: SizedBox.shrink(),
                      ),
                      Container(
                        width: 80.0,
                        height: 60.0,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(14.0),
                          color: const Color(0xFF002352),
                        ),
                        child: Center(
                          child: Text(
                            snapshot.data['water visibility'],
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Arial',
                              fontSize: 18,
                              color: Color(0xFF89BCC4),
                              height: 1,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 15.0,
                      ),
                    ]),
                    const SizedBox(height: 20.0),
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                      const SizedBox(
                        width: 15.0,
                      ),
                      Container(
                        width: 150.0,
                        height: 60.0,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(14.0),
                          color: const Color(0xFF002352),
                        ),
                        child: const Center(
                          child: Text(
                            'TDS VALUE',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Arial',
                              fontSize: 18,
                              color: Color(0xFF89BCC4),
                              height: 1,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),

                      //const SizedBox(width: 120.0,),
                      const Expanded(
                        child: SizedBox.shrink(),
                      ),
                      Container(
                        width: 80.0,
                        height: 60.0,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(14.0),
                          color: const Color(0xFF002352),
                        ),
                        child: Center(
                          child: Text(
                            snapshot.data['TDS value'],
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Arial',
                              fontSize: 18,
                              color: Color(0xFF89BCC4),
                              height: 1,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 15.0,
                      ),
                    ]),
                    const SizedBox(
                      height: 260.0,
                    ),
                    Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                      IconButton(
                        visualDensity: VisualDensity.standard,
                        iconSize: 25.0,
                        icon: const Icon(
                          Icons.other_houses_rounded,
                          color: CupertinoColors.black,
                          size: 40.0,
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const HomePage()),
                          );
                        },
                      ),
                    ])
                  ],
                );
              } else {
                return CircularProgressIndicator();
              }
            },
          ),
        ),
      ),
    );
  }
}

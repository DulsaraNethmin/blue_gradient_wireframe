import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'home_page.dart';

class FishFeeding extends StatefulWidget {
  const FishFeeding({Key? key}) : super(key: key);
  @override
  _FishFeedingState createState() => _FishFeedingState();
}

bool positive = false;
int val = 0;
var current_user = FirebaseAuth.instance.currentUser;

class _FishFeedingState extends State<FishFeeding> {
  //var current_user = FirebaseAuth.instance.currentUser;

  Future updateFishFeed() async {
    Map<String, dynamic> data = {
      "user": current_user!.uid,
      "count": val,
      "check_feeder_state": positive
    };
    print(positive);
    print(val);
    await FirebaseFirestore.instance
        .collection('fishfeed')
        .doc("testuser")
        .set(data);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        constraints: const BoxConstraints.expand(),
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage("lib/img/3443970.jpg"), fit: BoxFit.cover)),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 95.0,
              ),
              const Text(
                  "Click the button \nto turn on the \nautomatic fish feeder.",
                  style: TextStyle(
                      fontSize: 28.0,
                      color: CupertinoColors.white,
                      fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center),
              const SizedBox(
                height: 75.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: () {
                      setState(() {
                        val--;
                        if (val < 0) {
                          val = 0;
                        }
                      });
                      //updateFishFeed();
                    },
                    icon: Icon(Icons.horizontal_rule),
                    color: Color.fromARGB(255, 5, 5, 5),
                    iconSize: 50,
                  ),
                  Container(
                    child: Center(
                        child: Text(
                      '$val',
                      style: TextStyle(fontSize: 30),
                    )),
                    color: Color.fromARGB(255, 228, 226, 226),
                    width: 60,
                    height: 60,
                  ),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        val++;
                        if (val > 99) {
                          val = 99;
                        }
                      });
                      //updateFishFeed();
                    },
                    icon: Icon(Icons.add),
                    color: Color.fromARGB(255, 5, 5, 5),
                    iconSize: 50,
                  )
                ],
              ),
              SizedBox(
                height: 20,
              ),
              ElevatedButton(
                child: Text("Apply"),
                onPressed: () {
                  //setState(() => positive = b);
                  updateFishFeed();
                },
              ),
              SizedBox(
                height: 60,
              ),
              ElevatedButton(
                child: Text("Check Feeder"),
                onPressed: () async {
                  setState(() => positive = true);
                  await updateFishFeed();
                  await Timer(Duration(seconds: 3), () {
                    setState(() => positive = false);
                    print('hi');
                    updateFishFeed();
                  });
                },
              ),
              const SizedBox(
                height: 340.0,
              ),
              Row(mainAxisAlignment: MainAxisAlignment.end,
                  //mainAxisAlignment = MainAxisAlignment.start,
                  children: [
                    IconButton(
                      visualDensity: VisualDensity.standard,
                      iconSize: 25.0,
                      icon: const Icon(
                        Icons.home,
                        color: CupertinoColors.black,
                        size: 40.0,
                      ),
                      tooltip: 'Increase volume by 10',
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const HomePage()),
                        );
                      },
                    ),
                  ]),
            ],
          ),
        ),
      ),
    );
  }
}

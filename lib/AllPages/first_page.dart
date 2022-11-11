import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FirstPage extends StatefulWidget {
  const FirstPage({Key? key}) : super(key: key);

  @override
  _FirstPageState createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        constraints: const BoxConstraints.expand(),
        decoration: const BoxDecoration(
          image: DecorationImage(image: AssetImage("lib/img/bg1.jpg"),fit: BoxFit.cover)
        ),
        child: Column(
          children: const [
            SizedBox(height: 165.0,),
            Image(image: AssetImage("lib/img/Fish_logo_in_outline_style_TEMPLATE.png"),
              width: 220.0,
              height: 220.0,
              alignment: Alignment.center,),
            SizedBox(height: 330.0,),
            Text(
                "Always by your pet's side",
              style: TextStyle(fontSize: 24.0,color: CupertinoColors.white),
              textAlign: TextAlign.center
            ),
          ],
        ),
      ),
    );
  }
}

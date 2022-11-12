import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'home_page.dart';

class FishtankMonitoring extends StatefulWidget {
  const FishtankMonitoring({Key? key}) : super(key: key);

  @override
  _FishtankMonitoringState createState() => _FishtankMonitoringState();
}

class _FishtankMonitoringState extends State<FishtankMonitoring> {
  Future<void> _launchInBrowser(String url1) async {
    final Uri _url = Uri(scheme: "http", host: url1);
    if (!await launchUrl(
      _url,
      mode: LaunchMode.externalApplication,
    )) {
      throw 'Could not launch $_url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        constraints: const BoxConstraints.expand(),
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage("lib/img/6520176.jpg"), fit: BoxFit.cover)),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 75.0,
              ),
              Container(
                width: 290.0,
                height: 130.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(14.0),
                  color: Color(0xFF002352),
                ),
                child: const Center(
                  child: Text(
                    'Fish Tank \n\nMonitoring',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Arial',
                      fontSize: 28,
                      color: Color(0xFF89BCC4),
                      height: 1,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              ElevatedButton(
                  onPressed: () async {
                    await _launchInBrowser("www.google.com");
                  },
                  child: Text("Go")),
              const SizedBox(
                height: 510.0,
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
                  ])
            ],
          ),
        ),
      ),
    );
  }
}

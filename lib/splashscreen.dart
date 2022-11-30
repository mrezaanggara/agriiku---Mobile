import 'dart:async';
import 'package:flutter/material.dart';
import 'view/landingpage.dart';

class Splashscreen extends StatefulWidget {
  const Splashscreen({super.key});

  @override
  State<Splashscreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {
  @override
  void initState() {
    super.initState();
    startSplashscreen();
  }

  startSplashscreen() {
    var duration = const Duration(seconds: 4);
    return Timer(duration, () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const Landingpage()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView(
      shrinkWrap: true,
      children: <Widget>[
        const SizedBox(
          height: 250,
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              'assets/images/agriiku.png',
              scale: 2,
            ),
          ],
        ),
        const SizedBox(height: 150),
        const Text(
          'Copyright © Agribisnis Unila 2022',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 10),
        )
      ],
    ));
  }
}

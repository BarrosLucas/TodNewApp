import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';
import 'package:tod/ide/ide.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0B0B0D),
      body: Stack(
        children: [
          SplashScreen(
            seconds: 7,
            navigateAfterSeconds:IDE(),
            useLoader: false,
            backgroundColor: const Color(0xFF0B0B0D),
          ),
          Positioned(child: Center(
            child: Image.asset('assets/images/logo.png',scale: 1.6),
          ),),
          const Positioned(
            bottom: 15,
            left: 0,
            right: 0,
            child: Text(
              "Powered by Lucas Barros",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
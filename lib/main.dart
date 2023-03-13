import 'package:flutter/material.dart';
import 'package:tod/view/splash/splash.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Splash(),
    )
  );
}
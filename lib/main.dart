import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:tod/splash/splash.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Splash(),
    )
  );
}
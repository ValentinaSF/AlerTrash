import 'package:flutter/material.dart';
import 'pantallas/login.dart';

void main() {
  runApp(const AlerTrashApp());
}

class AlerTrashApp extends StatelessWidget {
  const AlerTrashApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginScreen(),
    );
  }
}

import 'package:flutter/material.dart';

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Main Screen'),
      ),
      body: Center(
        child: Text(
          'Main Content',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}

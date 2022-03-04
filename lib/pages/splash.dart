import 'package:flutter/material.dart';

class Splash extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          color: Theme.of(context).scaffoldBackgroundColor,
          child: Center(
            child: Text(
              'Insectos',
              style: TextStyle(fontSize: 56.0, fontWeight: FontWeight.w600),
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class SomethingWentWrongPage extends StatelessWidget {
  const SomethingWentWrongPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Algo salió mal'),
      ),
    );
  }
}

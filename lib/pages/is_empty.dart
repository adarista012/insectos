import 'package:flutter/material.dart';

class IsEmptyPage extends StatelessWidget {
  const IsEmptyPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Su base de datos está vacia, empiece a crear datos.'),
      ),
    );
  }
}

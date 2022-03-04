import 'package:flutter/material.dart';
import 'package:insectos/pages/about.dart';
import 'package:insectos/pages/theme_mode.dart';
import 'package:insectos/services/authentication.dart';
import 'package:provider/provider.dart';

class DrawerI extends StatelessWidget {
  const DrawerI({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;

    final authProvider = Provider.of<AuthenticationService>(context);

    return Drawer(
      child: Container(
        color: Theme.of(context).scaffoldBackgroundColor,
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              color: Theme.of(context).primaryColor,
              height: h / 4.0,
              width: w,
              alignment: Alignment.bottomLeft,
              padding: EdgeInsets.all(8.0),
              child: Text(authProvider.currentU().toString()),
            ),
            TextButton(
                onPressed: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => ThemeModeI()));
                },
                child: Text('Modo oscuro')),
            Expanded(
              child: Container(),
            ),
            TextButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => AboutPage()));
                },
                child: Text('Acerca de la aplicación')),
            TextButton(
                onPressed: () async {
                  await authProvider.signOut();
                },
                child: Text('Cerrar sesión')),
            SizedBox(
              height: 8.0,
            )
          ],
        ),
      ),
    );
  }
}

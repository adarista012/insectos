import 'package:flutter/material.dart';
import 'package:insectos/models/logo.dart';
import 'package:insectos/services/components.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          backgroundColor: Color.fromARGB(255, 160, 198, 168),
          title: Text(
            'Acerca de la aplicación',
            style: TextStyle(color: Theme.of(context).primaryColorLight),
          )),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        //mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height / 8,
          ),
          StreamBuilder<LogoI>(
            stream: ServicesComponents().listLogo(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                print(snapshot.error);
                return Container();
              }

              if (!snapshot.hasData) {
                return Container();
              }
              LogoI? logo = snapshot.data;
              return Center(
                child: Container(
                  margin: EdgeInsets.all(24.0),
                  height: 240.0,
                  width: 240.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16.0),
                    image: DecorationImage(
                        //fit: BoxFit.cover,
                        image: NetworkImage(logo!.logo)),
                  ),
                ),
              );
            },
          ),
          Container(
            padding: EdgeInsets.all(8.0),
            alignment: Alignment.centerRight,
            child: Text(
              'Esta aplicación tiene un carácter de investigación e' +
                  ' información, si usted quiere realizar algún aporte puede comunicarse a: ',
              style: TextStyle(fontSize: 16.0),
            ),
          ),
          Container(
              margin: EdgeInsets.only(top: 16.0),
              child: TextButton(
                onPressed: () async =>
                    {await launch("https://wa.me/+59173711119")},
                child: Text(
                  '+591 73711119',
                  style: TextStyle(fontSize: 16.0),
                ),
              )),
        ],
      ),
    );
  }
}

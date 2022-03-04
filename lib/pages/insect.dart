import 'package:flutter/material.dart';
import 'package:insectos/models/insects.dart';
import 'package:insectos/pages/i.dart';

class InsectsPage extends StatelessWidget {
  final InsectsI insect;
  const InsectsPage({Key? key, required this.insect}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Color.fromARGB(255, 160, 198, 168),
        title: Text(
          insect.name,
          style: TextStyle(color: Theme.of(context).primaryColorLight),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              MaterialButton(
                padding: EdgeInsets.zero,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ImageFullScreenWrapperWidget(
                        child: insect.url,
                        name: insect.name,
                      ),
                      //ImagePage(imageUrl: insect.url),
                    ),
                  );
                },
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 400.0,
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(8.0),
                    image: DecorationImage(
                        fit: BoxFit.cover, image: NetworkImage(insect.url)),
                  ),
                ),
              ),
              SizedBox(height: 8.0),
              ContainerColor(text: 'TAXONOMÍA', color: Colors.blue.shade400),
              Table(
                border: TableBorder.all(color: Colors.white),
                children: [
                  TableRow(children: [
                    ContainerM(text: 'Reino:', color: Colors.blue.shade200),
                    ContainerM(
                        text: '${insect.reino}', color: Colors.blue.shade200),
                  ]),
                  TableRow(children: [
                    ContainerM(text: 'Filo:', color: Colors.blue.shade300),
                    ContainerM(
                        text: '${insect.clase}', color: Colors.blue.shade300),
                  ]),
                  TableRow(children: [
                    ContainerM(text: 'Clase:', color: Colors.blue.shade200),
                    ContainerM(
                        text: '${insect.filo}', color: Colors.blue.shade200),
                  ]),
                  TableRow(children: [
                    ContainerM(text: 'Sub clase:', color: Colors.blue.shade300),
                    ContainerM(
                        text: '${insect.subClase}',
                        color: Colors.blue.shade300),
                  ]),
                  TableRow(children: [
                    ContainerM(text: 'Orden:', color: Colors.blue.shade200),
                    ContainerM(
                        text: '${insect.orden}', color: Colors.blue.shade200),
                  ]),
                  TableRow(children: [
                    ContainerM(text: 'Familia:', color: Colors.blue.shade300),
                    ContainerM(
                        text: '${insect.familia}', color: Colors.blue.shade300),
                  ]),
                ],
              ),
              ContainerColor(
                text: 'CARACTERÍSTICAS PRINCIPALES',
                color: Colors.green.shade400,
              ),
              Table(
                border: TableBorder.all(color: Colors.white),
                children: [
                  TableRow(children: [
                    ContainerM(
                        text: 'Metamorfosis:', color: Colors.green.shade200),
                    ContainerM(
                        text: '${insect.metamorfosis}',
                        color: Colors.green.shade200),
                  ]),
                  TableRow(children: [
                    ContainerM(
                        text: 'Tipo de aparato bucal:',
                        color: Colors.green.shade300),
                    ContainerM(
                        text: '${insect.aparatoBucal}',
                        color: Colors.green.shade300),
                  ]),
                  TableRow(children: [
                    ContainerM(
                        text: 'Tipo de antenas:', color: Colors.green.shade200),
                    ContainerM(
                        text: '${insect.antenas}',
                        color: Colors.green.shade200),
                  ]),
                  TableRow(children: [
                    ContainerM(
                        text: 'Tipo de patas:', color: Colors.green.shade300),
                    ContainerM(
                        text: '${insect.patas}', color: Colors.green.shade300),
                  ]),
                  TableRow(children: [
                    ContainerM(
                        text: 'Tipo de alas:', color: Colors.green.shade200),
                    ContainerM(
                        text: '${insect.alas}', color: Colors.green.shade200),
                  ]),
                  TableRow(children: [
                    ContainerM(
                        text: 'Tipo de alimentación:',
                        color: Colors.green.shade300),
                    ContainerM(
                        text: '${insect.alimentacion}',
                        color: Colors.green.shade300),
                  ]),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ContainerColor extends StatelessWidget {
  final String text;
  final Color color;
  const ContainerColor({
    Key? key,
    required this.text,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.center,
        width: MediaQuery.of(context).size.width,
        height: 32.0,
        decoration: BoxDecoration(
            color: color, border: Border.all(color: Colors.white)),
        child: Text(
          text,
          style: TextStyle(
              //color: Colors.white,
              fontWeight: FontWeight.w600,
              fontSize: 20.0),
        ));
  }
}

class ContainerM extends StatelessWidget {
  final String text;
  final Color color;
  const ContainerM({
    Key? key,
    required this.text,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(4.8),
        alignment: Alignment.centerLeft,
        width: MediaQuery.of(context).size.width,
        height: 32.0,
        color: color,
        child: Text(
          text,
          style: TextStyle(
            //color: Colors.white,
            fontWeight: FontWeight.w500,
          ),
        ));
  }
}

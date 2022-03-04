import 'package:flutter/material.dart';
import 'package:insectos/global/styles.dart';
import 'package:insectos/models/insects.dart';
import 'package:insectos/pages/insect.dart';
import 'package:insectos/pages/something_went_wrong.dart';
import 'package:insectos/services/insects.dart';

import 'loading.dart';

class SubCategorySearch extends StatelessWidget {
  const SubCategorySearch({Key? key, required this.name}) : super(key: key);
  final String name;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Color.fromARGB(255, 160, 198, 168),
        title: Text(
          this.name,
          style: TextStyle(color: Theme.of(context).primaryColorLight),
        ),
      ),
      body: FutureBuilder<List<InsectsI>>(
        future: InsectsServices().iFromFire(name),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            print(snapshot.error);
            return SomethingWentWrongPage();
          }

          if (!snapshot.hasData) {
            return LoadingPage();
          }

          List<InsectsI>? listInsects = snapshot.data;
          return ListView.builder(
            itemCount: listInsects!.length,
            itemBuilder: (context, index) {
              return Card(
                color: Color.fromARGB(200, 255, 255, 255),
                child: MaterialButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            InsectsPage(insect: listInsects[index]),
                      ),
                    );
                  },
                  child: Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.all(8.0),
                          height: 120.0,
                          width: 120.0,
                          decoration: BoxDecoration(
                            color: Colors.grey,
                            border: Border.all(color: Colors.grey.shade300),
                            borderRadius: BorderRadius.circular(16.0),
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(listInsects[index].url)),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  listInsects[index].name,
                                  style: boldBrown.copyWith(fontSize: 18.0),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

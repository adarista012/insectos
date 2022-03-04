import 'package:flutter/material.dart';
import 'package:insectos/global/styles.dart';
import 'package:insectos/models/insects.dart';
import 'package:insectos/models/sub_categorie.dart';
import 'package:insectos/pages/insect_c.dart';
import 'package:insectos/pages/something_went_wrong.dart';
import 'package:insectos/services/sub_categories.dart';

import 'loading.dart';

class CategorySearchC extends StatefulWidget {
  final String name;
  const CategorySearchC({Key? key, required this.name}) : super(key: key);

  @override
  _CategorySearchCState createState() => _CategorySearchCState();
}

class _CategorySearchCState extends State<CategorySearchC> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        //backgroundColor: Colors.amber,
        backgroundColor: Color.fromARGB(255, 160, 198, 168),
        title: Text(
          widget.name,
          style: TextStyle(color: Theme.of(context).primaryColorLight),
        ),
      ),
      body: FutureBuilder<List<SubCategorieI>>(
          future: SubCategoriesServices().sCFromFire(widget.name),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              print(snapshot.error);
              return SomethingWentWrongPage();
            }

            if (!snapshot.hasData) {
              return LoadingPage();
            }
            List<SubCategorieI>? listSubCategories = snapshot.data;
            return ListView.builder(
                itemCount: listSubCategories!.length,
                itemBuilder: (context, index) {
                  return Card(
                    color: Color.fromARGB(200, 255, 255, 255),
                    child: MaterialButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => InsectsPageC(
                              insect: new InsectsI(
                                reino: 'reino',
                                filo: 'filo,',
                                clase: 'clase,',
                                subClase: 'subClase,',
                                orden: 'orden,',
                                familia: 'familia,',
                                metamorfosis: 'metamorfosis,',
                                aparatoBucal: 'aparatoBucal,',
                                antenas: 'antenas,',
                                patas: 'patas,',
                                alas: 'alas,',
                                alimentacion: 'alimentacion,',
                                name: listSubCategories[index].name,
                                category: listSubCategories[index].categorie,
                                subCategory: 'subCategory',
                                url: listSubCategories[index].url,
                              ),
                            ),
                          ),
                          // ImageFullScreenWrapperWidget(
                          //     child: listSubCategories[index].url,

                          //     name: listSubCategories[index].name))
                          //SubCategorySearch(
                          // name: listSubCategories[index].name),
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
                                    image: NetworkImage(
                                        listSubCategories[index].url)),
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      listSubCategories[index].categorie,
                                      style: boldBrown.copyWith(
                                          fontSize: 14.0,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    SizedBox(height: 4.0),
                                    Text(
                                      listSubCategories[index].name,
                                      style: boldBrown.copyWith(fontSize: 18.0),
                                    ),
                                    SizedBox(
                                      height: 4.0,
                                    ),
                                    // Text(
                                    //   listSubCategories[index].categorie,
                                    //   style: boldBrown.copyWith(
                                    //       fontSize: 16.0,
                                    //       fontWeight: FontWeight.w500),
                                    // ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                });
          }),
    );
  }
}

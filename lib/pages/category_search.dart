import 'package:flutter/material.dart';
import 'package:insectos/global/styles.dart';
import 'package:insectos/models/sub_categorie.dart';
import 'package:insectos/pages/something_went_wrong.dart';
import 'package:insectos/pages/sub_category_search.dart';
import 'package:insectos/services/sub_categories.dart';

import 'loading.dart';

class CategorySearch extends StatefulWidget {
  final String name;
  const CategorySearch({Key? key, required this.name}) : super(key: key);

  @override
  _CategorySearchState createState() => _CategorySearchState();
}

class _CategorySearchState extends State<CategorySearch> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
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
                                builder: (context) => SubCategorySearch(
                                    name: listSubCategories[index].name)));
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
                                    // Text(
                                    //   listSubCategories[index].categorie,
                                    //   style: boldBrown.copyWith(
                                    //       fontSize: 14.0,
                                    //       fontWeight: FontWeight.w500),
                                    // ),
                                    // SizedBox(
                                    //   height: 4.0,
                                    // ),
                                    Text(
                                      listSubCategories[index].name,
                                      style: boldBrown.copyWith(fontSize: 17.0),
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
                });
          }),
    );
  }
}

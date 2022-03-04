import 'package:flutter/material.dart';
import 'package:insectos/components/drawer.dart';
import 'package:insectos/models/categories.dart';
import 'package:insectos/models/intro.dart';
import 'package:insectos/models/logo.dart';
import 'package:insectos/pages/category_search.dart';
import 'package:insectos/pages/category_search_c.dart';
import 'package:insectos/pages/loading.dart';
import 'package:insectos/pages/something_went_wrong.dart';
import 'package:insectos/services/categories.dart';
import 'package:insectos/services/components.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    final categoryProvider = Provider.of<CategoriesServices>(context);
    //final subCategoryProvider = Provider.of<SubCategoriesServices>(context);
    var scaffoldKey = GlobalKey<ScaffoldState>();

    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        leading: StreamBuilder<LogoI>(
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
                height: 56.0,
                width: 56.0,
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  //borderRadius: BorderRadius.circular(16.0),
                  image: DecorationImage(
                      //fit: BoxFit.cover,
                      image: NetworkImage(logo!.logo)),
                ),
              ),
            );
          },
        ),
        actions: [
          IconButton(
            onPressed: () {
              scaffoldKey.currentState?.openEndDrawer();
            },
            icon: Icon(Icons.menu),
            tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
          )
        ],
      ),
      endDrawer: DrawerI(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          //mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 8.0),
              child: Text(
                'Insectos',
                style: TextStyle(fontSize: 32.0, fontWeight: FontWeight.w600),
              ),
            ),
            Container(
              margin: EdgeInsets.all(16.0),
              height: 40.0,
              width: w,
              decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.circular(16.0)),
              child: MaterialButton(
                onPressed: () {
                  showModalBottomSheet(
                      backgroundColor: Colors.transparent,
                      context: context,
                      builder: (BuildContext context) {
                        return Container(
                          width: w,
                          height: h / 2,
                          padding: EdgeInsets.all(16.0),
                          decoration: BoxDecoration(
                              color: Theme.of(context).primaryColor,
                              borderRadius: BorderRadius.circular(16.0)),
                          child: StreamBuilder<IntroI>(
                            stream: ServicesComponents().listIntro(),
                            builder: (context, snapshot) {
                              if (snapshot.hasError) {
                                print(snapshot.error);
                                return Container();
                              }

                              if (!snapshot.hasData) {
                                return Container();
                              }

                              IntroI? intro = snapshot.data;
                              return Text(
                                '${intro!.intro}',
                                style: TextStyle(
                                    color: Theme.of(context)
                                        .scaffoldBackgroundColor,
                                    fontWeight: FontWeight.w700),
                              );
                            },
                          ),
                        );
                      });
                },
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.0)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Introducción",
                        style: TextStyle(
                            color: Theme.of(context).scaffoldBackgroundColor,
                            fontWeight: FontWeight.w700))
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 16.0,
                right: 16.0,
              ),
              child: Text(
                'Órdenes',
                style: TextStyle(fontSize: 32.0, fontWeight: FontWeight.w600),
              ),
            ),
            // Container(
            //     margin: EdgeInsets.only(top: 24.0, bottom: 16.0),
            //     height: 32.0,
            //     child: StreamBuilder<List<CategorieI>>(
            //       stream: categoryProvider.listCategories(),
            //       builder: (context, snapshot) {
            //         if (snapshot.hasError) {
            //           print(snapshot.error);

            //           return SomethingWentWrongPage();
            //         }
            //         if (!snapshot.hasData) {
            //           return LoadingPage();
            //         }

            //         List<CategorieI>? listCategories = snapshot.data;
            //         return ListView.builder(
            //             scrollDirection: Axis.horizontal,
            //             itemCount: listCategories!.length,
            //             itemBuilder: (context, index) {
            //               return LabelCategory(
            //                   category: listCategories[index].name);
            //             });
            //       },
            //     )),
            // Padding(
            //   padding: const EdgeInsets.only(
            //     left: 16.0,
            //     right: 16.0,
            //   ),
            //   child: Text(
            //     'Caracteristicas',
            //     style: TextStyle(fontSize: 32.0, fontWeight: FontWeight.w600),
            //   ),
            // ),
            Container(
              height: (w / 2) + 60,
              child: StreamBuilder<List<CategorieI>>(
                stream: categoryProvider.listCategories(),
                //subCategoryProvider.listOrders(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    print(snapshot.error);

                    return SomethingWentWrongPage();
                  }
                  if (!snapshot.hasData) {
                    return LoadingPage();
                  }
                  List<CategorieI>? listCategories = snapshot.data;
                  return ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: listCategories!.length,
                      itemBuilder: (context, index) {
                        return ContainerO(
                          h: h - 120,
                          w: w,
                          url: listCategories[index].url,
                          name: listCategories[index].name,
                          cat: 'listCategories[index].categorie',
                        );
                      });
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 16.0,
                right: 16.0,
              ),
              child: Text(
                'Caracteristicas',
                style: TextStyle(fontSize: 32.0, fontWeight: FontWeight.w600),
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 16.0),
              height: (w / 2) + 68,
              child: StreamBuilder<List<CategorieI>>(
                stream: categoryProvider.listFeatures(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    print(snapshot.error);

                    return SomethingWentWrongPage();
                  }
                  if (!snapshot.hasData) {
                    return LoadingPage();
                  }
                  List<CategorieI>? listCategories = snapshot.data;
                  return ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: listCategories!.length,
                      itemBuilder: (context, index) {
                        return ContainerC(
                          h: h - 120,
                          w: w,
                          url: listCategories[index].url,
                          name: listCategories[index].name,
                          cat: listCategories[index].name,
                        );
                      });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class LabelCategory extends StatelessWidget {
  const LabelCategory({
    Key? key,
    required this.category,
  }) : super(key: key);

  final String category;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.only(left: 4.0),
      //padding: EdgeInsets.all(4.0),
      height: 20.0,
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColorDark,
        //border: Border.all(color: Theme.of(context).primaryColorLight),
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: MaterialButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => CategorySearch(name: category)));
        },
        child: Text(
          category,
          style: TextStyle(
              fontWeight: FontWeight.w500,
              color: Theme.of(context).scaffoldBackgroundColor),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
      ),
    );
  }
}

class ContainerO extends StatelessWidget {
  const ContainerO({
    Key? key,
    required this.h,
    required this.w,
    required this.url,
    required this.cat,
    required this.name,
  }) : super(key: key);

  final double h;
  final double w;
  final String url;
  final String cat;
  final String name;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.all(8.0),
          height: w / 2,
          //h / 2,
          width: w / 2,
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            borderRadius: BorderRadius.circular(32.0),
            image: DecorationImage(fit: BoxFit.cover, image: NetworkImage(url)),
          ),
          child: MaterialButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => CategorySearch(name: name)));
            },
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(32.0)),
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 20.0,
              margin: EdgeInsets.only(left: 8.0, right: 8.0),
              padding: EdgeInsets.only(left: 4.0),
              width: (w / 2) + 12.0,
              child: Text(
                '$name',
                style: TextStyle(),
                overflow: TextOverflow.clip,
              ),
            ),
            // Container(
            //   margin: EdgeInsets.only(left: 8.0, right: 8.0),
            //   padding: EdgeInsets.only(left: 4.0),
            //   height: 20.0,
            //   width: (w / 2) + 12.0,
            //   // child: Text('Familia: $name',
            //   //     style: TextStyle(), overflow: TextOverflow.fade),
            // ),
          ],
        ),
      ],
    );
  }
}

class ContainerC extends StatelessWidget {
  const ContainerC({
    Key? key,
    required this.h,
    required this.w,
    required this.url,
    required this.cat,
    required this.name,
  }) : super(key: key);

  final double h;
  final double w;
  final String url;
  final String cat;
  final String name;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.all(8.0),
          height: w / 2,
          //h / 2,
          width: w / 2,
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            borderRadius: BorderRadius.circular(32.0),
            image: DecorationImage(fit: BoxFit.cover, image: NetworkImage(url)),
          ),
          child: MaterialButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => CategorySearchC(name: name)));
            },
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(32.0)),
          ),
        ),
        Container(
          margin: EdgeInsets.only(left: 8.0, right: 8.0),
          padding: EdgeInsets.only(left: 4.0),
          width: w / 2,
          height: 48,
          child: Text(
            '$cat',
            style: TextStyle(),
            overflow: TextOverflow.clip,
          ),
        ),
      ],
    );
  }
}

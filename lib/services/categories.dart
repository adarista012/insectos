import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:insectos/models/categories.dart';

class CategoriesServices with ChangeNotifier {
  CollectionReference categoriesCollection =
      FirebaseFirestore.instance.collection('Orders');
  CollectionReference featuresCollection =
      FirebaseFirestore.instance.collection('Features');

  List<CategorieI> categoriesFromFire(QuerySnapshot snapshot) {
    return snapshot.docs.map((e) {
      return CategorieI(name: e.get('name'), url: e.get('url'));
    }).toList();
  }

  Stream<List<CategorieI>> listCategories() {
    return categoriesCollection.snapshots().map(categoriesFromFire);
  }

  List<CategorieI> featuresFromFire(QuerySnapshot snapshot) {
    return snapshot.docs.map((e) {
      return CategorieI(name: e.get('name'), url: e.get('url'));
    }).toList();
  }

  Stream<List<CategorieI>> listFeatures() {
    return featuresCollection.snapshots().map(categoriesFromFire);
  }
}

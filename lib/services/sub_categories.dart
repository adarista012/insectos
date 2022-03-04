import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:insectos/models/sub_categorie.dart';

class SubCategoriesServices with ChangeNotifier {
  CollectionReference subCategorieCollection =
      FirebaseFirestore.instance.collection('Sub Categories');

  List<SubCategorieI> subCatFromFire(QuerySnapshot snapshot) {
    return snapshot.docs.map((e) {
      return SubCategorieI(
          name: e.get('name'),
          categorie: e.get('categorie'),
          url: e.get('url'));
    }).toList();
  }

  Stream<List<SubCategorieI>> listOrders() {
    return subCategorieCollection
        .where('order', isEqualTo: 'Orden')
        .snapshots()
        .map(subCatFromFire);
  }

  Stream<List<SubCategorieI>> listFeatures() {
    return subCategorieCollection
        .where('order', isEqualTo: 'Característica')
        .snapshots()
        .map(subCatFromFire);
  }

  Stream<List<SubCategorieI>> t() {
    subCategorieCollection.where('categorie', isEqualTo: 'll').get();
    return subCategorieCollection.snapshots().map(subCatFromFire);
  }

  Future<List<SubCategorieI>> sCFromFire(String n) {
    return subCategorieCollection
        .where('categorie', isEqualTo: '$n')
        .get()
        .then((QuerySnapshot qS) {
      return qS.docs.map((e) {
        return SubCategorieI(
            name: e.get('name'),
            categorie: e.get('categorie'),
            url: e.get('url'));
      }).toList();
    });
  }
}

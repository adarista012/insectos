import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:insectos/models/insects.dart';

class InsectsServices with ChangeNotifier {
  CollectionReference insectsCollection =
      FirebaseFirestore.instance.collection('Insects');
  List<InsectsI> insectsFromFire(QuerySnapshot snapshot) {
    return snapshot.docs.map((e) {
      return InsectsI(
        name: e.get('name'),
        category: e.get('category'),
        subCategory: e.get('sub category'),
        url: e.get('url'),
        reino: e.get('reino'),
        filo: e.get('filo'),
        clase: e.get('clase'),
        subClase: e.get('sub clase'),
        orden: e.get('orden'),
        familia: e.get('familia'),
        metamorfosis: e.get('metamorfosis'),
        aparatoBucal: e.get('aparato bucal'),
        antenas: e.get('antenas'),
        patas: e.get('patas'),
        alas: e.get('alas'),
        alimentacion: e.get('alimentacion'),
      );
    }).toList();
  }

  Stream<List<InsectsI>> listInsects() {
    return insectsCollection.snapshots().map(insectsFromFire);
  }

  Future<List<InsectsI>> iFromFire(String n) {
    return insectsCollection
        .where('sub category', isEqualTo: '$n')
        .get()
        .then((QuerySnapshot qS) {
      return qS.docs.map((e) {
        return InsectsI(
          name: e.get('name'),
          category: e.get('category'),
          subCategory: e.get('sub category'),
          url: e.get('url'),
          reino: e.get('reino'),
          filo: e.get('filo'),
          clase: e.get('clase'),
          subClase: e.get('sub clase'),
          orden: e.get('orden'),
          familia: e.get('familia'),
          metamorfosis: e.get('metamorfosis'),
          aparatoBucal: e.get('aparato bucal'),
          antenas: e.get('antenas'),
          patas: e.get('patas'),
          alas: e.get('alas'),
          alimentacion: e.get('alimentacion'),
        );
      }).toList();
    });
  }
}

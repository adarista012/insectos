import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:insectos/models/intro.dart';
import 'package:insectos/models/logo.dart';

class ServicesComponents with ChangeNotifier {
  CollectionReference componentsCollection =
      FirebaseFirestore.instance.collection('Components');

  IntroI introFromFire(DocumentSnapshot snapshot) {
    return IntroI(date: snapshot.get('date'), intro: snapshot.get('con'));
  }

  Stream<IntroI> listIntro() {
    return componentsCollection
        .doc('Introduction')
        .snapshots()
        .map(introFromFire);
  }

  LogoI logoFromFire(DocumentSnapshot snapshot) {
    return LogoI(date: snapshot.get('date'), logo: snapshot.get('con'));
  }

  Stream<LogoI> listLogo() {
    return componentsCollection.doc('Logo').snapshots().map(logoFromFire);
  }
}

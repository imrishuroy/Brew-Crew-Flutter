import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  // collection reference
  DatabaseService({this.uid});
  final String uid;

  final CollectionReference brewCollection =
      FirebaseFirestore.instance.collection('brews');

  Future updateUserData(String sugars, String name, int strength) async {
    return await brewCollection.doc(uid).set({
      'sugars': sugars,
      'name': name,
      'strength': strength,
    });
  }
}

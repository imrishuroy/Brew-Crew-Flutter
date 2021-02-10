import 'package:brew_crew/models/app_user.dart';
import 'package:brew_crew/models/brew.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  // collection reference
  DatabaseService({this.uid});
  final String uid;

  final CollectionReference brewCollection =
      FirebaseFirestore.instance.collection('brews');

  Future updateUserData(String sugars, String name, int strength) async {
    return await brewCollection.doc(uid).set(
      {
        'sugars': sugars,
        'name': name,
        'strength': strength,
      },
    );
  }

  // Get brew list from snapshot
  List<Brew> _brewListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return Brew(
        name: doc.data()['name'] ?? '',
        strength: doc.data()['strength'] ?? '',
        sugars: doc.data()['sugars'] ?? '',
      );
    }).toList();
  }

  //Get brew stream
  Stream<List<Brew>> get brews {
    return brewCollection.snapshots().map(_brewListFromSnapshot);
  }

  // userdata from snapshot
  UserData _userDataFromSnapshot(DocumentSnapshot snapshot) {
    return UserData(
        uid: uid,
        name: snapshot.data()['name'],
        sugars: snapshot.data()['sugars'],
        strength: snapshot.data()['strength']);
  }

  // Get user doc stream
  Stream<UserData> get userData {
    return brewCollection.doc(uid).snapshots().map(_userDataFromSnapshot);
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_app/core/models/crew.dart';

class DatabaseService {
  final String uid;
  DatabaseService({this.uid = ""});
  final CollectionReference crewCollection =
      FirebaseFirestore.instance.collection('crews');
  Future updateUserData(String sugars, String name, int strength) async {
    return await crewCollection.doc(uid).set({
      'sugars': sugars,
      'name': name,
      'strength ': strength,
    });
  }

  List<Crew> _crewListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return Crew(
          name: doc.get('name') ?? 'name',
          strength: doc.get('strength') ?? 0,
          sugars: doc.get('sugars') ?? '0');
    }).toList();
  }

  Stream<List<Crew>> get crews {
    return crewCollection.snapshots().map(_crewListFromSnapshot);
  }
}

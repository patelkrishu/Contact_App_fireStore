

import 'package:cloud_firestore/cloud_firestore.dart';

import '../../model/user_model.dart';

class FireStoreService{

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  
  void registerUser(User user){
    CollectionReference collection = _firestore.collection("users");

    //
    // DateTime now = DateTime.now();
    // String uniqId = "${now.year},${now.month},${now.day},${now.hour},${now.minute},${now.second},${now.microsecond}";
    // collection.doc(uniqId).set(user.toMap());
    collection.add(user.toMap());

  }

  Future<QueryDocumentSnapshot<Object?>?> fetchUser(String username,String password)async {
    // CollectionReference collection = _firestore.collection("users");
    // DocumentReference doc = collection.doc("tWwQdDX4CJmCPi12Zel4");
    // DocumentSnapshot documentSnapshot = await doc.get();
    // Object? object = documentSnapshot.data();
    // print("++++++++++++++>>>>>>$object");

    CollectionReference collection = _firestore.collection("users");
    QuerySnapshot snapshot = await collection.get();
    // List<QueryDocumentSnapshot> docs = snapshot.docs;
    // List<QueryDocumentSnapshot> docs = query.snapshot.docs;
    Query query = collection.where("username",isEqualTo: username).where("password",isEqualTo: password);
    QuerySnapshot querySnapshot = await query.get();
    List<QueryDocumentSnapshot> docs = querySnapshot.docs;
    for(var docsnapshot in docs){
      print(">>>>>>>>>>>>>>${docsnapshot.data()}");
    }

    if(docs.isNotEmpty){
      return docs.first;
    }
    return null;
  }
}



// class FireStoreService {
//   final FirebaseFirestore _fireStore = FirebaseFirestore.instance;
//
//   void registerUser(User user) {
//     CollectionReference collection = _fireStore.collection('users_copy');
//
//     // DateTime now = DateTime.now();
//     // String uniqueId =
//     //     '${now.year}${now.month}${now.day}${now.hour}${now.minute}${now.second}${now.millisecond}';
//     //
//     // collection.doc(uniqueId).set(user.toMap()); // customID
//     collection.add(user.toMap()); // AutoID
//   }

//   Future<QueryDocumentSnapshot<Object?>?> fetchUser(String username, String password) async {
//     /// Fetch data from selected document
//     /* CollectionReference collection = _fireStore.collection('users_copy');
//     DocumentReference document = collection.doc('20241126111332104');
//     DocumentSnapshot documentSnapshot = await document.get();
//     Object? object = documentSnapshot.data();
//     print('+++_+_+_+_ ${object}');*/
//
//     CollectionReference collection = _fireStore.collection('users_copy');
//     // QuerySnapshot snapshot = await collection.get();
//     // List<QueryDocumentSnapshot> docs = snapshot.docs;
//     // List<QueryDocumentSnapshot> docs = query.snapshot.docs;
//     // Query query = collection.orderBy('name',descending: true);
//     Query query = collection
//         .where('username', isEqualTo: username)
//         .where('password', isEqualTo: password);
//     QuerySnapshot querySnapshot = await query.get();
//     List<QueryDocumentSnapshot> docs = querySnapshot.docs;
//
//     // for (var docSnapshot in docs) {
//     //   print('+++ ${docSnapshot.data()}');
//     // }
//
//     if(docs.isNotEmpty){
//       // Valid user
//       return docs.first;
//     }
//     return null;
//   }
// }

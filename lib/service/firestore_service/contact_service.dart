import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../../controller/user_controller.dart';
import '../../model/contact_model.dart';

class ContactService {
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;
  final AuthController _authController = Get.find<AuthController>();

   Future<void> addContact(Contact contact) async {
    CollectionReference collection = _fireStore.collection('contact');
    Map map = contact.toMap();
    map['userid'] = _authController.currentUser!.id;
    collection.add(map); // AutoID
  }


  Future<void> updateContact(Contact contact)async {
     print(contact.id);
     print(contact.name);
     print(contact.number);
     print(contact.toMap());
     await _fireStore.collection('contact').doc(contact.id).update(contact.toMap());
  }

  Future<List<QueryDocumentSnapshot>> fetchAllContact({required String hii}) async {
     print("++++++++++++++++++$hii");
    QuerySnapshot querySnapshot = await _fireStore.collection("contact").where("userid",isEqualTo: hii).orderBy("name").get();
    print("++++++++++++++++++++++++++++++++++${querySnapshot.docs}");
    return querySnapshot.docs;
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> fetchAllContact1({required String by}) {
    return _fireStore
        .collection('contact')
        .where('userid', isEqualTo: by)
        .orderBy('name')
        .snapshots();
  }

   Future<void> deleteContact(String id) async {
     print("+++++++++id++++++++++++$id");
     await _fireStore.collection("contact").doc(id).delete();

  }

  // Stream<QuerySnapshot<Map<String,dynamic>>> fetchAllContact1({required String hii}){
  //   return _fireStore.collection("contact").where("userid",isEqualTo: hii).orderBy("name").snapshots();
  //
  // }

}
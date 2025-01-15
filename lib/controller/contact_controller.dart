import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firestore_contact_app/controller/user_controller.dart';
import 'package:get/get.dart';

import '../model/contact_model.dart';
import '../service/firestore_service/contact_service.dart';

class ContactController extends GetxController{
  final AuthController controller = Get.find<AuthController>();

  final ContactService _contactService = ContactService();

  List<Contact> contacts = [];

  Future<void> addContact(String name, String number) async {
    Contact contact = Contact(name: name, number: number, userid: controller.currentUser!.id!);
    await _contactService.addContact(contact);
    contacts.add(contact);
  }

  Future<void> updateContact(Contact contact)async {
    _contactService.updateContact(contact);
  }
  
  Future<List<Contact>> fetchAllContact() async {
    String currentUserId = controller.currentUser!.id!;
    List<QueryDocumentSnapshot> snapshots = await _contactService.fetchAllContact(hii: currentUserId);
    contacts = snapshots.map(toElement).toList();
    print("1111111111111111111111111111111111${contacts.length}");
    return contacts;
  }

  Stream<QuerySnapshot<Object?>> fetchAllContact1() {
    String currentUserId = controller.currentUser!.id!;
    print('@!@!@!@!@!@! $currentUserId');
    Stream<QuerySnapshot> contactSnapshotStream =
    _contactService.fetchAllContact1(by : currentUserId);
    return contactSnapshotStream;
  }


  Contact toElement(QueryDocumentSnapshot contactSnapshot) =>
      Contact.fromFirebaseDocumentSnapshot(contactSnapshot);

  Future<void> deleteContact({required String id})async {
    await _contactService.deleteContact(id);
  }
}
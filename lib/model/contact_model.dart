import 'package:cloud_firestore/cloud_firestore.dart';

class Contact {
  String? id;
  String userid;
  String name;
  String number;

  Contact(
      {this.id,
      required this.userid,
      required this.name,
      required this.number});

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'userid': userid,
      'number': number,
    };
  }

  Contact copyWith({String? id, String? userid, String? name, String? number}) {
    return Contact(
        id: id ?? this.id,
        userid: userid ?? this.userid,
        name: name ?? this.name,
        number: number ?? this.number);
  }

  factory Contact.fromFirebaseDocumentSnapshot(
      QueryDocumentSnapshot<Object?> snapshot) {
    Map data = snapshot.data() as Map;
    return Contact(
        id: snapshot.id,
        userid: data['userid'],
        name: data['name'],
        number: data['number']);
  }


}


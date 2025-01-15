import 'package:cloud_firestore/cloud_firestore.dart';

class User{
  String? id;
  String name;
  String username;
  String password;

  User({this.id,required this.name,required this.username,required this.password});


  factory User.fromFireStore(QueryDocumentSnapshot snapshot){
    Map data = snapshot.data() as Map;
    return User(id: snapshot.id,name: data['name'], username: data['username'], password: data['password']);
  }


  Map<String,dynamic> toMap(){
    return {'name':name,
    'username':username,
    'password':password
    };
  }

}
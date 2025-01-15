import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firestore_contact_app/model/user_model.dart';
import 'package:flutter/cupertino.dart';

import '../service/firestore_service/firestore_service.dart';

class AuthController{
  final TextEditingController _nameCtrl = TextEditingController();
  final TextEditingController _usernameCtrl = TextEditingController(text: "k");
  final TextEditingController _passwordCtrl = TextEditingController(text: "k");

  TextEditingController get nameCtrl => _nameCtrl;
  TextEditingController get usernameCtrl => _usernameCtrl;
  TextEditingController get passwordCtrl => _passwordCtrl;

  final FireStoreService _fireStoreService = FireStoreService();

  User? currentUser;

  void register(){
    String name = _nameCtrl.text.trim();
    String username = _usernameCtrl.text.trim();
    String password = _passwordCtrl.text.trim();

    print("name ====>$name");
    print("username ==>$username");
    print("password ====>$password");

    User user = User(name: name, username: username, password: password);

    _fireStoreService.registerUser(user);

  }

  Future<User?> login() async {
    String username = _usernameCtrl.text.trim();
    String password = _passwordCtrl.text.trim();

    print(">>>>>>>>>>>>>>.username>>>>>>$username");
    print(">>>>>>>>>>>>password>>>>>>>$password");

    QueryDocumentSnapshot? snapshot = await _fireStoreService.fetchUser(username, password);

    if(snapshot != null){
      currentUser = User.fromFireStore(snapshot);
      return currentUser;
    }
    return null;
  }

}
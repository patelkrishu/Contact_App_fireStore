
import 'package:firestore_contact_app/controller/user_controller.dart';
import 'package:firestore_contact_app/views/widgets/text/title_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../widgets/buttons/submit_button.dart';
import '../widgets/inputs/text_input.dart';

class RegisterScreen extends StatelessWidget {
   RegisterScreen({super.key});

   final AuthController _authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            const SizedBox(height: 200,),
            const TitleText(Title: "Register"),
            const SizedBox(height: 50),
            TextInput(labelText: 'Name', controller: _authController.nameCtrl,),
            const SizedBox(height: 20,),
            TextInput(labelText: 'Username', controller: _authController.usernameCtrl),
            const SizedBox(height: 20,),
            TextInput(labelText: 'password', controller: _authController.passwordCtrl),
            const SizedBox(height: 20,),
            SubmitButton('Register',
            onPressed: () {
              _authController.register();
            },),
          ],
        ),
      ),
    );
  }
}

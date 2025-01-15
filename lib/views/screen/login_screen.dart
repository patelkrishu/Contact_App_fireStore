import 'package:firestore_contact_app/views/screen/home_screen.dart';
import 'package:firestore_contact_app/views/screen/register_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controller/user_controller.dart';
import '../../model/user_model.dart';
import '../widgets/buttons/submit_button.dart';
import '../widgets/inputs/text_input.dart';
import '../widgets/text/title_text.dart';

class LoginScreen extends StatelessWidget {
   LoginScreen({super.key});

  final AuthController _authController = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 150,),
              const TitleText(Title: "LogIn"),
              const SizedBox(height: 50),
              TextInput(labelText: 'Username', controller: _authController.usernameCtrl),
              const SizedBox(height: 20,),
             TextInput(labelText: 'password', controller: _authController.passwordCtrl),
             const SizedBox(height: 5,),
             Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                 const Text("New User?"),
                 TextButton(onPressed: () {
                   Navigator.push(context, MaterialPageRoute(builder: (context) => RegisterScreen(),));
                 }, child: const Text("Register")),
               ],
             ),
             const SizedBox(height: 20,),
              SubmitButton('LogIn',onPressed: () {
                _authController.login().then(
                    (User? user){
                      if(user != null){
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomeScreen(user: user,),));
                      }
                    }
                );
          },),
            ],
          ),
        ),
      ),
    );
  }
}

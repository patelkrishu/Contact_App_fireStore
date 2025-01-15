import 'package:firestore_contact_app/views/widgets/inputs/text_input.dart';
import 'package:flutter/material.dart';

import '../../../model/contact_model.dart';
import '../buttons/submit_button.dart';

class ContactForm extends StatelessWidget {
  ContactForm({super.key, required this.onSubmited, this.contact});

  final Contact? contact;

  final TextEditingController _nameCtrl = TextEditingController();
  final TextEditingController _numberCtrl = TextEditingController();

  final Future<void> Function(String name, String Number) onSubmited;

  @override
  Widget build(BuildContext context) {

    String title = "Add Contact";

    if(contact != null){
      _nameCtrl.text = contact!.name;
      _numberCtrl.text = contact!.number;
      title = "Update Contact";
    }

    return AlertDialog(
      title: Text(title),
      actions: [
        const SizedBox(
          height: 10,
        ),
        SizedBox(
            width: 300,
            child: TextInput(labelText:
              "Contact Name",
              controller: _nameCtrl,
            )),
        const SizedBox(
          height: 10,
        ),
        SizedBox(
            width: 300,
            child: TextInput(labelText: "Contact Number", controller: _numberCtrl)),
        const SizedBox(
          height: 10,
        ),
        SubmitButton(
          "Save",
          onPressed: () {
            String name = _nameCtrl.text.trim();
            String number = _numberCtrl.text.trim();
            if(_nameCtrl.text.isNotEmpty && _numberCtrl.text.isNotEmpty){
              onSubmited(name, number);
              Navigator.of(context).pop();
            }

            // onSubmited(name, number);
            // Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}

import 'package:firestore_contact_app/model/contact_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';

class ContactTile extends StatelessWidget {
  const ContactTile(
      {super.key,
      required this.contact,
      required this.onDelete,
      required this.onUpdate,});

  final Contact contact;
  final void Function() onUpdate;
  final void Function() onDelete;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        child: Text(contact.name[0].toUpperCase()),
      ),
      onTap: () => callNumber(),
      title: Text(contact.name),
      subtitle: Text(contact.number),
      trailing: PopupMenuButton(
        onSelected: (value) {
          if (value == 1) {
            onUpdate();
          }
          else if(value ==2){
            onDelete();
          }
        },
        itemBuilder: (context) {
          return [
            const PopupMenuItem(value: 1, child: Text("Update")),
            const PopupMenuItem(value: 2, child: Text("Delete")),
          ];

        },
      ),
    );
  }

  callNumber() async{
    var number = "+91${contact.number}"; //set the number here
    bool? res = await FlutterPhoneDirectCaller.callNumber(number);
  }
}

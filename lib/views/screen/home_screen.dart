import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firestore_contact_app/controller/contact_controller.dart';
import 'package:firestore_contact_app/views/screen/Search_screen.dart';
import 'package:firestore_contact_app/views/widgets/tiles/contact_tile.dart';
import 'package:flutter/material.dart';
import '../../model/contact_model.dart';
import '../../model/user_model.dart';
import '../widgets/dailog_box/contact_form.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({
    super.key,
    required this.user,
  });

  final User user;

  final ContactController _contactController = ContactController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(onPressed: () {
             Navigator.push(context, MaterialPageRoute(builder: (context) => SearchScreen(),));
              // SearchScreen();
            }, icon: Icon(Icons.search)),
          ],
        ),
        drawer: Drawer(
          child: Column(
            children: [
              UserAccountsDrawerHeader(
                // currentAccountPicture: CircleAvatar(),
                accountName: Text(user.name),
                accountEmail: Text(user.username),
              )
            ],
          ),
        ),
        body: _streamBuilderWay(),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () => _showContactForm(context),
          label: const Text(
            "add contact",
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.brown,
        ));
  }

  _showContactForm(BuildContext context, [Contact? contact]) {
    showDialog(
        context: context,
        builder: (context) => ContactForm(
              /*onSubmit: (contactName, contactNumber) async {
                  if (contact == null) {
                    await _contactController.addContact(contactName, contactNumber);
                  } else {
                    await _contactController.updateContact(contact);
                  }
                },*/
              onSubmited: contact == null
                  ? _contactController.addContact
                  : (name, number) => _contactController.updateContact(
                      contact.copyWith(name: name, number: number)),
              contact: contact,
            ));
  }

  // _futureBuilder(){
  //   return StatefulBuilder(builder: (context, setState) {
  //    return RefreshIndicator(
  //       child: FutureBuilder(
  //         future: _contactController.fetchAllContact(),
  //         builder: (context, snapshot) {
  //           if (snapshot.connectionState == ConnectionState.done) {
  //             if (snapshot.hasError) {
  //               return const Center(child: Text('Something went wrong!'));
  //             }
  //             if (!snapshot.hasData) {
  //               return const Center(child: Text('No data found!'));
  //             }
  //
  //             List<QueryDocumentSnapshot> contactSnapshot = snapshot.data!.docs;
  //             List<Contact> contacts = contactSnapshot
  //                 .map((contactSnapshot) =>
  //                 Contact.fromFirebaseDocumentSnapshot(contactSnapshot))
  //                 .toList();
  //             return ListView.builder(
  //               itemCount:contacts.length,
  //               itemBuilder: (context, index) => ContactTile(
  //                 contact: contacts[index],
  //                 onUpdate: () {},
  //                   _showContactForm(context, contacts[index]),
  //                   onDelete: () {},
  //               ),
  //             );
  //           }
  //           return const Center(child: CircularProgressIndicator());
  //         },
  //       ), onRefresh: () async{
  //           setState((){});
  //     },);
  //   },);
  // }

  _streamBuilderWay() {
    return StreamBuilder(
      stream: _contactController.fetchAllContact1(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          if (snapshot.hasError) {
            // return Text(Error() as String);
            return const Center(child: Text('Something went wrong!'));
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text('No data found!'));
          }
          print(')()()()()()()${snapshot.data!.docs}');

          List<QueryDocumentSnapshot> contactSnapshot = snapshot.data!.docs;
          List<Contact> contacts = contactSnapshot
              .map((contactSnapshot) =>
                  Contact.fromFirebaseDocumentSnapshot(contactSnapshot))
              .toList();
          return ListView.builder(
            itemCount: contacts.length,
            itemBuilder: (context, index) => ContactTile(
              contact: contacts[index],
              onUpdate: () {
                _showContactForm(context, contacts[index]);
              },
              onDelete: () {
                _showConfirmation(context, onSubmit: () {
                  _contactController
                      .deleteContact(id: contacts[index].id!)
                      .then(
                        (value) => Navigator.pop(context),
                      );
                });
              },

            ),

          );
        }
        return const Center(child: CircularProgressIndicator());
      },
    );
  }

  void _showConfirmation(BuildContext context,
      {required void Function() onSubmit}) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Alert"),
          content: const Text("are you sure?????"),
          actions: [
            TextButton(
                onPressed: () => Navigator.pop(context), child: const Text("cancel")),
            TextButton(onPressed: onSubmit, child: const Text("yes")),
          ],
        );
      },
    );
  }

// _futureBuilder() {
//   return FutureBuilder(
//       future: _contactController.fetchAllContact(),
//       builder: (context, snapshot) {
//         if (snapshot.connectionState == ConnectionState.done) {
//           if (snapshot.hasError) {
//             print(Error());
//             // return Center(child: Text("Something went wrong"));
//           }
//           if (!snapshot.hasData) {
//             return Center(child: Text("No Data Founded!"));
//           }
//
//           return StatefulBuilder(
//             builder: (context, setState) {
//               List<Contact> contacts = snapshot.data!;
//               return RefreshIndicator(
//                 onRefresh: () async {
//                   print('~!!~!~!~!~!~!~! ${contacts.length}');
//                   contacts = await _contactController.fetchAllContact();
//                   print('~!!~!~!~!~!~!~! ${contacts.length}');
//                   setState(() {});
//                 },
//                 child: ListView.separated(
//                     itemBuilder: (context, index) {
//                       return ContactTile(
//                         contact: contacts[index], onDelete: () {  }, onUpdate: () {  },
//                       );
//                     },
//                     separatorBuilder: (context, index) {
//                       return SizedBox(height: 10);
//                     },
//                     itemCount: contacts.length),
//               );
//             },
//           );
//          }
//         return Center(child: CircularProgressIndicator());
//       });
// }
}

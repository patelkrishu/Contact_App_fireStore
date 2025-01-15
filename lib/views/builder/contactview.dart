import 'package:firestore_contact_app/views/widgets/tiles/contact_tile.dart';
import 'package:flutter/material.dart';

import '../../model/contact_model.dart';

class ContactView extends StatelessWidget {
  const ContactView.builder({
    super.key,
    required this.itemBuilder,
    required this.itemCount,
    this.onEdit,
    this.onDelete,
    this.tileColor,
    this.onTap,
  });

  final Contact Function(BuildContext context, int index) itemBuilder;
  final int itemCount;
  final Color? tileColor;
  final void Function(Contact contact, int index)? onEdit;
  final void Function(Contact contact, int index)? onDelete;
  final void Function(Contact contact)? onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView.separated(
        itemCount: itemCount,
        itemBuilder: (context, index) {
          final Contact contact = itemBuilder(context, index);
          return _buildContactTile(contact, index);
        },
        separatorBuilder: (_, __) => const SizedBox(height: 12),
      ),
    );
  }

  Widget _buildContactTile(Contact contact, int index) {
    return ContactTile(
      contact:contact,
      onDelete: () {}, onUpdate: () { },);
  }
}
import 'package:get/get.dart';

import '../model/contact_model.dart';
import 'contact_controller.dart';

class SearchContactController extends ContactController {
  final RxList<Contact> _searchResult = <Contact>[].obs;

  List<Contact> get searchResult => _searchResult;

  void search(String? value) {
    if (value != null && value.isNotEmpty) {
      _searchResult.value = contacts
          .where((contact) =>
      contact.name.toLowerCase().contains(value.toLowerCase()) ||
          contact.number.toLowerCase().contains(value.toLowerCase()))
          .toList();
    } else {
      _searchResult.clear();
    }
  }
}
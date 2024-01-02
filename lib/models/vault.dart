import 'dart:convert';
import 'package:paranoid_password_manager/models/form_template.dart';
import 'package:paranoid_password_manager/models/template_manager.dart';
import 'package:paranoid_password_manager/models/vault_entry.dart';

import 'package:paranoid_password_manager/utils.dart';

class Vault {
  List<VaultEntry> _entries = [];
  final TemplateManager _templateManager = TemplateManager();

  // return the list of all the SecureRecord objects
  List<VaultEntry> get entries => _entries;

  Vault();

  FormTemplate addNewTemplate(String name) {
    return _templateManager.addNewTemplate(name);
  }

  // add a new SecureRecord object to the _secureRecords list
  void addEntry(VaultEntry entry) {
    if (entry.id == '') {
      entry.id = generateID();
    }

    _entries.add(entry);
  }

  List<VaultEntry> search(String query) {
    List<VaultEntry> result = [];
    for (var entry in _entries) {
      if (entry.match(query)) {
        result.add(entry);
      }
    }
    return result;
  }

  String toJson() {
    String json = jsonEncode({
      // "templates": _templateManager.toJson(),
      "entries": _entries.map((e) => e.toJson()).toList(),
    });

    return json;
  }

  // return the encrypted vault
  String get encryptedVault {
    final json = toJson();

    return json;
  }

  // create the vault starting from a JSON string
  Vault.fromJson(String json) {
    Map<String, dynamic> map = jsonDecode(json);

    // check if map['entries'] exists and is not null or empty
    if (map['entries'] == null || map['entries'].length == 0) {
      map['entries'] = [];
    }

    if (map['templates'] == null || map['templates'].length == 0) {
      map['templates'] = [];
    }

    _entries = [];

    for (var element in map['entries']) {
      _entries.add(VaultEntry.fromJson(element));
    }

    _templateManager.fromJson(map['templates']);
  }
}

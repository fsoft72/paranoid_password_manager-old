// create the FormTemplate class
import 'dart:convert';

import 'package:paranoid_password_manager/models/field_description.dart';
import 'package:paranoid_password_manager/utils.dart';

class FormTemplate {
  final List<FieldDescription> _fields = [];
  String id = generateID();
  String name = '';

  // create an empty FormTemplate object
  FormTemplate([this.name = '']);

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'fields': _fields.map((e) => e.toJson()).toList(),
    };
  }

  // create a FormTemplate object from a JSON string
  FormTemplate.fromJson(Map<String, dynamic> map) {
    id = map['id'];
    name = map['name'];

    for (var element in map['fields']) {
      _fields.add(FieldDescription.fromJson(element));
    }
  }

  // return the FieldDescription object with the given id
  FieldDescription getByID(String id) {
    return _fields.firstWhere((element) => element.id == id);
  }

  // return the FieldDescription object with the given name
  FieldDescription getByName(String name) {
    return _fields.firstWhere((element) => element.name == name);
  }

  // return the FieldDescription object with the given index
  FieldDescription getByPos(int index) {
    return _fields[index];
  }

  // create a new FieldDescription object and add it to the list
  FieldDescription add({required String name, String type = "string", bool sensitive = false, bool url = false}) {
    final String id = generateID();
    final field = FieldDescription(
      id: id,
      name: name,
      type: type,
      sensitive: sensitive,
      url: url,
    );
    _fields.add(field);

    return field;
  }

  void addFieldDescription(FieldDescription fieldDescription) {
    _fields.add(fieldDescription);
  }
}

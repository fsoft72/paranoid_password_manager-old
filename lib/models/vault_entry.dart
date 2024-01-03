import 'package:paranoid_password_manager/config/store.dart';
import 'package:paranoid_password_manager/models/field_description.dart';
import 'package:paranoid_password_manager/models/form_template.dart';
import 'package:paranoid_password_manager/models/template_manager.dart';
import 'package:paranoid_password_manager/models/vault.dart';
import 'package:paranoid_password_manager/utils.dart';

class VaultEntry {
  late String id;
  late String idTemplate;
  late String title;
  late Map<String, String> values;

  late FormTemplate form;

  VaultEntry(this.title, this.idTemplate) {
    id = generateID();
    values = {};

    form = appStore.value.vault.value.getTemplate(idTemplate)!;
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'values': values,
      'idTemplate': idTemplate,
    };
  }

  factory VaultEntry.fromJson(Map<String, dynamic> json) {
    final VaultEntry entry = VaultEntry(json['title'], json['idTemplate']);
    entry.id = json['id'];
    entry.title = json['title'];
    entry.idTemplate = json['idTemplate'];

    for (var key in json['values'].keys) {
      entry.values[key] = json['values'][key];
    }

    return entry;
  }

  // add a new FieldDescription object to the dataDescription list
  void setFieldDescription(FieldDescription fieldDescription) {
    form.addFieldDescription(fieldDescription);
  }

  /*
  FieldDescription addFieldDescription(
      {required String name, String type = "string", bool sensitive = false, bool url = false, String id = ""}) {
    if (id == "") {
      id = generateID();
    }

    final fd = FieldDescription(
      id: id,
      name: name,
      type: type,
      sensitive: sensitive,
      url: url,
    );
    form.addFieldDescription(fd);

    return fd;
  }
	*/

  // add a new value to the values map
  void addValue(String idFormField, dynamic value) {
    values[idFormField] = value;
  }

  void addValueByName(String fieldName, dynamic value) {
    final fd = form.getByName(fieldName);
    if (fd != null) {
      values[fd.id] = value;
    }
  }

  bool match(String query) {
    query = query.trim().toLowerCase();
    if (title.toLowerCase().contains(query)) {
      return true;
    }

    for (var value in values.values) {
      if (value.toLowerCase().contains(query)) {
        return true;
      }
    }

    return false;
  }
}

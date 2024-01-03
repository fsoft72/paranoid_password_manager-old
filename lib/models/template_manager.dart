import 'package:paranoid_password_manager/models/form_template.dart';
import 'package:paranoid_password_manager/utils.dart';

/// The TemplateManager class handles the FormTemplates, it contains the following fields:
/// - templates: a Map of FormTemplates, the key is the id of the FormTemplate.
///
/// It is also responsible for saving and loading the templates from the disk in encrypted form and for decrypting them.
class TemplateManager {
  Map<String, FormTemplate> _templates = {};

  TemplateManager();

  // return the list of all the FormTemplate objects
  List<FormTemplate> get templates => _templates.values.toList();

  FormTemplate addNewTemplate(String name) {
    final FormTemplate template = FormTemplate();
    template.name = name;

    return addTemplate(template);
  }

  // add a new FormTemplate object to the _templates map
  FormTemplate addTemplate(FormTemplate template) {
    if (template.id == '') {
      template.id = generateID();
    }

    _templates[template.id] = template;

    return template;
  }

  FormTemplate? getTemplate(String id) {
    FormTemplate? template = _templates[id];

    return template;
  }

  List<dynamic> toJson() {
    List<dynamic> map = [];

    for (var key in _templates.keys) {
      map.add(_templates[key]!.toJson());
    }

    return map;
  }

  // create the templates starting from a JSON string
  void fromJson(List<dynamic> map) {
    _templates = {};

    for (var element in map) {
      final template = FormTemplate.fromJson(element);
      _templates[template.id] = template;
    }
  }
}

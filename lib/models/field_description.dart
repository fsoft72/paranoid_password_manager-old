/// The FieldDescription class is used to describe a single data field, it contains the following fields:
/// - id: the id of the data field (string).
/// - name: the name of the data field (string).
/// - type: the type of the data field (string).
/// - sensitive: a boolean value that indicates if the data field is sensitive or not.
/// - url: a boolean value that indicates if the data field is an url or not.
class FieldDescription {
  final String id;
  final String name;
  final String type;
  final bool sensitive;
  final bool url;

  FieldDescription(
      {required this.id, required this.name, required this.type, required this.sensitive, required this.url});

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'type': type,
      'sensitive': sensitive,
      'url': url,
    };
  }

  // create a FieldDescription object from a JSON string
  factory FieldDescription.fromJson(Map<String, dynamic> json) {
    return FieldDescription(
      id: json['id'],
      name: json['name'],
      type: json['type'],
      sensitive: json['sensitive'],
      url: json['url'],
    );
  }
}

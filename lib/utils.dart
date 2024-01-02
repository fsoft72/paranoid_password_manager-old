import 'package:uuid/uuid.dart';

// this function returns a unique string of 32 characters
String generateID() {
  var uuid = const Uuid();
  return uuid.v4();
}

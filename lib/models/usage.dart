// test the vault usage
import 'package:paranoid_password_manager/models/form_template.dart';
import 'package:paranoid_password_manager/models/vault_entry.dart';
import 'package:paranoid_password_manager/models/vault.dart';

void testUsage() {
  final Vault vault = Vault();
  final FormTemplate template = vault.addNewTemplate("email");

  final fdEmail = template.add(name: "email");
  final fdPassowrd = template.add(name: "password", sensitive: true);
  final fdIMAP = template.add(name: "imap");
  final fdSMTP = template.add(name: "smtp");
  final fdIMAPPort = template.add(name: "imap_port", type: "number");
  final fdSMTPPort = template.add(name: "smtp_port", type: "number");

  VaultEntry entry = VaultEntry("gmail account");
  entry.idTemplate = template.id;

  entry.addValue(fdEmail.id, "test@gmail.com");
  entry.addValue(fdPassowrd.id, "test-password");
  entry.addValue(fdIMAP.id, "imap.gmail.com");
  entry.addValue(fdSMTP.id, "smtp.gmail.com");
  entry.addValue(fdIMAPPort.id, "993");
  entry.addValue(fdSMTPPort.id, "587");

  vault.addEntry(entry);

  entry = VaultEntry("hotmail account");
  entry.idTemplate = template.id;

  entry.addValue(fdEmail.id, "test@hotmail.com");
  entry.addValue(fdPassowrd.id, "test-password");
  entry.addValue(fdIMAP.id, "imap.hotmail.com");
  entry.addValue(fdSMTP.id, "smtp.hotmail.com");
  entry.addValue(fdIMAPPort.id, "993");
  entry.addValue(fdSMTPPort.id, "587");

  vault.addEntry(entry);

  String json = vault.toJson();

  print("=== Vault: " + json);

  final vault2 = Vault.fromJson(json);
  print("=== Vault2: " + vault2.toJson());

/*
  final entry2 = vault2.entries[0];
  print("=== entry2: " + entry2.title);
  print("=== entry2: " + entry2.values[fdEmail.id]!);
  print("=== entry2: " + entry2.values[fdIMAP.id]!);

  final records = vault2.search(".com");

  print("=== Records: " + records.length.toString());
  for (var record in records) {
    print("=== Record: " + record.title);
  }
	*/
}

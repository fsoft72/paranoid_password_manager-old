import 'dart:io';

import 'package:get/get.dart';
import 'package:paranoid_password_manager/models/vault.dart';
import 'package:paranoid_password_manager/models/vault_entry.dart';

class AppStore extends GetxController {
  // Define your global state variables here
  RxInt counter = 0.obs;
  Rx<Vault> vault = Rx<Vault>(Vault());

  // Load the vault from a file
  void loadVault() {
    final file = File("vault.json");

    // check if the file exists
    if (file.existsSync()) {
      final json = file.readAsStringSync();
      final va = Vault.fromJson(json);
      vault.value = va;
    }
  }

  // create vault demo
  void createVaultDemo() {
    final testVault = vault.value;

    final template = testVault.addNewTemplate("email");

    template.add(name: "email");
    template.add(name: "password", sensitive: true);
    template.add(name: "imap");
    template.add(name: "smtp");
    template.add(name: "imap_port", type: "number");
    template.add(name: "smtp_port", type: "number");

    var entry = VaultEntry("gmail account", template.id);
    entry.idTemplate = template.id;

    entry.addValueByName("email", "test@gmail.com");
    entry.addValueByName("password", "test-password");
    entry.addValueByName("imap", "imap.gmail.com");
    entry.addValueByName("smtp", "smtp.gmail.com");
    entry.addValueByName("imap_port", "993");
    entry.addValueByName("smtp_port", "587");

    testVault.addEntry(entry);

    print("=== DEMO OK");
  }
}

final appStore = AppStore().obs;

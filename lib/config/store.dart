import 'dart:io';

import 'package:get/get.dart';
import 'package:paranoid_password_manager/models/vault.dart';

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
}

final appStore = AppStore().obs;

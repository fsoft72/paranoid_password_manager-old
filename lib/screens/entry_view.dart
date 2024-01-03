// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:paranoid_password_manager/models/field_description.dart';
import 'package:paranoid_password_manager/models/form_template.dart';
import 'package:paranoid_password_manager/models/vault_entry.dart';

class EntryView extends StatelessWidget {
  final VaultEntry vaultEntry;

  const EntryView({super.key, required this.vaultEntry});

  @override
  Widget build(BuildContext context) {
    FormTemplate template = vaultEntry.form;

    Widget _menu() {
      return PopupMenuButton(
        itemBuilder: (BuildContext context) => [
          const PopupMenuItem(
            value: 1,
            child: Text('Option 1'),
          ),
          const PopupMenuItem(
            value: 2,
            child: Text('Option 2'),
          ),
          const PopupMenuItem(
            value: 3,
            child: Text('Option 3'),
          ),
        ],
        icon: const Icon(Icons.more_vert),
        onSelected: (value) {
          // Add your menu button logic here
        },
      );
    }

    Widget _buildField(FieldDescription field, String value) {
      bool isSensitive = field.sensitive;
      final RxBool showValue = isSensitive ? false.obs : true.obs;

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            field.name,
            style: const TextStyle(
              color: Colors.blue,
              fontSize: 12,
            ),
          ),
          GestureDetector(
            onTap: () {
              Get.snackbar(
                'Clipboard ready',
                '${field.name} copied to clipboard',
                snackPosition: SnackPosition.BOTTOM,
                duration: const Duration(seconds: 3),
                backgroundColor: Colors.green,
              );
              Clipboard.setData(
                ClipboardData(text: value),
              );
            },
            child: Row(
              children: [
                Expanded(
                  child: Obx(() => Text(
                        showValue.value ? value : '•' * value.length,
                        style: const TextStyle(
                          fontSize: 14,
                        ),
                      )),
                ),
                if (isSensitive)
                  IconButton(
                    icon: Obx(() => Icon(showValue.value ? Icons.visibility : Icons.visibility_off)),
                    onPressed: () {
                      showValue.value = !showValue.value;
                    },
                  ),
              ],
            ),
          ),
          const SizedBox(height: 10),
        ],
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(vaultEntry.title),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {
              // Add your edit button logic here
            },
          ),
          _menu(),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: ListView.builder(
                itemCount: template.fields.length,
                itemBuilder: (context, index) {
                  final field = template.fields[index];
                  final value = vaultEntry.values[field.id] ?? '';

                  return _buildField(field, value);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

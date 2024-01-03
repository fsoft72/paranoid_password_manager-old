import 'package:flutter/material.dart';
import 'package:paranoid_password_manager/models/form_template.dart';
import 'package:paranoid_password_manager/models/vault_entry.dart';

class EntryView extends StatelessWidget {
  final VaultEntry vaultEntry;

  const EntryView({super.key, required this.vaultEntry});

  @override
  Widget build(BuildContext context) {
    FormTemplate template = vaultEntry.form;

		Widget _menu () {
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
          ),
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

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        field.name,
                        style: const TextStyle(
                          color: Colors.blue,
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        value,
                        style: const TextStyle(
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(height: 8),
                    ],
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

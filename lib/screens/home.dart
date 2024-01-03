import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paranoid_password_manager/config/store.dart';
import 'package:paranoid_password_manager/models/vault.dart';
import 'package:paranoid_password_manager/models/vault_entry.dart';
import 'package:paranoid_password_manager/screens/entry_view.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  Vault get vault => appStore.value.vault.value;
  List<VaultEntry> get entries => vault.entries;

  Widget _searchBar() {
    return const Row(
      children: [
        Icon(Icons.search),
        SizedBox(width: 8),
        Expanded(
          child: TextField(
            decoration: InputDecoration.collapsed(
              hintText: 'Search',
            ),
          ),
        ),
      ],
    );
  }

  Widget _bottom() {
    return BottomAppBar(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          IconButton(
            icon: const Icon(Icons.home),
            onPressed: () {
              // Handle home button press
            },
          ),
          IconButton(
            icon: const Icon(Icons.favorite),
            onPressed: () {
              // Handle favorite button press
            },
          ),
          FloatingActionButton(
            child: const Icon(Icons.add),
            onPressed: () {
              // Handle add button press
            },
          ),
          IconButton(
            icon: const Icon(Icons.notifications),
            onPressed: () {
              // Handle notifications button press
            },
          ),
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              // Handle settings button press
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: _searchBar(),
        // Add any other app bar customization here
      ),
      body: ListView.builder(
        itemCount: entries.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(entries[index].title),
            onTap: () {
              Get.to(EntryView(vaultEntry: entries[index]));
            },
          );
        },
      ),
      bottomNavigationBar: _bottom(),
    );
  }
}

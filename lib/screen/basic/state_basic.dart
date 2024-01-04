import 'package:flutter/material.dart';
import 'package:state/screen/basic/new_contact_view.dart';
import 'package:uuid/uuid.dart';

class Contact {
  Contact({required this.name}) : id = const Uuid().v4();
  final String name;
  final String id;
}

class ContactBook extends ValueNotifier<List<Contact>> {
  ContactBook._sharedInstance() : super([]);
  static final ContactBook _shared = ContactBook._sharedInstance();
  factory ContactBook() => _shared;

  int get length => value.length;
  void add({required Contact contact}) {
    final contacts = value;
    contacts.add(contact);
    notifyListeners();
  }

  void remove({required Contact contact}) {
    final contacts = value;
    if (contacts.contains(contact)) {
      contacts.remove(contact);
    }
    notifyListeners();
  }

  Contact? contact({required int atIndex}) =>
      value.length > atIndex ? value[atIndex] : null;
}

class StateBasic extends StatelessWidget {
  const StateBasic({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("State Basic")),
      body: ValueListenableBuilder(
        valueListenable: ContactBook(),
        builder: (context, value, child) {
          final contacts = value;
          return ListView.builder(
              itemCount: contacts.length,
              itemBuilder: (context, index) {
                final contact = contacts[index];
                return Dismissible(
                  onDismissed: (direction) {
                    ContactBook().remove(contact: contact);
                  },
                  key: ValueKey(contact.id),
                  child: Material(
                    color: Colors.yellow,
                    child: ListTile(
                      title: Text(contact.name),
                    ),
                  ),
                );
              });
        },
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const NewContactView()));
          },
          child: const Icon(Icons.add)),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:contacts_service/contacts_service.dart';
import '../services/contact_service.dart';

class ContactListScreen extends StatefulWidget {
  @override
  _ContactListScreenState createState() => _ContactListScreenState();
}

class _ContactListScreenState extends State<ContactListScreen> {
  List<Contact> _contacts = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchContacts();
  }

  _fetchContacts() async {
    ContactService contactService = ContactService();
    List<Contact> contacts = await contactService.getContacts();
    setState(() {
      _contacts = contacts;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Contactos'),
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: _contacts.length,
              itemBuilder: (context, index) {
                Contact contact = _contacts[index];
                String displayName = contact.displayName ?? 'No Name';
                String phone = 'No Phone';
                if (contact.phones != null) {
                  final List<Item>? phonesList = contact.phones?.toList();
                  if (phonesList != null && phonesList.isNotEmpty) {
                    final String? firstPhone = phonesList.first.value;
                    if (firstPhone != null) {
                      phone = firstPhone;
                    }
                  }
                }
                return ListTile(
                  title: Text(displayName),
                  subtitle: Text(phone),
                );
              },
            ),
    );
  }
}

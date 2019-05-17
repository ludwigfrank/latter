import 'package:flutter/material.dart';
import 'dart:async';
import 'package:latter/pages/contacts/widgets/widgets.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:contacts_service/contacts_service.dart';

class ContactsPage extends StatefulWidget {
    @override
    _ContactsPageState createState() => _ContactsPageState();
}

class _ContactsPageState extends State<ContactsPage> {
    PermissionStatus _contactsPermissionStatus;
    Iterable<Contact> _contacts;

    @override
    void initState() {
        super.initState();
        PermissionHandler().checkPermissionStatus(PermissionGroup.contacts)
            .then(_updateContactsPermissionStatus);

        print('speech');
    }

    void _updateContactsPermissionStatus (PermissionStatus status) {
        if (status == PermissionStatus.granted) {
            _updateContacts();
        }
        if(status != _contactsPermissionStatus) {
            setState(() {
                _contactsPermissionStatus = status;
            });
        }
    }

    void _updateContacts() {
        ContactsService.getContacts().then((Iterable contacts) {
            setState(() { _contacts = contacts; });
        });
     }

    void _askContactsPermission () {
        PermissionHandler().requestPermissions([PermissionGroup.contacts])
            .then(_onContactsPermissionRequest);
    }

    void _onContactsPermissionRequest (Map<PermissionGroup, PermissionStatus> statuses) {
        final status = statuses[PermissionGroup.contacts];
        if (status != PermissionStatus.granted) {
            PermissionHandler().openAppSettings();
        } else {
            _updateContactsPermissionStatus(status);
        }
    }
    
    Widget _buildContacts (BuildContext context) {
        if (_contacts.length > 1) {
            return ListView.builder(
                itemCount: _contacts.length,
                itemBuilder: (BuildContext context, int index) {
                    return Text(_contacts.elementAt(index).toString());
                }
            );
        } else {
            return Text('No Contacts');
        }
    }

    @override
    Widget build(BuildContext context) {
        return Center(
            child: Column(
                children: <Widget>[
                    SizedBox(height: 120,),
                    Text('$_contactsPermissionStatus'),
                    OutlineButton(
                        onPressed: _askContactsPermission,
                        child: Text('Grand contacts permission.'),
                    ),
                    _buildContacts(context)
                ],
            )
        );
    }
}


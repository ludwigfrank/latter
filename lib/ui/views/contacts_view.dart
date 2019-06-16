import 'package:built_collection/built_collection.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:latter/core/models/conversation.dart';
import 'package:latter/core/models/profile.dart';
import 'package:latter/core/models/serializers.dart';
import 'package:latter/core/services/profile_service.dart';
import 'package:latter/ui/styles/text.dart';
import 'package:phone_number/phone_number.dart';

import '../../locator.dart';

class ContactsView extends StatefulWidget {
    @override
    _ContactsState createState() => _ContactsState();
}

final conv = {
    'id': 'asdf',
    'messages': [],
    'participants': []
};


class _ContactsState extends State<ContactsView> {

    Conversation c = Conversation((c) => c
        ..id = 'asdf'
        ..participantIds = null
    );

    Widget _buildContactItem(Contact contact, BuildContext context) {

        return GestureDetector(
            onTap: () {
                ProfileService _profileService = locator<ProfileService>();

                PhoneNumber.parse(contact.phones.first.value).then((value) {
                    String parsedPhoneNumber = value['e164'];

                    print(parsedPhoneNumber);
                    _profileService.getProfileFromPhoneNumber(parsedPhoneNumber).then((value) {
                            _profileService.addContact(value);
                        }
                    );
                });

            },
            child: (
              Row(
                  children: <Widget>[
                      Expanded(
                          child: DecoratedBox(
                              child: Row(
                                  children: <Widget>[
                                      Padding(
                                          padding: const EdgeInsets.only(top: 18.0, bottom: 20.0),
                                          child: Text(contact.displayName, style: subhead,),
                                      ),
                                  ],
                              ),
                              decoration: BoxDecoration(
                                  border: Border(
                                      bottom: Divider.createBorderSide(context),
                                  ),
                              )
                          ),
                      )
                  ],
              )
          ),
        );
    }

    Widget _buildContacts(Iterable<Contact> contacts, context) {
        return ListView.builder(
            itemCount: contacts.length,
            itemBuilder: (BuildContext context, int index) {
                return _buildContactItem(contacts.elementAt(index), context);
            }
        );
    }

    @override
    Widget build(BuildContext context) {

        return Scaffold(
            body: (
                Padding(padding: EdgeInsets.symmetric(horizontal: 24),
                    child: FutureBuilder(
                        future: ContactsService.getContacts(withThumbnails: false),
                        builder: (_, snapshot) {
                            if (snapshot.connectionState == ConnectionState.done) {
                                return _buildContacts(snapshot.data, context);
                            } else {
                                return CircularProgressIndicator();
                            }

                        }
                    ),
                )
            ),
        );
    }
}

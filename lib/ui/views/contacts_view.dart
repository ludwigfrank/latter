import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:latter/core/models/conversation.dart';
import 'package:latter/core/models/profile.dart';
import 'package:latter/ui/styles/text.dart';
import 'package:provider/provider.dart';

class ContactsView extends StatefulWidget {
    @override
    _ContactsState createState() => _ContactsState();
}

Profile fakeProfile = Profile(
    conversations: [],
    contacts: [],
    name: 'Ludwig Frank',
    id: '99099',
    phoneNumber: '000'
);

class _ContactsState extends State<ContactsView> {

    Widget _buildContactItem(Contact contact, BuildContext context) {
        return GestureDetector(
            onTap: () => Navigator.pushNamed(context, '/chat', arguments: Conversation(participants: <Profile>[fakeProfile], id: '939', messages: [])),
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
        var profiles = Provider.of<QuerySnapshot>(context);

        print(profiles.documents[0].documentID);
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

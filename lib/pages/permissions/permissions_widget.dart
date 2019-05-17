import 'package:flutter/material.dart';
import 'dart:async';
import 'package:latter/pages/contacts/widgets/widgets.dart';
import 'package:latter/styles/colors.dart';
import 'package:latter/styles/text.dart';
import 'package:latter/widgets/la_switch/la_switch_widget.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:contacts_service/contacts_service.dart';

import 'permissions_models.dart';

class PermissionsPage extends StatefulWidget {
    @override
    _PermissionsPageState createState() => _PermissionsPageState();
}

class _PermissionsPageState extends State<PermissionsPage> {
    List<Permission> requiredPermissions = [
        Permission(
            title: 'Calendar',
            description: 'Let your friends know when you are doing great stuff. No distraction, full focus.',
            permission: PermissionGroup.calendar
        ),
        Permission(
            title: 'Contacts',
            description: 'Write lätters and invite your friends to events.',
            permission: PermissionGroup.contacts
        ),
        Permission(
            title: 'Microphone',
            description: 'Well, because writing with one hands sucks sometimes.',
            permission: PermissionGroup.microphone
        ),
        Permission(
            title: 'Photos',
            description: 'Share your achivements and goals.',
            permission: PermissionGroup.photos
        ),
    ];

    List<Permission> get notGrantedPermissions {
        return requiredPermissions.where((permission) => permission.status != PermissionStatus.granted).toList();
    }

    @override
    void initState() {
        _generateUpdatedPermissions(requiredPermissions)
            .then((List<Permission> permissions) {
            setState(() { requiredPermissions = List.from(permissions); });
        });
        super.initState();
    }

    Future<List<Permission>> _generateUpdatedPermissions(List<Permission> permissions) async {
        return Future.wait(permissions.map((permission) => _generateUpdatedPermission(permission)));
    }

    Future<Permission> _generateUpdatedPermission(Permission permission) async {
        return PermissionHandler().checkPermissionStatus(permission.permission)
            .then((status) {
            if (permission.status == status) return permission;

            else {
                permission.status = status;
                return permission;
            }
        });
    }

    void _askForPermissions(List<Permission> permissions) {
        List<PermissionGroup> permissionTypes = permissions.map((Permission permission) => permission.permission).toList();
        PermissionHandler().requestPermissions(permissionTypes)
            .then(_onPermissionsRequest);
    }

    void _onPermissionsRequest(Map<PermissionGroup, PermissionStatus> statuses) {
        statuses.forEach((PermissionGroup permissionType, PermissionStatus status) {
            print(status.toString());
            if (status != PermissionStatus.granted) {
                PermissionHandler().openAppSettings();
            } else {
                _updatePermissionStatus(permissionType, status);
            }
        });
    }

    _updatePermissionStatus(PermissionGroup permissionType, PermissionStatus status) {
        Permission permission = requiredPermissions.firstWhere((permission) => permission.permission == permissionType);

        setState(() {
            permission.status = status;
        });
    }

    void _onPermissionItemTap (Permission permission, bool value) {
        if (permission.checked == value) return;
        else {
            setState(() {
                permission.checked = value;
            });
        }
    }

    Widget _buildPermissionStatusItem (Permission permission) {
        Widget _buildPermissionStatusItemText () {
            String permissionStatusText = permission.status == PermissionStatus.granted
                ? ' Granted'
                : ' Denied';

            return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                    Padding(
                        padding: const EdgeInsets.only(top: 6.0),
                        child: Row(
                            children: <Widget>[
                                Text(permission.title, style: header4TextStyle),
                                // Text(permissionStatusText, style: header4TextStyle.copyWith(color: Colors.grey))
                            ],
                        )
                    ),
                    SizedBox(height: 12.0,),
                    Text(permission.description, style: body2TextStyle,)
                ],
            );
        }

        return Padding(
            padding: const EdgeInsets.only(bottom: 32.0),
            child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                    Expanded(
                        flex: 5,
                        child: _buildPermissionStatusItemText()
                    ),
                    Expanded(
                        flex: 2,
                        child: Align(
                            alignment: Alignment.centerRight,
                            child: LaSwitch(
                                onChanged: (bool value) {
                                    _onPermissionItemTap(permission, value);
                                },
                                value: permission.checked,
                                activeColor: LaColors.activeBlue,
                            ),
                        ),
                    )
                ],
            ),
        );
    }

    Widget _buildPermissionStatuses () {
        return Column(
            children: requiredPermissions.map((permission) => _buildPermissionStatusItem(permission)).toList()
        );
    }

    @override
    Widget build(BuildContext context) {
        return Scaffold(
            body: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Flex(
                    mainAxisAlignment: MainAxisAlignment.center,
                    direction: Axis.vertical,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                        _buildPermissionStatuses(),
                        SizedBox(height: 24.0,),
                        OutlineButton(
                            child: Text('Grant Permissions', style: TextStyle(fontWeight: FontWeight.w600),),
                            onPressed: () {
                                _askForPermissions(notGrantedPermissions);
                            },
                        ),
                    ],
                ),
            ),
        );
    }
}



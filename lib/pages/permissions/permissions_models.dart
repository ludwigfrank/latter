import 'package:meta/meta.dart';
import 'package:permission_handler/permission_handler.dart';

class Permission {
    String title;
    String description;
    PermissionGroup permission;
    PermissionStatus status;
    bool checked;

    Permission({
        @required this.title,
        @required this.description,
        @required this.permission,

        // Set "granted" to true to not have a splash screen while permissions are checked
        this.status = PermissionStatus.granted,

        this.checked = true
    });

    @override
    String toString() {
        return permission.toString();
    }
}

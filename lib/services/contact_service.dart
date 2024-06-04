import 'package:contacts_service/contacts_service.dart';
import 'package:permission_handler/permission_handler.dart';

class ContactService {
  Future<bool> _requestPermission() async {
    PermissionStatus status = await Permission.contacts.status;
    if (status.isGranted) {
      return true;
    } else if (status.isDenied || status.isRestricted || status.isPermanentlyDenied) {
      status = await Permission.contacts.request();
      return status.isGranted;
    }
    return false;
  }

  Future<List<Contact>> getContacts() async {
    bool isGranted = await _requestPermission();
    if (isGranted) {
      return await ContactsService.getContacts();
    }
    return [];
  }
}

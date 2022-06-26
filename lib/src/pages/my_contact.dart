import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:mycontactapplication/src/pages/add_contact.dart';
import 'package:mycontactapplication/src/pages/Contact_details.dart';

import 'package:mycontactapplication/src/utils/utility_launcher.dart';
import 'package:permission_handler/permission_handler.dart';


class MyContacts extends StatefulWidget {
const MyContacts({Key? key}) : super(key: key);

@override
_MyContactsState createState() => _MyContactsState();
}

class _MyContactsState extends State<MyContacts> {
  List<Contact> contacts = [];

  bool isLoading = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setPermission();
    //getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: Icon(
          Icons.perm_identity_rounded,
          size: 30,
          color: Colors.white,
        ),
        title: Text("${contacts.length} Contacts"),
      ),
      floatingActionButton: Container(
        height: 55.0,
        width: 55.0,
        child: FittedBox(
          child: FloatingActionButton(
            child: Icon(
              Icons.add,
              size: 35,
            ),
            backgroundColor: Colors.blueAccent,
            onPressed: (){
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => AddToContact())).then((value) => getData());
            },

          ),
        ),
      ),
      body: SafeArea(
        child: Visibility(
          visible: !isLoading,
          replacement: Center(child: CupertinoActivityIndicator()),
          child: Visibility(
            visible: !contacts.isEmpty,
            replacement: Center(
                child: Text(
                  "No contact found",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                )),
            child: ListView.separated(
                separatorBuilder: (context, pos) {
                  return Divider(
                    height: 5,
                  );
                },
                itemCount: contacts.length,
                itemBuilder: (context, pos) {
                  Contact itemcontact = contacts[pos];
                  //ContactModel contactdetail = contactmodel[pos];
                  String phone = "";
                  if (itemcontact.phones != null) {
                    phone = itemcontact.phones
                        ?.map((e) => e.value)
                        .toSet()
                        .join(",") ??
                        "";
                  }
                  return ListTile(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ContactDetails(contact: itemcontact,
                              )));
                      // callContact(itemcontact);
                    },
                    leading: CircleAvatar(
                      radius: 20,
                      child: Visibility(
                          visible: itemcontact.avatar != null,
                          replacement: CircleAvatar(child: Icon(Icons.person)),
                          child: CircleAvatar(
                              backgroundImage:
                              MemoryImage(itemcontact.avatar!))),
                    ),
                    title: Text("${itemcontact.displayName ?? "Null"}"),
                    //subtitle: Text("${phone}"),
                  );
                }),
          ),
        ),
      ),
    );
  }

  Future<void> setPermission() async {
    PermissionStatus permissionStatus = await Permission.contacts.request();
    if (permissionStatus.isGranted) {
// Get all contacts on device
      getData();
    } else {
      setState(() {
        isLoading = false;
      });
    }
  }

  void callContact(Contact itemcontact) {
    if (itemcontact.phones == null) {
      return;
    } else if (itemcontact.phones!.isEmpty) {
      return;
    } else if (itemcontact.phones?.length == 1) {
      LauncherUtility.makeCall(
          "${itemcontact.phones!.first.value}"); // phones! = not null
    } else {
      showPhoneSelectorDialog(itemcontact.phones!);
    }
  }

  void showPhoneSelectorDialog(List<Item> phones) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("Choose the number"),
            content: Container(
              height: 500,
              width: 500,
              child: ListView.builder(
                  itemCount: phones.length,
                  shrinkWrap: true,
                  itemBuilder: (context, pos) {
                    return ListTile(
                        onTap: () {
                          LauncherUtility.makeCall("${phones[pos].value}");
                        },
                        title: Text("${phones[pos].value}"));
                  }),
            ),
          );
        });
  }

  Future<void> getData() async {
    List<Contact> contactTemp = await ContactsService.getContacts();
    setState(() {
      contacts = contactTemp;
      isLoading = false;
    });
  }
}



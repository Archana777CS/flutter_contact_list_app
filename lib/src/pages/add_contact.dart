import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mycontactapplication/src/pages/my_contact.dart';
import 'package:mycontactapplication/src/utilities/form_validation_utility.dart';

class AddToContact extends StatefulWidget {
  const AddToContact({Key? key}) : super(key: key);

  @override
  State<AddToContact> createState() => _AddToContactState();
}

class _AddToContactState extends State<AddToContact> {
  List<Contact> contacts = [];
  final GlobalKey<FormState> _formKey = GlobalKey();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _bdayController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            backgroundColor: Colors.white,
            body: Center(
              child: Form(
                key: _formKey,
                child: Column(children: [
                  const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  "Add to contact",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 25,
                      fontWeight: FontWeight.w600),
                ),
                  ),
                  Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                    keyboardType: TextInputType.name,
                    controller: _nameController,
                    validator: (name) {
                      return FormValidationUtility.validateName(name ?? "");
                    },
                    decoration: InputDecoration(
                      // hintStyle: TextStyle(fontSize: 17),
                      labelText: 'Name',
                      suffixIcon: const Icon(Icons.person_rounded),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                      focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.blue),
                          borderRadius: BorderRadius.circular(10.0)),
                      contentPadding: const EdgeInsets.all(20),
                    )),
                  ),
                  Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: _emailController,
                  validator: (val) {
                    return FormValidationUtility.validateEmail(val ?? "");
                  },
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    labelText: "Email",
                    suffixIcon: const Icon(Icons.email),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                    focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.blue),
                        borderRadius: BorderRadius.circular(10.0)),
                  ),
                ),
                  ),
                  Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                    keyboardType: TextInputType.phone,
                    controller: _phoneController,
                    validator: (mobile) {
                      return FormValidationUtility.validatePhone(
                          mobile ?? "");
                    },
                    decoration: InputDecoration(
                      labelText: 'Mobile',
                      suffixIcon: const Icon(Icons.phone_android),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                      focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.blue),
                          borderRadius: BorderRadius.circular(10.0)),
                      contentPadding: const EdgeInsets.all(20),
                    )),
                  ),
                  Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  keyboardType: TextInputType.datetime,
                  controller: _bdayController,
                  decoration: InputDecoration(
                    labelText: 'Birthday',
                    suffixIcon: const Icon(Icons.cake),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                    focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.blue),
                        borderRadius: BorderRadius.circular(10.0)),
                    contentPadding: const EdgeInsets.all(20),
                  ),
                  onTap: () {
                    showDatePicker(
                            context: context,
                            initialDate: DateTime(1990),
                            firstDate: DateTime(1960),
                            lastDate: DateTime.now())
                        .then((value) {
                      if (value != null) {
                        _bdayController.text = value.toString();
                        if (kDebugMode) {
                          print(_bdayController.text);
                        }
                      }
                    });
                  },
                ),
                  ),
                  ListTile(
                title: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      primary: Colors.blue, onPrimary: Colors.white),

                  child: const Text("Save"),
                  onPressed: () {
                    if (!(_formKey.currentState?.validate() ?? false)) {
                      return;
                    } else {
                      ContactsService.addContact(Contact(
                          givenName: _nameController.text,
                          phones: [Item(value: _phoneController.text)],
                          emails: [Item(value: _emailController.text)],
                          birthday: getBirthday()));

                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => MyContacts()));
                    }
                  },
                  //},
                ),
                  )
                ]),
              ),
            )));
  }

  DateTime? getBirthday() {
    if (_bdayController.text.trim().isEmpty) return null;
    DateTime birthDayDate = DateTime.parse(_bdayController.text);
    return birthDayDate;
  }
}



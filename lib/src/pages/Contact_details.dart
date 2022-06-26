import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:mycontactapplication/src/utils/utility_launcher.dart';
import 'package:mycontactapplication/src/utilities/form_validation_utility.dart';

class ContactDetails extends StatefulWidget {
  final Contact contact;

  const ContactDetails({required this.contact, Key? key}) : super(key: key);

  @override
  State<ContactDetails> createState() => _ContactDetailsState();
}

class _ContactDetailsState extends State<ContactDetails> {
  String phone = "";
  DateTime dt = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "${widget.contact.displayName}",
            style: const TextStyle(
                color: Colors.white, fontSize: 25, fontWeight: FontWeight.w400),
          ),
        ),
        body: SafeArea(
            child: Column(children: [
          Padding(
            padding: const EdgeInsets.only(left: 12.0, top: 30),
            child: Visibility(
                visible: widget.contact.avatar != null,
                replacement:
                    CircleAvatar(child: Text(widget.contact.initials())),
                child: CircleAvatar(
                  backgroundImage: MemoryImage(widget.contact.avatar!),
                  radius: 70,
                )),
          ),
          Card(
            child: ListTile(
              title: Visibility(
                  visible: widget.contact.phones != null,
                  replacement: const Text("No contact added"),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 0.0, left: 0.0),
                    child: Text(
                        widget.contact.phones
                                ?.map((e) => e.value)
                                .toSet()
                                .join(", ") ??
                            "",
                        textAlign: TextAlign.left,
                        style: const TextStyle(
                            fontSize: 17, fontWeight: FontWeight.w500)),
                  )),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Card(
                child: InkWell(
                    child: Container(
                      height: 35,
                      width: 35,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color: Colors.green),
                      child: const Icon(
                        Icons.phone,
                        color: Colors.white,
                        size: 30,
                      ),
                    ),
                    onTap: () {
                      callContact();
                    }),
                color: Colors.green,
              ),
              Card(
                child: InkWell(
                    child: Container(
                      height: 35,
                      width: 35,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color: Colors.orange),
                      child: const Icon(
                        Icons.message,
                        color: Colors.white,
                        size: 30,
                      ),
                    ),
                    onTap: () {
                      smsContact();
                    }),
                color: Colors.orangeAccent,
              ),
            ],
          ),
          Card(
            child: ListTile(
              title: Row(
                children: [
                  const Icon(
                    Icons.email,
                    color: Colors.lightBlue,
                    size: 30,
                  ),
                  Visibility(
                      // ignore: unnecessary_null_comparison
                      visible: widget.contact.emails!.isNotEmpty,
                      replacement: const Text("No Email added"),
                      child: Row(
                        children: [
                          Text(
                              widget.contact.emails
                                  ?.map((e) => e.value)
                                  .toSet()
                                  .join(", ") ??
                                  "",
                              textAlign: TextAlign.left,
                              style: const TextStyle(
                                  fontSize: 17, fontWeight: FontWeight.w500)),
                        ],
                      )),
                ],
              ),
              onTap: () {
                emailContact();
              },
            ),
          ),
          Card(
            child: Visibility(
                visible: widget.contact.birthday != null,
                replacement: const Text(
                  "Birthday not added yet",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w300),
                ),
                child: Column(
                  children: [
                    const Icon(
                      Icons.cake,
                      color: Colors.pink,
                    ),
                    const Text(
                      "BirthDate:",
                      style: const TextStyle(
                          fontSize: 20,
                          color: Colors.lightBlue,
                          fontWeight: FontWeight.w300),
                    ),
                    Text("${widget.contact.birthday}",
                        style: const TextStyle(
                            fontSize: 20,
                            color: Colors.blueGrey,
                            fontWeight: FontWeight.w500)),
                  ],
                )),
          ),
          const SizedBox(
            height: 10,
          ),
          Visibility(
            visible: widget.contact.birthday != null,
            child: Visibility(
                visible: !FormValidationUtility.checkForBirthday(
                    widget.contact.birthday),
                replacement: ListTile(
                  leading: const Icon(Icons.notifications,
                      size: 30, color: Colors.teal),
                  title: Text(
                      "Today is  ${widget.contact.displayName} 's birthday.\nSend wishes...",
                      style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.normal,
                          fontStyle: FontStyle.italic)),
                  trailing: IconButton(
                      onPressed: () {
                        smsContact();
                      },
                      icon: const Icon(
                        Icons.card_giftcard,
                        size: 30,
                        color: Colors.pinkAccent,
                      )),
                ),
                child: ListTile(
                  leading: const Icon(
                    Icons.date_range_rounded,
                    color: Colors.pink,
                  ),
                  title: Text(
                      "Just ${getBirthDateCount()}  days until ${widget.contact.displayName}'s birthday",
                      style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.normal,
                          fontStyle: FontStyle.italic)),
                )),
          ),
        ])));
  }

  void callContact() {
    if (widget.contact.phones == null) {
      return;
    } else if (widget.contact.phones!.isEmpty) {
    } else if (widget.contact.phones?.length == 1) {
      LauncherUtility.makeCall(
          "${widget.contact.phones!.first.value}"); // phones! = not null
    } else {
      showPhoneSelectorDialog(widget.contact.phones!);
    }
  }

  void smsContact() {
    if (widget.contact.phones == null) {
      return;
    } else if (widget.contact.phones!.isEmpty) {
    } else if (widget.contact.phones?.length == 1) {
      LauncherUtility.sendMessage(
          "${widget.contact.phones!.first.value}"); // phones! = not null
    } else {
      showSmsSelectorDialog(widget.contact.phones!);
    }
  }

  void emailContact() {
    if (widget.contact.emails == null) {
      return;
    } else if (widget.contact.emails!.isEmpty) {
    } else if (widget.contact.emails?.length == 1) {
      LauncherUtility.sendEmail(
          "${widget.contact.emails!.first.value}"); // phones! = not null
    } else {
      showEmailSelectorDialog(widget.contact.emails!);
    }
  }

  void showPhoneSelectorDialog(List<Item> phones) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("Choose the number"),
            content: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24),
                  shape: BoxShape.rectangle),
              height: 100,
              width: 200,
              child: ListView.builder(
                  itemCount: phones.length,
                  shrinkWrap: true,
                  itemBuilder: (context, pos) {
                    return ListTile(
                        onTap: () {
                          LauncherUtility.makeCall("${phones[pos].value}");
                        },
                        leading: const Icon(
                          Icons.phone,
                          color: Colors.green,
                          size: 23,
                        ),
                        title: Text("${phones[pos].value}"));
                  }),
            ),
          );
        });
  }

  String getBirthDateCount() {
    if (widget.contact.birthday == null) return "";
    DateTime now = DateTime.now();
    DateTime currentYearBday = DateTime(
        now.year, widget.contact.birthday!.month, widget.contact.birthday!.day);
    if (currentYearBday.isBefore(now)) {
      currentYearBday = DateTime(now.year + 1, widget.contact.birthday!.month,
          widget.contact.birthday!.day);
    }
    var differenceDate = currentYearBday.difference(now).inDays;
    return differenceDate.toString();
  }

  void showSmsSelectorDialog(List<Item> phones) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("Choose the number"),
            content: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24),
                  shape: BoxShape.rectangle),
              height: 100,
              width: 200,
              child: ListView.builder(
                  itemCount: phones.length,
                  shrinkWrap: true,
                  itemBuilder: (context, pos) {
                    return ListTile(
                        onTap: () {
                          LauncherUtility.sendMessage("${phones[pos].value}");
                        },
                        leading: const Icon(
                          Icons.message,
                          color: Colors.orange,
                          size: 23,
                        ),
                        title: Text("${phones[pos].value}"));
                  }),
            ),
          );
        });
  }

  void showEmailSelectorDialog(List<Item> email) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("Choose the mailid"),
            content: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24),
                  shape: BoxShape.rectangle),
              height: 100,
              width: 200,
              child: ListView.builder(
                  itemCount: email.length,
                  shrinkWrap: true,
                  itemBuilder: (context, pos) {
                    return ListTile(
                        onTap: () {
                          LauncherUtility.sendEmail("${email[pos].value}");
                        },
                        leading: Icon(
                          Icons.email,
                          color: Colors.red.shade300,
                          size: 23,
                        ),
                        title: Text("${email[pos].value}"));
                  }),
            ),
          );
        });
  }
}

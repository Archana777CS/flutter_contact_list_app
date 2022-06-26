import 'package:flutter/material.dart';
import 'package:mycontactapplication/src/pages/my_contact.dart';
class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title:"ContactApp",debugShowCheckedModeBanner: false,
      theme: ThemeData(primaryColor: Colors.blue,
      ),
      home:const MyContacts(),
    );
  }
}

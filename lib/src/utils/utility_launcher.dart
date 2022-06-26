import 'package:url_launcher/url_launcher.dart';

class LauncherUtility {
  static Future<void> makeCall(String phoneNo) async {
    await launchUrl(Uri.parse("tel:$phoneNo"));
  }

  static Future<void> sendMessage(String phoneNo) async {
    await launchUrl(Uri.parse("sms:$phoneNo"));
  }

  static Future<void> sendEmail(String emailid) async {
    final Uri params = Uri(
      scheme: 'mailto',
      path: emailid,
      query: 'subject=Subject &body=Message', //add subject and body here
    );

    var url = params.toString();

    if (await canLaunch(url)) {

      await launch(url);
    } else {
      throw 'Could not launch $url';
    }

  }

}

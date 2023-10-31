import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class knowledgeScreenController extends GetxController{

  List phoneNumbers = ["9820466726", "9152987821"];

  Future<void> makePhoneCall(int index) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumbers[index],
    );
    await launchUrl(launchUri);
  }

}
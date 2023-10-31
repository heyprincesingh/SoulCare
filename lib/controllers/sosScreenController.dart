// ignore_for_file: body_might_complete_normally_catch_error

import 'package:flutter/material.dart';
import 'package:flutter_sms/flutter_sms.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

class sosScreenController extends GetxController {
  TextEditingController textcontroller = TextEditingController();
  RxList<String> contactList = <String>[].obs;

  @override
  void onInit() {
    fetchData();
    super.onInit();
  }

  Future fetchData() async {
    final prefs = await SharedPreferences.getInstance();
    final sosList = prefs.getStringList('sosContacts') ?? [];
    contactList.assignAll(sosList);
  }

  Future storeData() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setStringList('sosContacts', contactList);
  }

  void sendSos() async {
    var status = await Permission.sms.status;
    if (status.isDenied) {
      await Permission.sms.request();
    }
    String message = "Hey! I need you, please call me back";

    if(contactList.length>0){
      String _result =
      await sendSMS(message: message, recipients: contactList, sendDirect: true)
          .catchError((onError) {
        print(onError);
      });
      print(_result);
    }else{
      Get.snackbar("Error", "No cantacts saved!",backgroundColor: Colors.white54);
    }
  }
}

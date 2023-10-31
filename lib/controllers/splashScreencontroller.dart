import 'package:get/get.dart';
import 'package:soulcare/views/homeScreen/homeScreen.dart';

class splashScreencontroller extends GetxController {
  String appName = "SoulCare";

  @override
  void onInit() {
    splashScreenLoader();
    super.onInit();
  }

  void splashScreenLoader() async {
    await Future.delayed(
        const Duration(seconds: 3), () => Get.offAll(homeScreen()));
  }
}

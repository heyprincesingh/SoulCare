import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class quizScreenController extends GetxController {
  RxList assessmentAnswer = [-1, -1, -1, -1, -1, -1, -1, -1, -1, -1].obs;
  RxInt quizScore = 0.obs;

  Future<void> storeData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('quizScore', quizScore.value);
  }
}

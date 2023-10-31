import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:soulcare/controllers/homeScreenController.dart';
import 'package:soulcare/models/color.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:soulcare/models/questions.dart';
import 'package:soulcare/controllers/quizScreenController.dart';
import 'package:soulcare/views/homeScreen/homeScreen.dart';

class quizScreen extends StatelessWidget {
  const quizScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(quizScreenController());
    final ScoreController = Get.find<homeScreenController>();
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        backgroundColor: themeColor,
        title: Text(
          "Assessment",
          style: GoogleFonts.raleway(
              fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Visibility(
                visible: ScoreController.quizScore.value > 0,
                child: Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Text("You are currently at level " +
                      (ScoreController.quizScore.value ~/ 3).toString() + " of distress!",
                      style: GoogleFonts.raleway(
                        fontSize: 18,
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                  ),
                ),
            ),
            ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: 10,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: Colors.white24,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(15),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            questions[index],
                            style: GoogleFonts.raleway(
                              fontSize: 18,
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(height: 20),
                          ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: 4,
                            itemBuilder: (c, i) {
                              return GestureDetector(
                                behavior: HitTestBehavior.opaque,
                                onTap: () {
                                  if (controller.assessmentAnswer[index] !=
                                      -1) {
                                    controller.quizScore -=
                                        controller.assessmentAnswer[index];
                                    controller.assessmentAnswer[index] = i;
                                    controller.quizScore += i;
                                  } else {
                                    controller.assessmentAnswer[index] = i;
                                    controller.quizScore += i;
                                  }
                                },
                                child: Padding(
                                  padding:
                                      const EdgeInsets.only(top: 3, bottom: 3),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Obx(() => Icon(
                                            controller.assessmentAnswer[
                                                        index] ==
                                                    i
                                                ? Icons.check_circle_rounded
                                                : Icons.circle_outlined,
                                            color: Colors.white,
                                          )),
                                      const SizedBox(width: 10),
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width -
                                                100,
                                        child: Text(
                                          answers[index][i],
                                          overflow: TextOverflow.visible,
                                          style: GoogleFonts.raleway(
                                            fontSize: 18,
                                            color: Colors.white,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              );
                            },
                          )
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
            Padding(
              padding: const EdgeInsets.all(15),
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: CupertinoButton(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white70,
                  onPressed: () {
                    controller.assessmentAnswer.contains(-1)
                        ? Get.snackbar(
                      "Error",
                      "Please answer all the questions!",
                      backgroundColor: Colors.white,
                    )
                        : Get.dialog(
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 40),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                  color: bgColor,
                                  width: 0.5,
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Material(
                                  child: Column(
                                    children: [
                                      const SizedBox(height: 10),
                                      const Text(
                                        "Data Submitted Successfully!",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 18,
                                        ),
                                      ),
                                      const SizedBox(height: 15),
                                      const Text(
                                        "We'll provide you more personalized content according to your preference.",
                                        textAlign: TextAlign.center,
                                      ),
                                      const SizedBox(height: 20),
                                      SizedBox(
                                        height: 40,
                                        width: 200,
                                        child: ElevatedButton(
                                          child: const Text(
                                            'Proceed',
                                          ),
                                          style: ElevatedButton.styleFrom(
                                            minimumSize: const Size(0, 45),
                                            primary: themeColor,
                                            onPrimary: const Color(0xFFFFFFFF),
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(8),
                                            ),
                                          ),
                                          onPressed: () {
                                            controller.storeData();
                                            Get.offAll(homeScreen());
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                  child: DefaultTextStyle(
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                    child: Text(
                      "Submit",
                      style: GoogleFonts.raleway(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

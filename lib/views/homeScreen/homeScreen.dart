import 'dart:ffi';
import 'dart:math';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:soulcare/controllers/quizScreenController.dart';
import 'package:soulcare/models/color.dart';
import 'package:soulcare/models/quotes.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:soulcare/views/motivationScreen/motivationScreen.dart';
import 'package:soulcare/views/quizScreen/quizScreen.dart';
import 'package:soulcare/controllers/homeScreenController.dart';
import 'package:soulcare/views/knowledgeScreen/knowledgeScreen.dart';
import 'package:soulcare/views/sosScreen/sosScreen.dart';

class homeScreen extends StatelessWidget {
  const homeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Random random = Random();
    final controller = Get.put(homeScreenController());
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        backgroundColor: themeColor,
        title: Text(
          "SoulCare",
          style: GoogleFonts.raleway(
              fontWeight: FontWeight.bold, color: Colors.white),
        ),
        actions: [
          GestureDetector(
            onTap: () => Get.to(sosScreen()),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(0, 10, 15, 10),
              child: Container(
                decoration: BoxDecoration(
                  color: bgColor,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Icon(
                    Icons.sos,
                    size: 20,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Container(
          child: Column(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                // height: MediaQuery.of(context).size.width / 2.5,
                decoration: BoxDecoration(
                  color: Colors.white38,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(width: 2, color: Colors.white38),
                ),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(30),
                    child: Text(
                      quotes[random.nextInt(quotes.length)],
                      textAlign: TextAlign.center,
                      style: GoogleFonts.raleway(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ),
              const Divider(
                  color: Colors.white,
                  thickness: 1,
                  indent: 10,
                  endIndent: 10,
                  height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () => Get.to(knowledgeScreen()),
                    child: Container(
                      height: MediaQuery.of(context).size.width / 3.5,
                      width: MediaQuery.of(context).size.width / 3.5,
                      decoration: BoxDecoration(
                        color: Colors.white38,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          width: 2,
                          color: Colors.white38,
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(5),
                            child: Image.asset("assets/suicideLogo.png",
                                color: Colors.white,
                                fit: BoxFit.contain,
                                height: MediaQuery.of(context).size.width / 8,
                                width: MediaQuery.of(context).size.width / 8),
                          ),
                          Text(
                            "Knowledge",
                            style: GoogleFonts.raleway(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              // fontSize: 20,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () => Get.to(const quizScreen()),
                    child: Container(
                      height: MediaQuery.of(context).size.width / 3.5,
                      width: MediaQuery.of(context).size.width / 3.5,
                      decoration: BoxDecoration(
                        color: Colors.white38,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          width: 2,
                          color: Colors.white38,
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(5),
                            child: Image.asset("assets/quizIcon.png",
                                color: Colors.white,
                                fit: BoxFit.contain,
                                height: MediaQuery.of(context).size.width / 8,
                                width: MediaQuery.of(context).size.width / 8),
                          ),
                          Text(
                            "Assessment",
                            style: GoogleFonts.raleway(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              // fontSize: 20,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () => Get.to(const youtubeVideoScreen()),
                    child: Container(
                      height: MediaQuery.of(context).size.width / 3.5,
                      width: MediaQuery.of(context).size.width / 3.5,
                      decoration: BoxDecoration(
                        color: Colors.white38,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          width: 2,
                          color: Colors.white38,
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(5),
                            child: Image.asset("assets/motivation.png",
                                color: Colors.white,
                                fit: BoxFit.contain,
                                height: MediaQuery.of(context).size.width / 8,
                                width: MediaQuery.of(context).size.width / 8),
                          ),
                          Text(
                            "Motivations",
                            style: GoogleFonts.raleway(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              // fontSize: 20,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const Divider(
                color: Colors.white,
                thickness: 1,
                indent: 10,
                endIndent: 10,
                height: 30,
              ),
              Expanded(
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: Colors.white38,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(width: 2, color: Colors.white38),
                  ),
                  child: Obx(
                    () => controller.randomIndexes.isEmpty
                        ? controller.quizScore.value == 0
                            ? Align(
                                alignment: Alignment.center,
                                child: Padding(
                                  padding: const EdgeInsets.all(20),
                                  child: Text(
                                    "You need to first complete the assessment to start daily activities!",
                                    style: GoogleFonts.raleway(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 18,
                                      height: 1.5
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              )
                            : Align(
                                alignment: Alignment.center,
                                child: Text(
                                  "You've completed today's activities! 🎉",
                                  style: GoogleFonts.raleway(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 18,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              )
                        : ListView.builder(
                            itemCount: controller.randomIndexes.length + 1,
                            itemBuilder: (context, index) {
                              return index == 0
                                  ? Container(
                                      decoration: const BoxDecoration(
                                        color: themeColor,
                                        borderRadius: BorderRadius.only(
                                          topRight: Radius.circular(10),
                                          topLeft: Radius.circular(10),
                                        ),
                                      ),
                                      height: 40,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          const Padding(
                                            padding: EdgeInsets.only(
                                                left: 15, right: 15),
                                            child: Icon(
                                              CupertinoIcons.calendar_today,
                                              color: Colors.white,
                                            ),
                                          ),
                                          Text(
                                            "Activities Todo",
                                            style: GoogleFonts.raleway(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20,
                                            ),
                                          ),
                                          Spacer(),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                right: 15),
                                            child: Text(
                                              "Swipe left to dismiss",
                                              style: GoogleFonts.raleway(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 10,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  : Slidable(
                                      key: ValueKey(0),
                                      closeOnScroll: true,
                                      endActionPane: ActionPane(
                                        extentRatio: 1 / 5,
                                        motion: ScrollMotion(),
                                        children: [
                                          SlidableAction(
                                            onPressed: (context) => controller
                                                .removeFromList(index - 1),
                                            backgroundColor: Colors.green,
                                            foregroundColor: Colors.white,
                                            icon: Icons.check_box,
                                            label: 'Done',
                                          ),
                                        ],
                                      ),
                                      child: Container(
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                              width: 0.5,
                                              color: Colors.white54),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(20),
                                          child: Text(
                                            controller.activities[controller.quizScore.value ~/6][controller
                                                .randomIndexes[index - 1]],
                                            style: GoogleFonts.raleway(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w400,
                                              fontSize: 16,
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                            },
                          ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

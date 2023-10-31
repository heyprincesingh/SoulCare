import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:soulcare/controllers/sosScreenController.dart';
import 'package:soulcare/models/color.dart';

class sosScreen extends StatelessWidget {
  const sosScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(sosScreenController());
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        backgroundColor: themeColor,
        title: Text(
          "SoS Details",
          style: GoogleFonts.raleway(
              fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
      body: Container(
        child: Column(
          children: [
            const SizedBox(height: 30),
            GestureDetector(
              onTap: () => controller.sendSos(),
              child: const CircleAvatar(
                backgroundColor: Colors.red,
                radius: 50,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Click",
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                    Text(
                      "SOS",
                      style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, top: 40),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Save SoS Numbers",
                  style: GoogleFonts.raleway(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: Colors.white),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15),
              child: Container(
                height: 50,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: const Color(0xffd9d9d9), width: 1),
                  borderRadius: const BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 14, right: 14),
                    child: TextFormField(
                      controller: controller.textcontroller,
                      cursorColor: Colors.black,
                      maxLines: 1,
                      minLines: 1,
                      maxLength: 13,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        hintText: "+917309233501",
                        hintStyle: TextStyle(
                          fontWeight: FontWeight.w300,
                          fontSize: 20,
                          color: Color(0xffbfbfbf),
                        ),
                        counterText: "",
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 50,
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateColor.resolveWith(
                    (states) => themeColor,
                  ),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                ),
                onPressed: () {
                  FocusManager.instance.primaryFocus?.unfocus();
                  if (!controller.contactList.contains(controller.textcontroller.text)) {
                    if(controller.contactList.length < 5){
                      controller.contactList.add(controller.textcontroller.text);
                      controller.storeData();
                    }else{
                      Get.snackbar("Maximum limit reached!", "Maximum 5 Contacts can be saved",backgroundColor: Colors.white54);
                    }
                  }
                },
                child: Text(
                  "Save Contact",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w400,
                      fontSize: 16),
                ),
              ),
            ),
            SizedBox(height: 30),
            Expanded(
              child: Obx(
                () => ListView.builder(
                    itemCount: controller.contactList.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.fromLTRB(25, 5, 25, 5),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white38,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(width: 2, color: Colors.white38),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  controller.contactList[index],
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    controller.contactList.removeAt(index);
                                  },
                                  child: Icon(
                                    Icons.delete_outline_rounded,
                                    color: Colors.white,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    }),
              ),
            )
          ],
        ),
      ),
    );
  }
}

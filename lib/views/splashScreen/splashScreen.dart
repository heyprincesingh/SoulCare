import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:soulcare/models/color.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:soulcare/controllers/splashScreencontroller.dart';

class splashScreen extends StatelessWidget {
  const splashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(splashScreencontroller());
    return Scaffold(
      backgroundColor: bgColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset("assets/logo.png",height: 150,width: 150),
            Text(
              controller.appName,
              style: GoogleFonts.raleway(
                fontSize: 35,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:soulcare/controllers/knowledgeScreenController.dart';
import 'package:soulcare/models/color.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:webview_flutter/webview_flutter.dart';

class knowledgeScreen extends StatelessWidget {
  const knowledgeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final webController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // Update loading bar.
          },
          onPageStarted: (String url) {},
          onPageFinished: (String url) {},
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.startsWith(
                'https://my.clevelandclinic.org/health/articles/11352-recognizing-suicidal-behavior')) {
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(
          'https://my.clevelandclinic.org/health/articles/11352-recognizing-suicidal-behavior'));

    final controller = Get.put(knowledgeScreenController());
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        backgroundColor: themeColor,
        title: Text(
          "SoulCare",
          style: GoogleFonts.raleway(
              fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
      body: Container(
        width: MediaQuery
            .of(context)
            .size
            .width,
        height: MediaQuery
            .of(context)
            .size
            .height,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 40,
            ),
            Text(
              "HELPLINE NUMBER",
              style: GoogleFonts.raleway(
                fontSize: 25,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              height: 80,
              width: MediaQuery.of(context).size.width,
              child: ListView.builder(
                  itemCount: controller.phoneNumbers.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: ()=> controller.makePhoneCall(index),
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.call,color: Colors.white,),
                            SizedBox(width: 15),
                            Text(
                              controller.phoneNumbers[index],
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
            ),
            const SizedBox(
              height: 30,
            ),
            Text("Click to call(24/7)",style: TextStyle(color: Colors.white,fontWeight: FontWeight.w600)),
            Expanded(
              child: Container(
                width: MediaQuery
                    .of(context)
                    .size
                    .width,
                decoration: BoxDecoration(
                  color: Colors.white38,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(width: 2, color: Colors.white38),
                ),
                child: WebViewWidget(
                  controller: webController,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

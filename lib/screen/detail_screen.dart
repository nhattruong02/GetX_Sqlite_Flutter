import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';
class Detail extends StatefulWidget {
  const Detail({super.key});

  @override
  State<Detail> createState() => _DetailState();
}

class _DetailState extends State<Detail> {
  @override
  Widget build(BuildContext context) {
    String name = Get.arguments.toString();
    WebViewController controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.disabled)
      ..canGoBack(

      )
    ..loadRequest(Uri.parse("https://www.google.com/"));

    return Scaffold(
        appBar: AppBar(
            title: Text("$name")),
        body: WebViewWidget(
            controller: controller)
        );
  }
}

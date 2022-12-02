import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:webview_flutter/webview_flutter.dart';

class DetailAritcle extends StatefulWidget {
  final String id;
  const DetailAritcle({required this.id, Key? key}) : super(key: key);

  @override
  State<DetailAritcle> createState() => _DetailAritcleState();
}

class _DetailAritcleState extends State<DetailAritcle> {
  late WebViewController controller;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          if (await controller.canGoBack()) {
            controller.goBack();
            //stay on app
            return false;
          } else {
            return true;
          }
        },
        child: Scaffold(
          appBar: AppBar(
            title: const Text("Article"),
          ),
          body: WebView(
            initialUrl:
                'http://172.20.10.2/agrii-ku/article/mobile/${widget.id}',
            javascriptMode: JavascriptMode.unrestricted,
            onWebViewCreated: (controller) {
              this.controller = controller;
            },
            // ignore: prefer_collection_literals
            gestureRecognizers: Set()
              ..add(Factory<VerticalDragGestureRecognizer>(
                  () => VerticalDragGestureRecognizer())),
          ),
        ));
  }
}

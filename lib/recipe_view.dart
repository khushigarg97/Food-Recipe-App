import 'dart:async';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
class RecipeView extends StatefulWidget {

  String url;
  RecipeView(this.url);

  @override
  State<RecipeView> createState() => _RecipeViewState();
}

class _RecipeViewState extends State<RecipeView> {

  late final WebViewController controller;
  late String finalUrl;

  @override
  void initState() {
    if(widget.url.toString().contains("http://")){
      finalUrl = widget.url.toString().replaceAll("http://","https://");
    }
    else{
      finalUrl = widget.url;
    }
    super.initState();
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(
        Uri.parse(finalUrl),
      );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Food Mania"),
        backgroundColor : Color(0xff071938),
      ),
      body: Container(
        child: WebViewWidget(controller: controller),

      ),
        );
  }
}


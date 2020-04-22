import 'package:flutter/material.dart';

import 'dart:convert';
import 'package:news_app/Database.dart';

import 'package:webview_flutter/webview_flutter.dart';
/*
class DetailScreen extends StatelessWidget {
  // Declare a field that holds the Todo.
  final String webview_url;
  DetailScreen({Key key, @required this.webview_url}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    // Use the Todo to create the UI.
    return Scaffold(
      appBar: AppBar(
        title: Text("WebView"),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: WebviewScaffold(url: webview_url,),
//        child:Text(details.description),
//        )
//        FetchData(text),
      ),
    );
  }
}*/

class WebViewContainer extends StatefulWidget {
  final String url;

  WebViewContainer({Key key, @required this.url}) : super(key: key);

//  WebViewContainer(this.url, {text});
  @override
  createState() => _WebViewContainerState(this.url);
}
class _WebViewContainerState extends State<WebViewContainer> {
  var _url;
  final _key = UniqueKey();
  _WebViewContainerState(this._url);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Column(
          children: [
            Expanded(
                child: WebView(
                    key: _key,
                    javascriptMode: JavascriptMode.unrestricted,
                    initialUrl: _url))
          ],
        ));
  }
}

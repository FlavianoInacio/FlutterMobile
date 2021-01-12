
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class GitHubPage extends StatefulWidget {
  @override
  _GitHubPageState createState() => _GitHubPageState();
}

class _GitHubPageState extends State<GitHubPage> {
  var _stackIdx = 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("GitHub"),
      ),
      body: IndexedStack(
        index: _stackIdx,
        children: [
          Column(
            children: [
              Expanded(child: WebView(
                initialUrl: "https://github.com/FlavianoInacio/flutter-edemy",
                onPageFinished: _onPageFinished ,
              ))
            ],
          ),
          Container(
            color: Colors.white,
            child: Center(
              child: CircularProgressIndicator(
              ),
            ),
          )
        ],
      ),
    );
  }

  void _onPageFinished(String url) {
    setState(() {
      _stackIdx =0;
    });
  }
}

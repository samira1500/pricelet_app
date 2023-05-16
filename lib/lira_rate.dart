import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class MyWebView extends StatefulWidget {
  final _rateController = TextEditingController();

  @override
  _MyWebViewState createState() => _MyWebViewState();
}

class _MyWebViewState extends State<MyWebView> {
  final String url = 'https://lirarate.org/';

  @override
  void initState() {
    widget._rateController.text = "";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lira Rate'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            TextFormField(
              controller: widget._rateController,
              decoration: const InputDecoration(
                labelText: 'Item Price',
              ),
            ),
            ElevatedButton(
              child: const Text('Submit'),
              onPressed: () {
                // Handle form submission
              },
            ),
          ],
        ),
      ),
    );
  }
}

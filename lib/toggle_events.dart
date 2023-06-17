import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late final WebViewController _webController;

  @override
  void initState() {
    _webController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(NavigationDelegate())
      ..addJavaScriptChannel(
        'messageHandler',
        onMessageReceived: (JavaScriptMessage message) {
          _webController.runJavaScript(
              "document.getElementById('value').innerText=\"${message.message}\"");
          if(message.message.contains("on")){
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text("success Handler ${message.message}")));
          }
        },
      )
      ..loadFlutterAsset('assets/index.html');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("test webView"),
        ),
        body: SizedBox(
          child: WebViewWidget(controller: _webController),
        ));
  }
}

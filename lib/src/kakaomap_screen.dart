import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

@deprecated
class KakaoMapScreen extends StatelessWidget {
  KakaoMapScreen({Key? key, required this.url}) : super(key: key);

  final String url;

  final GlobalKey<ScaffoldMessengerState> _scaffoldMessengerKey =
      GlobalKey<ScaffoldMessengerState>();

  final WebViewController controller = WebViewController();

  @override
  Widget build(BuildContext context) {
    controller
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(Uri.parse(url));
    _addChannels();
    return ScaffoldMessenger(
      key: _scaffoldMessengerKey,
      child: Scaffold(
          body: SafeArea(
        child: WebViewWidget(controller: controller),
      )),
    );
  }

  void _addChannels() {
    controller.addJavaScriptChannel('Toaster',
        onMessageReceived: (JavaScriptMessage message) {
      _scaffoldMessengerKey.currentState
          ?.showSnackBar(SnackBar(content: Text(message.message)));
    });
  }
}

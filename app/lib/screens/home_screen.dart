import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:app/models/user.dart';

import 'enter_username_screen.dart';

class DetailScreen extends StatefulWidget {
  const DetailScreen({Key? key, required this.user}) : super(key: key);

  final User user;

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}
class _DetailScreenState extends State<DetailScreen> {

  late InAppWebViewController _webViewController;
  String url = '.demo.freeflow.life';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Container(
            child: Column(children: <Widget>[
              Expanded(
                child: Container(
                  margin: const EdgeInsets.only(top: 50),
                  child: InAppWebView(
                    initialUrlRequest: URLRequest(url: Uri.parse(widget.user.username + url)),
                    initialOptions: InAppWebViewGroupOptions(
                        crossPlatform: InAppWebViewOptions(
                          useShouldOverrideUrlLoading: true,
                        ),
                        android: AndroidInAppWebViewOptions(supportMultipleWindows: true, thirdPartyCookiesEnabled: true),
                        ios: IOSInAppWebViewOptions(
                          
                        )),
                    onWebViewCreated: (InAppWebViewController controller) async{
                      _webViewController = controller;
                    },
                    onReceivedServerTrustAuthRequest: (controller, challenge) async {
                      print(challenge);
                      return ServerTrustAuthResponse(action: ServerTrustAuthResponseAction.PROCEED);
                    },
                    shouldOverrideUrlLoading: (controller, navigationAction) async{
                      final uri = navigationAction.request.url;
                      print('uri:' + uri.toString());
                      if(uri.toString().startsWith('threebot://login?')){
                        _launchUrl(uri);
                        return NavigationActionPolicy.CANCEL;
                      }
                      return NavigationActionPolicy.ALLOW;
                    },
                    onLoadStop: (controller, url) {},
                  ),
                ),
              ),
            ])),
      ),
    );
  }

  Future<void> _launchUrl(url) async {
    if (!await launchUrl(url)) {
      print('Could not launch app');
    }
  }
}
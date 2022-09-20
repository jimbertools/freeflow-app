import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:app/models/user.dart';

import '../helpers/hex_color.dart';

class WebviewScreen extends StatefulWidget {
  const WebviewScreen({Key? key, required this.url}) : super(key: key);

  final String url;

  @override
  State<WebviewScreen> createState() => _WebviewScreenState();
}
class _WebviewScreenState extends State<WebviewScreen> {

  late InAppWebViewController _webViewController;

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: HexColor('#ffffff'), // <-- SEE HERE
        statusBarIconBrightness:
        Brightness.dark, //<-- For Android SEE HERE (dark icons)
        statusBarBrightness:
        Brightness.light, //<-- For iOS SEE HERE (dark icons)
      ),
      child: Scaffold(
        body: Container(
            child: Column(children: <Widget>[
              Expanded(
                child: Container(
                  margin: const EdgeInsets.only(top: 30),
                  child: InAppWebView(
                    initialUrlRequest: URLRequest(url: Uri.parse(widget.url)),
                    initialOptions: InAppWebViewGroupOptions(
                        crossPlatform: InAppWebViewOptions(
                          useShouldOverrideUrlLoading: true,
                        ),
                        android: AndroidInAppWebViewOptions(supportMultipleWindows: true, thirdPartyCookiesEnabled: true, useHybridComposition: true),
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
                    onLoadError: (
                        controller,
                        url,
                        int i,
                        String s
                        ) async {
                      print('CUSTOM_HANDLER: $i, $s, $url');
                      /** instead of printing the console message i want to render a static page or display static message **/

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
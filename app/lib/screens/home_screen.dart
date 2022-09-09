import 'package:app/services/accellero_service.dart';
import 'package:app/services/authenticate_service.dart';
import 'package:app/services/location_service.dart';
import 'package:app/services/picture_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:app/models/user.dart';

class HomeScreen extends StatefulWidget {
  final User user;

  HomeScreen({required this.user});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with AutomaticKeepAliveClientMixin {
  InAppWebViewController? webView;
  InAppWebView? iaWebView;
  String? username;

  @override
  void initState() {
    username = widget.user.username;
    super.initState();
  }

  _HomeScreenState() {
    String url = '.demo.freeflow.life';
    dynamic webviewUrl = widget;
    print(webviewUrl);


    iaWebView = InAppWebView(
      initialUrlRequest:
          URLRequest(url: Uri.parse(widget.user.username + url)),
      initialOptions: InAppWebViewGroupOptions(
          crossPlatform: InAppWebViewOptions(
            useShouldOverrideUrlLoading: true,
          ),
          android: AndroidInAppWebViewOptions(supportMultipleWindows: true, thirdPartyCookiesEnabled: true),
          ios: IOSInAppWebViewOptions()),
      onWebViewCreated: (InAppWebViewController controller) async {
        webView = controller;
        addWebviewHandlers();
      },
      onReceivedServerTrustAuthRequest: (controller, challenge) async {
        print(challenge);
        return ServerTrustAuthResponse(action: ServerTrustAuthResponseAction.PROCEED);
      },
      onConsoleMessage: (InAppWebViewController controller, ConsoleMessage consoleMessage) {
        print("Console: " + consoleMessage.message);
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
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> _launchUrl(url) async {
    if (!await launchUrl(url)) {
      print('Could not launch app');
    }
  }

  clearDataHandler(List<dynamic> params) async {
    print('CLicked Clear Data');
    var injectJs = "location.reload();";
    webView?.evaluateJavascript(source: injectJs);
  }

  initializedHandler(List<dynamic> params) async {
    print('Initialized');
  }

  uploadFileHandler(List<dynamic> params) async {
    print('CLicked upload file');
    return pickImage();
  }

  locationHandler(List<dynamic> params) async {
    print('Clicked location');
    return await getPositionOfUser();
  }

  accelleroHandler(List<dynamic> params) async {
    print('Clicked accellero');
    return await getAccelleroValues();
  }

  takePictureHandler(List<dynamic> params) async {
    print('Clicked take picture');
    return await takeImage();
  }

  authenticateHandler(List<dynamic> params) async {
    print('Clicked authentication');
    return await authenticateBiometrics();
  }

  scanQrHandler(List<dynamic> params) async {
    print('Clicked QR');
    return await scanQRCode(context);
  }

  addWebviewHandlers() {
    webView?.addJavaScriptHandler(handlerName: "VUE_INITIALIZED", callback: initializedHandler);
    webView?.addJavaScriptHandler(handlerName: "RETRIEVE_LOCATION", callback: locationHandler);
    webView?.addJavaScriptHandler(handlerName: "RETRIEVE_ACCELLERO", callback: accelleroHandler);
    webView?.addJavaScriptHandler(handlerName: "TAKE_PICTURE", callback: takePictureHandler);
    webView?.addJavaScriptHandler(handlerName: "UPLOAD_FILE", callback: uploadFileHandler);
    webView?.addJavaScriptHandler(handlerName: "AUTHENTICATE", callback: authenticateHandler);
    webView?.addJavaScriptHandler(handlerName: "CLEAR_DATA", callback: clearDataHandler);
    webView?.addJavaScriptHandler(handlerName: "SCAN_QR", callback: scanQrHandler);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
        appBar: new AppBar(
          automaticallyImplyLeading: true,
          backgroundColor: Colors.blue,
          title: Text("Mobile webview isolation"),
        ),
        body: Column(
          children: <Widget>[
            Expanded(
              child: Container(child: iaWebView),
            ),
          ],
        ));
  }

  @override
  bool get wantKeepAlive => false;
}

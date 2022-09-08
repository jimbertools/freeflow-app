import 'package:app/services/accellero_service.dart';
import 'package:app/services/authenticate_service.dart';
import 'package:app/services/location_service.dart';
import 'package:app/services/picture_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

bool created = false;

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with AutomaticKeepAliveClientMixin {
  InAppWebViewController? webView;
  InAppWebView? iaWebView;

  _HomeScreenState() {
    String url = 'baerttest.digitaltwin-test.jimbertesting.be';

    iaWebView = InAppWebView(
      initialUrlRequest:
          URLRequest(url: Uri.parse(url)),
      initialOptions: InAppWebViewGroupOptions(
          crossPlatform: InAppWebViewOptions(),
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
      onLoadStop: (controller, url) {},
    );
  }

  @override
  void dispose() {
    super.dispose();
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

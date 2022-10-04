import 'package:flutter/material.dart';
import 'package:freeflow/app_config.dart';
import 'package:freeflow/helpers/shared_preference_data.dart';
import 'package:freeflow/screens/webview_screen.dart';
import 'screens/enter_username_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  String name = await getNameInStorage();


  runApp(LandingScreen());
}

class LandingScreen extends StatefulWidget with WidgetsBindingObserver {
  @override
  _LandingScreenState createState() => _LandingScreenState();

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    print(state);
    print('hallow');
  }
}

class _LandingScreenState extends State<LandingScreen> {
  String username = '';

  @override
  void initState() {
    super.initState();

    print('Coming here');
    getUsername();
  }

  getUsername() {
    getNameInStorage().then((user) {
      setState(() {
        print('this is the username');
        print(user);
        username = user;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'FreeFlow',
        debugShowCheckedModeBanner: false,
        home: username != ''
            ? WebViewScreen(url: 'https://' + username + AppConfig().freeFlowUrl())
            : EnterUsernameScreen());
  }
}

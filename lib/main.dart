import 'package:freeflow/helpers/hex_color.dart';
import 'package:freeflow/screens/enter_username_screen.dart';
import 'package:freeflow/screens/enter_environment.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';

import 'package:freeflow/screens/webview_screen.dart';
import 'package:freeflow/models/user.dart';
import 'package:freeflow/globals/globals.dart' as globals;

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mobile application isolation',
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController usernameController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  User user = new User(username: '');

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: HexColor('#dacfc7'), // <-- SEE HERE
          statusBarIconBrightness:
              Brightness.dark, //<-- For Android SEE HERE (dark icons)
          statusBarBrightness:
              Brightness.light, //<-- For iOS SEE HERE (dark icons)
        ),
        centerTitle: true,
        backgroundColor: HexColor('#dacfc7'),
        elevation: 0.0,
        title: SvgPicture.asset(
          'assets/logo.svg',
          height: 40,
        ),
      ),
      /*body: Container(
        decoration: new BoxDecoration(color: HexColor('#dacfc7')),
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Image.asset(
              'assets/freeflow_spawner.png',
              height: 300,
            ),
            Container(
              child: Column(
                children: [
                  Text(
                    "WELCOME TO YOUR",
                    style: TextStyle(
                      fontSize: 18,
                      color: HexColor('#2c3e50'),
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  Text(
                    "FREEFLOW EXPERIENCE",
                    style: TextStyle(
                        fontSize: 18,
                        color: HexColor('#2c3e50'),
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 15),
                  Text(
                      "Please use one of the options to launch your FreeFlow Experience.",
                      style: TextStyle(
                        color: HexColor('#2c3e50'),
                      ),
                      textAlign: TextAlign.center),
                ],
              ),
            ),
            Container(
              child: Column(
                children: [
                  TextButton(
                      onPressed: () async {
                        await Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => EnvironmentScreen()));
                      },
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(HexColor('#66c9bf')),
                        padding: MaterialStateProperty.all<EdgeInsets>(
                            EdgeInsets.only(top: 5, bottom: 5)),
                        minimumSize:
                            MaterialStateProperty.all<Size>(Size(300, 34.0)),
                      ),
                      child: Text('Login on your hosted environment',
                          style: TextStyle(color: Colors.white))),
                  TextButton(
                      onPressed: () async {
                        await Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => UserScreen()));
                      },
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(HexColor('#66c9bf')),
                        padding: MaterialStateProperty.all<EdgeInsets>(
                            EdgeInsets.only(top: 5, bottom: 5)),
                        minimumSize:
                            MaterialStateProperty.all<Size>(Size(300, 34.0)),
                      ),
                      child: Text('Login to Freeflow on our environment',
                          style: TextStyle(color: Colors.white))),
                ],
              ),
            ),
          ],
        ),
      ),*/
        body: Container(
            color: HexColor('#dacfc7'),
            height: double.infinity,
            alignment: Alignment.center,
            child: CustomScrollView(scrollDirection: Axis.vertical, slivers: [
              SliverFillRemaining(
                hasScrollBody: false,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Image.asset(
                      'assets/freeflow_spawner.png',
                      height: 300,
                    ),
                    Container(
                      child: Column(
                        children: [
                          Text(
                            "WELCOME TO YOUR",
                            style: TextStyle(
                              fontSize: 18,
                              color: HexColor('#2c3e50'),
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                          Text(
                            "FREEFLOW EXPERIENCE",
                            style: TextStyle(
                                fontSize: 18,
                                color: HexColor('#2c3e50'),
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 15),
                          Text(
                              "Please enter your ThreeFold Connect username in order to continue.",
                              style: TextStyle(
                                color: HexColor('#2c3e50'),
                              ),
                              textAlign: TextAlign.center),
                        ],
                      ),
                    ),
                    Container(
                      width: 300,
                      child: Column(
                        children: [
                          Form(
                            key: _formKey,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                TextFormField(
                                  controller: usernameController,
                                  decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                    isDense: true, // Added this
                                    contentPadding: EdgeInsets.all(12),
                                    filled: true,
                                    fillColor: Color.fromRGBO(227, 219, 213, 1),
                                  ),
                                  style: TextStyle(),
                                ),
                                TextButton(
                                  onPressed: () async {
                                    user.username = usernameController.text;
                                    print(user.username);
                                    await Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => WebviewScreen(
                                                url: 'https://' +
                                                    user.username +
                                                    globals.url)));
                                  },
                                  style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all(
                                        HexColor('#66c9bf')),
                                    padding:
                                    MaterialStateProperty.all<EdgeInsets>(
                                        EdgeInsets.only(top: 5, bottom: 5)),
                                    minimumSize:
                                    MaterialStateProperty.all<Size>(
                                        Size(300, 34.0)),
                                  ),
                                  child: const Text('GO!',
                                      style: TextStyle(color: Colors.white)),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ]))
    );
  }
}

import 'package:app/helpers/hex_color.dart';
import 'package:app/screens/enter_username_screen.dart';
import 'package:app/screens/enter_environment.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';

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
      body: Container(
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
      ),
    );
  }
}

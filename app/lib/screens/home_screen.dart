import 'package:app/services/accellero_service.dart';
import 'package:app/services/authenticate_service.dart';
import 'package:app/services/location_service.dart';
import 'package:app/services/picture_service.dart';
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
  @override
  Widget build(BuildContext context) {
    print(widget.user.username);
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          children: [
            SizedBox(
              height: 50,
            ),
            // Step 4 <-- SEE HERE
            Text(
              '${widget.user.username}',
              style: TextStyle(fontSize: 54),
            ),
          ],
        ),
      ),
    );
  }
}
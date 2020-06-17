import 'package:flutter/material.dart';
import 'package:peekUp/screen_Home.dart';
import 'package:peekUp/util_Style.dart';

void main() => runApp(PeekUp());

class PeekUp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Peek Up by FTC',
        home: Home(),
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: kThemeColor1,
        ));
  }
}


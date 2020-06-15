import 'dart:math';

import 'package:flutter/material.dart';
import 'package:peekUp/service_Network.dart';
import 'package:peekUp/util_Style.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<String> _pickUpLines = [];
  bool isLoading = false;

  void addToList() async {
    setState(() {
      isLoading = true;
    });
    _pickUpLines.insert(0, await NetworkHandler.getAPeekUpLine());
    setState(() {
      isLoading = false;
    });
  }

  Widget heading() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 43.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Hello!!',
            style: kGreetingTextStyle,
          ),
          SizedBox(height: 7),
          Text(
            'What pickup line will you use on the LOYL today?',
            style: kBodyTextStyle,
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }

  void initializeList() async {
    setState(() {
      isLoading = true;
    });
    _pickUpLines = await NetworkHandler.getFivePeekUpLines();
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    initializeList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kThemeColor1,
      body: Stack(
        //  alignment: Alignment.topRight,
        children: <Widget>[
          Positioned(
            right: 0,
            top: -95,
            child: Transform.rotate(angle: pi * -0.12, child: ColorBash()),
          ),
          //Main card
          Positioned(
            bottom: 0,
            top: 87,
            left: 0,
            right: 0,
            child: Container(
              decoration: BoxDecoration(
                color: kCardBackground,
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(20),
                ),
              ),
              child: ListView(
                children: <Widget>[
                  heading(),
                  if (isLoading)
                    Center(
                      child: Text(
                        '. . .',
                        style: kGreetingTextStyle,
                      ),
                    ),
                  for (int i = 0; i < _pickUpLines.length; i++)
                    LineDisplayCard(pickUpLine: _pickUpLines[i] ?? ''),
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add_circle),
          backgroundColor: kThemeColor1,
          onPressed: () {
            addToList();
          }),
    );
  }
}

class LineDisplayCard extends StatelessWidget {
  final String pickUpLine;

  const LineDisplayCard({this.pickUpLine});
  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(minHeight: 86),
      margin: EdgeInsets.fromLTRB(43, 8, 43, 8),
      padding: EdgeInsets.all(20),
      alignment: Alignment.centerLeft,
      decoration: BoxDecoration(color: Colors.white, boxShadow: [
        BoxShadow(
            offset: Offset(2, 30),
            blurRadius: 60,
            color: Color.fromRGBO(0, 0, 0, 0.07))
      ]),
      child: Text(
        pickUpLine ?? '',
        style: kBodyTextStyle,
      ),
    );
  }
}

class ColorBash extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      //   constraints: BoxConstraints.tightFor(width: 300, height: 100),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
              height: 200,
              width: 100,
              color: Color(0xFF189F99).withOpacity(0.3)),
          Container(
            height: 200,
            width: 100,
            decoration: BoxDecoration(
              color: Color(0xFF6330C6).withOpacity(0.3),
            ),
          ),
        ],
      ),
    );
  }
}

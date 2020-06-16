

import 'package:flutter/material.dart';
import 'package:peekUp/service_Network.dart';
import 'package:peekUp/util_Style.dart';

import 'util_Style.dart';



class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<String> _pickUpLines = [];
  bool isLoading = false;
  bool newEntry=false;
  var scaffold=GlobalKey<ScaffoldState>();

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
            style: kBodyTextStyle2,
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }

  void initializeList() async {
    setState(() {
      isLoading = true;
    });try{
    _pickUpLines = await NetworkHandler.getFivePeekUpLines();
      
    }catch(e){
scaffold.currentState.showSnackBar(SnackBar(content: Text('error occured')));
    }
    
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
      key:scaffold,
      backgroundColor: skyblue2,
     
      body:SafeArea(
              child: Column(
          children: <Widget>[
            heading(),
             newEntry?CircularProgressIndicator():SizedBox(),
             SizedBox(height: 5,),
            Expanded(
                        child: Container(
                padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(borderRadius:BorderRadius.vertical(top:Radius.circular(20)),
                  color: pink1
                  ),
                  child: isLoading?Center(child: CircularProgressIndicator(backgroundColor: skyblue2,),): ListView.builder(itemBuilder: (context,index){
                    return LineDisplayCard(pickUpLine:_pickUpLines[index]);
                  },itemCount: _pickUpLines.length,),
                ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
      child: Icon(Icons.add,color: Colors.black,),
          backgroundColor: skyblue2,
          onPressed: () async {
         List lines=[];
            setState(() {
              newEntry = true;
            });

        try{   lines= await NetworkHandler.getAPeekUpLine();
           scaffold.currentState.showSnackBar(SnackBar(content: Text('line added')));
             _pickUpLines.insert(0,lines[0]);
            }
            catch(e){
              scaffold.currentState.showSnackBar(SnackBar(content: Text('error occured')));
            }
            setState(() {
              newEntry = false;
            });
          }),
    );
  }
}

class LineDisplayCard extends StatelessWidget {
  final String pickUpLine;

  const LineDisplayCard({this.pickUpLine});
  @override
  Widget build(BuildContext context) {
    return Card(
      color: pink2,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal:5),
        alignment: Alignment.center,
        width: MediaQuery.of(context).size.width*1,
        height: 80,
              child: Text(
          pickUpLine ?? '',
          style: kBodyTextStyle,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}

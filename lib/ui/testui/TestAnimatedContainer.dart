

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(home: MyApp()));
}

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MyStateApp();
  }
}

class MyStateApp extends State<MyApp> {

  double _containerSize = 100;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("This is my first app"),
        titleTextStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
        backgroundColor: Colors.red,
      ),
      body: Container(alignment: Alignment.topCenter, child: Column( children: [
        ElevatedButton(onPressed: onChangeSize, child: Text("Change Size")),
        SizedBox(height: 50,),
        AnimatedContainer(duration: Duration(milliseconds: 500), height: _containerSize, width: _containerSize, color: Colors.lightBlueAccent,)
      ],),),
    );
  }

  void onChangeSize(){
    setState(() {
      _containerSize += 50;
    });
  }
}

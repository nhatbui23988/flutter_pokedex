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
  final key = GlobalKey<AnimatedListState>();
  List<int> _listItems = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("This is my first app"),
        titleTextStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
        backgroundColor: Colors.red,
      ),
      body: Container(
        padding: EdgeInsets.all(32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            ElevatedButton(onPressed: updateData, child: Text("Update data")),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(onPressed: clearData, child: Text("Clear data")),
            SizedBox(
              height: 20,
            ),
            Expanded(
              child: AnimatedList(
                key: key,
                initialItemCount: _listItems.length,
                itemBuilder: _buildItem,
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildItem(
          BuildContext context, int index, Animation<double> animation) {
    return
      SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(-1, 0),
          end: Offset(0, 0),
        ).animate(animation),
        child:Container(
          color: Colors.lightBlueAccent,
          margin: EdgeInsets.all(6),
          width: 200,
          height: 50,
          child: Text("Item ${index + 1}"),
        ),
      );
  }

  void updateData() {
    setState(() {
      var newData = (List<int>.generate(10, (index) => index));
      newData.forEach((item) { insertItem(item);});
    });
  }

  void insertItem(int itemValue){
    _listItems.insert(0, itemValue);
    key.currentState!.insertItem(0, duration: Duration(seconds: 1));
  }

  void clearData() {
    setState(() {
      _listItems.clear();
    });
  }
}


import 'package:flutter/material.dart';
import 'package:scroll_snap_list/scroll_snap_list.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DemoApp(),
      theme: ThemeData(
        brightness: Brightness.dark,
      ),
    );
  }
}

class DemoApp extends StatefulWidget {
  @override
  _DemoAppState createState() => _DemoAppState();
}

class _DemoAppState extends State<DemoApp> {

  int current=0;

  List<Data> data = [
    Data(0,
        "https://img.freepik.com/free-photo/milford-sound-new-zealand-travel-destination-concept_53876-42945.jpg"),
    Data(0,"https://watchandlearn.scholastic.com/content/dam/classroom-magazines/watchandlearn/videos/animals-and-plants/plants/what-are-plants-/What-Are-Plants.jpg"),
    Data(0,"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRc7drAdH_rr-5-s1dR37nexpspDiygTjd_eg&usqp=CAU"),
    Data(0,"https://images-na.ssl-images-amazon.com/images/I/51Gguy1yh9L.jpg"),
    Data(0,"https://nestreeo.com/wp-content/uploads/2020/03/Pyrostegia_venusta.jpg"),
    Data(0,"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQW7IvtmZDCGOoFuqg5s7QWSX7sWpf3bqZcsQ&usqp=CAU"),
    Data(0,"https://images-na.ssl-images-amazon.com/images/I/51Gguy1yh9L.jpg"),
    Data(0,"https://nestreeo.com/wp-content/uploads/2020/03/Pyrostegia_venusta.jpg"),
    Data(0,"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQW7IvtmZDCGOoFuqg5s7QWSX7sWpf3bqZcsQ&usqp=CAU"),
  ];

  Widget _buildItemList(BuildContext context, int index){
    if(index == data.length)
      return Center(
        child: CircularProgressIndicator(),
      );
    return Container(
      width: 200,
      child: Center(
        child: Container(
          height: 380,

          child: Card(
            color: Colors.white,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                (index==current)?Container(child:RaisedButton(

                  child: Icon(Icons.delete),
                  color: Colors.red,
                  onPressed: () {
                    setState(() {
                      data.removeAt(index);

                    });
                  },
                )):Container(),
                Card(
                  elevation: 10,
                  child: Container(

                    width: 200,
                    height: 250,
                    child:
                    Image.network(data[index].path,scale: 1,fit: BoxFit.cover,),
                  ),
                ),
                (index==current)?Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: 50,
                      child: RaisedButton(

                        child: Icon(Icons.add),
                        color: Colors.green,
                        onPressed: () {
                          setState(() {
                            if(data[index].count<10)
                              data[index].count=data[index].count+1;
                          });
                        },

                      ),
                    ),
                    Text("${data[index].count}",style: TextStyle(color: Colors.blue,fontSize: 16),),
                    Container(width: 50,
                      child: RaisedButton(

                        child: Icon(Icons.exposure_minus_1),
                        color: Colors.red,
                        onPressed: () {

                          setState(() {
                            if(data[index].count>0)
                              data[index].count=data[index].count-1;
                          });
                        },
                      ),
                    )
                  ],):Container()
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    current=0;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(
        backgroundColor: Colors.pinkAccent,
        title: Text('Horizontal list',style: TextStyle(color: Colors.white),),
        centerTitle: true,
      ),
      body: Container(
        child: Column(
          children: [
            Expanded(
                child: ScrollSnapList(
                  itemBuilder: _buildItemList,
                  onItemFocus: (pos){
                    setState(() {
                      // current=pos;
                    });
                    print('Done! $pos');
                  },
                  itemSize: 100,
                  onReachEnd: (){
                    print('Done!');
                  },
                  itemCount: data.length,
                )
            ),
          ],
        ),
      ),
    );
  }
}

class Data{
  int count;
  String path;
  Data(this.count,this.path);

}
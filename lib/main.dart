
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

import 'Fetch_data_list.dart';
import 'Database.dart';
import 'Home.dart';

void main() => runApp(MyApp());
var db=new DatabaseHelper();
class MyApp extends StatelessWidget {
//  @override
//  HomeScreen createState() => new HomeScreen();

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
        home: new HomeScreen());

  }
}



class HomeScreen extends StatelessWidget {
  _getRequests()async{

  }
//  BuildContext ctxt=context;
  @override
  Widget build(BuildContext context) {
 /*   return MaterialApp(
        title: 'News Application',
        home:*/
      return Scaffold(

          appBar: AppBar(title: Text("Choose Country"),
          actions: <Widget>[

            IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
//                BuildContext ctxt=context;
                Navigator.push(context,
                  MaterialPageRoute(builder: (context) => MyCustomForm())
                );
              }
            )
          ],
          ),

              body: FutureBuilder<List>(
                future: db.getAllCountries(),
                initialData: List(),
                builder: (context, snapshot) {
                  return snapshot.hasData
                      ? ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (_, int position) {
                      final item = snapshot.data[position];
                      //get your item data here ...
                      return Card(
                        child: ListTile(
                          title: Text(item.row[1]),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) =>
                                  MainFetchData(text: item.row[1],))
                          );
                        }
                        ),
                      );
                    },
                  )
                      : Center(
                    child: CircularProgressIndicator(),
                  );
                },
              ),
      );


//              getListView(),
      /*   floatingActionButton: FloatingActionButton(
//       Padding(
//            padding: const EdgeInsets.all(8.0),
            child: RaisedButton(
              child: Icon(Icons.add),
              onPressed: () {
                debugPrint("add Country");
                Navigator.push(context,
                  MaterialPageRoute(builder: (context) => MyCustomForm()),
                );
              },

            ),
          ),*/
//    )
//        )
//    );
  }


}
/*

 getListElements(){
  var items = ["France","UK","Italy","Germany"];
  return items;
}

 getListView() async {

  var listItems=getListElements();
  var listview = ListView.builder(

      itemCount: listItems.length ,
      itemBuilder: (context,index){
        return ListTile(
          leading: Icon(Icons.arrow_right),
          title: Text(listItems[index]),
          onTap: (){
            Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MainFetchData(text: listItems[index],))
            );
          },
        );

      }
  );
 return listview;


}*/


import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;
import 'AvailableCountriesPage.dart';
import 'Fetch_data_list.dart';
import 'Database.dart';
//import 'Home.dart';


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

/* TO DO
  *Restart all the activity when HomeScreen is loaded
  * Fetch_data_list.dart -> Load from the first time
  *
 */

class HomeScreen extends StatelessWidget {

static List code=List() ;
//  BuildContext ctxt=context;
  @override
  Widget build(BuildContext context) {
 /*   return MaterialApp(
        title: 'News Application',
        home:*/
      return new Scaffold(

          appBar: AppBar(title: Text("Choose Country"),
          actions: <Widget>[

            IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
//                BuildContext ctxt=context;
                Navigator.push(context,
                  MaterialPageRoute(builder: (context) => CountriesList())
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
                            title: Text(item.row[0]),
                            trailing: GestureDetector(onTap: (){debugPrint("Delete");
                            db.deleteCountry(item.row[0].toString());
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(builder: (context) =>
                                    HomeScreen())
                            );},
                                  child: Container(
                          width: 48,
                          height: 48,
                          padding: EdgeInsets.symmetric(vertical: 4.0),
                          alignment: Alignment.center,
                          child: Icon(Icons.delete),
                        ),
                            ),
                            onTap: () {
                              String cn;
                              Future<String> cc=_getCode(item.row[0]);
                              cc.then((cn){
                              debugPrint("--------cn---------"+cn.toString());
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) =>
                                      MainFetchData(text: cn.toString()))
                              );
                            });
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
/*  getListView() async{

  }*/

 Future<String> _getCode(String name) async{
    String url="https://restcountries.eu/rest/v2/name/"+name;
    final response1 =
    await http.get(url);
    if (response1.statusCode == 200) {
      code = json.decode(response1.body);
      debugPrint(code[0].toString());
     return code[0]['alpha2Code'];

//      data = children["source"];
//      alpha2Code
//      return code[0]['alpha2Code'];
//      print(children.runtimeType.toString());
//      print(children['data'].toString());

    } else {
      throw Exception('Failed to load photos');
    }

    // https://restcountries.eu/rest/v2/name/{name}
  }

}

//
// getListElements(){
//  var items = ["France","UK","Italy","Germany"];
//  return items;
//}
//
// getListView() async {
//
//  var listItems=getListElements();
//  var listview = ListView.builder(
//
//      itemCount: listItems.length ,
//      itemBuilder: (context,index){
//        return ListTile(
//          leading: Icon(Icons.arrow_right),
//          title: Text(listItems[index]),
//          onTap: (){
//            Navigator.push(
//                context,
//                MaterialPageRoute(builder: (context) => MainFetchData(text: listItems[index],))
//            );
//          },
//        );
//
//      }
//  );
// return listview;
//
//
//}*/

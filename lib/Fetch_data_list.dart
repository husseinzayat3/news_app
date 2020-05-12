import 'package:flutter/material.dart';
import 'Database.dart';
import 'dart:convert';
import 'package:news_app/DetailsPage.dart';
import 'package:http/http.dart' as http;
var db=new DatabaseHelper();
String base_url = "https://newsapi.org/v2/top-headlines?country=";
String all_api_key="&apiKey=4bddb6a967614bc787b6f52c7a178382";
String business_api_key="&category=business&apiKey=4bddb6a967614bc787b6f52c7a178382";
String tech_api_key="&category=technology&apiKey=4bddb6a967614bc787b6f52c7a178382";
//int x=1;
String sport_api_key="&category=sports&apiKey=4bddb6a967614bc787b6f52c7a178382";
String no_image="upload.wikimedia.org/wikipedia/commons/a/ac/No_image_available.svg";

//https://newsapi.org/v2/top-headlines?country=de&apiKey=4bddb6a967614bc787b6f52c7a178382
String api_key;
int value=10;
class MainFetchData extends StatefulWidget {
  final String text;


 MainFetchData({Key key, @required this.text}) : super(key: key);

  @override
  _MainFetchDataState createState() => _MainFetchDataState(this.text);
}

class _MainFetchDataState extends State<MainFetchData> {
   String country;
//   final String concode;
  _MainFetchDataState(this.country);

  List Categories =
  ["All", "Sports","Business","Technology"];

  List<DropdownMenuItem<String>> _dropDownMenuItems;
  String _currentCat;




  List<DropdownMenuItem<String>> getDropDownMenuItems() {
    List<DropdownMenuItem<String>> items = new List();
    for (String cat in Categories) {
      items.add(new DropdownMenuItem(
          value: cat,
          child: new Text(cat)
      ));
    }
    return items;
  }

//  static List data = List();
  static List children = List();


  var isLoading = false;

  _fetchData() async {
    setState(() {

      isLoading = true;
    });

    if(_currentCat=="All") {
    api_key = all_api_key;
      }
    if(_currentCat.contains("Sports")) {
        api_key = sport_api_key;
      }
      if(_currentCat.contains("Business")){
        api_key=business_api_key;
      }
      if(_currentCat.contains("Technology")){
        api_key=tech_api_key;
      }
    debugPrint("--------cat-----"+_currentCat);
    debugPrint("--------country-------"+country);
    final response =
    await http.get(base_url+country+api_key);
    if (response.statusCode == 200) {
      children = json.decode(response.body)["articles"] ;
//      data = children["source"];

      debugPrint(children.length.toString());

      value=children.length;

//      print(children.runtimeType.toString());
//      print(children['data'].toString());
      setState(() {
        isLoading = false;
//        x=children.length.toInt();
      });
    } else {
      throw Exception('Failed to load photos');
    }
  }

  static ScrollController _controller;

  _scrollListener() {
    if (_controller.offset >= _controller.position.maxScrollExtent &&
        !_controller.position.outOfRange) {
      setState(() {});
    }
    if (_controller.offset <= _controller.position.minScrollExtent &&
        !_controller.position.outOfRange) {
      setState(() {
        base_url = base_url;
//            + "?count=10&after=" + children['after'] + "/.json";
        print('bottom');
      });
      print('bottom111');
    }
  }



  final makeBody = Container(
    child:ListView.builder(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemCount:value ,
      controller: _controller,
      itemBuilder: (BuildContext context, int index) {
        return Card(
          elevation: 8.0,
          margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
          child: Container(
            decoration: BoxDecoration(color: Color.fromRGBO(64, 75, 96, .9)),
            child: ListTile(
                contentPadding: EdgeInsets.symmetric(
                    horizontal: 20.0, vertical: 10.0),
                leading: Container(
                  padding: EdgeInsets.only(right: 12.0),
                  decoration: new BoxDecoration(
                      border: new Border(
                          right: new BorderSide(
                              width: 1.0, color: Colors.white24))),
                  child:Image.network(children[index]['urlToImage']!=null?children[index]['urlToImage']:no_image,width:80 ,height: 80),
//                  Icon(Icons.autorenew, color: Colors.white),
                ),
                title: Text(
                  children[index]['title']
//                      ? children[index]['source']['name']
//                     : children[index]['source']['title']
                  ,
                  maxLines: 5,
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
                // subtitle: Text("Intermediate", style: TextStyle(color: Colors.white)),
                subtitle: Column(
                  children: <Widget>[
//                    Icon(Icons.linear_scale, color: Colors.yellowAccent),
                    Text(children[index]['source']['id']!=null ?children[index]['source']['id']:children[index]['source']['name'],style: TextStyle(color: Colors.white),),
                    Text(children[index]['publishedAt'], style: TextStyle(color: Colors.white))
                  ],
                ),
                trailing:
                Icon(Icons.keyboard_arrow_right, color: Colors.white,
                    size: 30.0)
              ,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => WebViewContainer(url: children[index]['url'],),
                  ),
                );
//                debugPrint("-----------"+x.toString());
              },
      ),
          ),
        );
      },
    ),
  );


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("News"),
          actions: <Widget>[
          new DropdownButton(
            value: _currentCat,
            items: _dropDownMenuItems,
            onChanged : changedDropDownItem,
          ),
      ]
        ),

        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(8.0),
          child: RaisedButton(
            child: new Text("Refresh"),
            onPressed: _fetchData,
          ),
        ),
        body: isLoading!=false
            ? Center(
          child: CircularProgressIndicator(),
        )
            : makeBody);


  }

  void changedDropDownItem(String category) {
    setState(() {
//      if(category.contains("All")) {
        _currentCat = category;
        _fetchData();
//      }
//      if(category.contains("Sports")) {
//        _currentCat = sport_api_key;
//        _fetchData();
//      }
    });
  }



}









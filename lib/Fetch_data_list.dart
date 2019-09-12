import 'package:flutter/material.dart';
import 'Database.dart';
import 'dart:convert';
import 'package:news_app/DetailsPage.dart';
//import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
var db=new DatabaseHelper();
String base_url = "https://newsapi.org/v2/top-headlines?country=";
String api_key="&apiKey=4bddb6a967614bc787b6f52c7a178382";

String no_image="upload.wikimedia.org/wikipedia/commons/a/ac/No_image_available.svg";
//https://newsapi.org/v2/top-headlines?country=de&apiKey=4bddb6a967614bc787b6f52c7a178382
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



//  static List data = List();
  static List children = List();
  static List code=List() ;
  var isLoading = false;
//  var first=false;

  _fetchData() async {
    setState(() {
      isLoading = true;
    });/*
       if(country == "Italy"){
      cn = "it";
    }else if(country=="UK"){
      cn = "gb";
    }else if(country=="France"){
      cn = "fr";
    }*//*else if(country=="germany"){
      cn = "de";
    }*//*else{
//      cn= await db.getSymbol(country);

    }*/
//   cn=country;
    _getCode(country);
    String cn=code[0]['alpha2Code'];
    debugPrint("-------"+cn);
    final response =
    await http.get(base_url+cn+api_key);
    if (response.statusCode == 200) {
      children = json.decode(response.body)["articles"];
//      data = children["source"];

      debugPrint(children.length.toString());
//      print(children.runtimeType.toString());
//      print(children['data'].toString());
      setState(() {
        isLoading = false;
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

  @override
  void initState() {
    _controller = ScrollController();
    _controller.addListener(_scrollListener);
    _fetchData();
    super.initState();
  }


  final makeBody = Container(
    child: ListView.builder(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemCount: 10,
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

 _getCode(String name) async{
String url="https://restcountries.eu/rest/v2/name/"+name;
    final response1 =
    await http.get(url);
    if (response1.statusCode == 200) {
      code = json.decode(response1.body);
      debugPrint(code[0].toString());
//      data = children["source"];
//      alpha2Code
//      return code[0]['alpha2Code'];
//      print(children.runtimeType.toString());
//      print(children['data'].toString());
      setState(() {
        isLoading = false;
      });
    } else {
      throw Exception('Failed to load photos');
    }

    // https://restcountries.eu/rest/v2/name/{name}
  }


}









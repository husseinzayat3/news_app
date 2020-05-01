
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


int value=10;



class CoronaVirusPage extends StatefulWidget {


  CoronaVirusPage({Key key}) : super(key: key);

  @override
  _CoronaVirusPageState createState() => _CoronaVirusPageState();
}



class _CoronaVirusPageState extends State<CoronaVirusPage> {

  static var children;



  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(title: Text("Coronavirus Statistics")),
      body: isLoading!=false
          ? Center(
        child: CircularProgressIndicator(),
      )
          : makeBody,


      );


//    );
  }
  var isLoading = false;

  _fetchData() async {
    setState(() {

      isLoading = true;
    });

    String api_url = "https://api.thevirustracker.com/free-api?global=stats";

    final response =
    await http.get(api_url);
    if (response.statusCode == 200) {
      print(response.body);
      children = json.decode(response.body)["results"][0];
//      data = children["source"];

//      debugPrint(children.length.toString());

//      value=children.length;

//      print(children.runtimeType.toString());
//      print(children['data'].toString());
      setState(() {
        isLoading = false;
      });
    } else {
      throw Exception('Failed to load photos');
    }
  }


  final makeBody = Container(
    child: ListView.builder(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemCount: 1 ,
//      controller: _controller,
      itemBuilder: (BuildContext context, int index) {
        return Card(
          elevation: 8.0,
          margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
          child: Container(
            decoration: BoxDecoration(color: Color.fromRGBO(64, 75, 96, .9)),
            child: ListTile(
              contentPadding: EdgeInsets.symmetric(
                  horizontal: 20.0, vertical: 10.0),

              title: Text("Total Cases"
                // TODO: APIValueKEY
                ,
                maxLines: 2,
                style: TextStyle(
                    color: Colors.white, fontWeight: FontWeight.bold),
              ),
              trailing: Text( children["total_cases"].toString(), style: TextStyle(fontSize: 15, color: Colors.white),),
              // subtitle: Text("Intermediate", style: TextStyle(color: Colors.white))
        )
        )
        );



//                debugPrint("-----------"+x.toString());
        },
            ),
          );

  @override
  void initState() {
    super.initState();
    _fetchData();


  }

}
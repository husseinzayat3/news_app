
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


int value=6;


List Categories =
["Global", "Top Countries","Technology"];

class CoronaVirusPage extends StatefulWidget {


  CoronaVirusPage({Key key}) : super(key: key);

  @override
  _CoronaVirusPageState createState() => _CoronaVirusPageState();
}


List<Stat> data= [];
class _CoronaVirusPageState extends State<CoronaVirusPage> {

  static var children;
  List<Stat> products = [];
  static Map<String, dynamic> tmp;



  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("Coronavirus Statistics"),
        actions: <Widget>[


        ],),
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
      tmp = children;
      print(tmp["total_active_cases"]);
      data.add(new Stat("Total Active Cases",tmp["total_active_cases"]));
      data.add(Stat("Total New Cases Today",tmp["total_new_cases_today"]));
      data.add(Stat("Total New Deaths Today",tmp["total_new_deaths_today"]));
      data.add(Stat("Total Recovered",tmp["total_recovered"]));
      data.add(Stat("Total Deaths",tmp["total_deaths"]));
      data.add(Stat("Total Affected Countries",tmp["total_affected_countries"]));
      print(data);

/*
 "total_cases":3363945,
I/flutter (28996):          "total_recovered":1069036,
I/flutter (28996):          "total_unresolved":2039891,
I/flutter (28996):          "total_deaths":237458,
I/flutter (28996):          "total_new_cases_today":60024,
I/flutter (28996):          "total_new_deaths_today":3634,
I/flutter (28996):          "total_active_cases":2057451,
I/flutter (28996):          "total_serious_cases":50109,
I/flutter (28996):          "total_affected_countries":212,
 */

//      Stat myProduct = Stat("Total Recovered", children["total_recovered"]);
//      products.add(myProduct);




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
      itemCount: 6 ,
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

              title: Text(data[index].key.toString()
                // TODO: APIValueKEY
                ,
                maxLines: 2,
                style: TextStyle(
                    color: Colors.white, fontWeight: FontWeight.bold),
              ),
//              trailing: Text( children["total_cases"].toString(), style: TextStyle(fontSize: 15, color: Colors.white),),
              trailing: Text( data[index].value.toString(), style: TextStyle(fontSize: 15, color: Colors.white),),
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
}

class Stat {
  String key;
  int value;
  Stat(this.key, this.value){

  }
  
}
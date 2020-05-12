
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:news_app/CountriesService.dart';

int value=6;

String globalApi = "https://api.thevirustracker.com/free-api?global=stats";
String countryApi = "https://api.thevirustracker.com/free-api?countryTimeline=";


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
  String api_url = globalApi;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _typeAheadController = TextEditingController();
  String selectedCountry;
  bool Global = true;


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("Coronavirus Global Numbers",style: TextStyle(fontSize: 20),),
        actions: <Widget>[


        ],),
      body:  new SingleChildScrollView(

      child:Column(
        children: <Widget>[
          Form(
            key: this._formKey,
            child: Padding(
              padding: EdgeInsets.only(left:32.0, right: 32.0,top: 5.0),
              child: Column(
                children: <Widget>[
                  TypeAheadFormField(
                    textFieldConfiguration: TextFieldConfiguration(
                        controller: this._typeAheadController,
                        decoration: InputDecoration(
                            labelText: 'Country'
                        )
                    ),
                    suggestionsCallback: (pattern) {
                      return CountriesService.getSuggestions(pattern);
                      print(pattern);
//                      return pattern;
                    },
                    itemBuilder: (context, suggestion) {
                      return ListTile(
                        title: Text(suggestion),
                      );
                    },
                    transitionBuilder: (context, suggestionsBox, controller) {
                      return suggestionsBox;
                    },
                    onSuggestionSelected: (suggestion) {
                      this._typeAheadController.text = suggestion;
                    },
                    validator: (value) {
                      if (value.isEmpty) {
                        setState(() {
                          Global = true;
                        });
                        return 'Please select a city';
                      }
                    },
                    onSaved: (value) => this.selectedCountry = value,
                  ),
                  SizedBox(height: 10.0,),
                  RaisedButton(
                    child: Text('Search'),
                    onPressed: () {
                      if (this._formKey.currentState.validate()) {
                        this._formKey.currentState.save();
                        Future<String> cc = CountriesService.getCode(this.selectedCountry);
                        cc.then((cn) {
                          debugPrint("--------cn---------" + cn.toString());
                          setState(() {
                            Global = false;
                            api_url = countryApi + cn;
                            print(api_url);
                          });
                        });
                        

                      }
                    },
                  )
                ],
              ),
            ),
          ),
          isLoading!=false
          ? Center(
        child: CircularProgressIndicator(),
      )
          : Global? makeBodyGlobal:  CircularProgressIndicator(),


        ],
//
//

      ),
      )
      );


//    );
  }
  var isLoading = false;

  _fetchData() async {
    setState(() {

      isLoading = true;
    });



    final response =
    await http.get(globalApi);
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
//{"new_daily_cases":31880,"new_daily_deaths":3859,"total_cases":699105,"total_recoveries":0,"total_deaths":36727},"4/18/20":


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


  final makeBodyGlobal = Container(
    child: ListView.builder(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemCount: 6 ,
//      controller: _controller,
      itemBuilder: (BuildContext context, int index) {
        return Card(
          elevation: 5.0,
          margin: new EdgeInsets.symmetric(horizontal: 5.0, vertical: 3.0),
          child: Container(
            decoration: BoxDecoration(color: Color.fromRGBO(64, 75, 96, .9)),
            child: ListTile(
              contentPadding: EdgeInsets.symmetric(
                  horizontal: 10.0, vertical: 10.0),

              title: Text(data[index].key.toString(),
                maxLines: 2,
                style: TextStyle(
                    color: Colors.white, fontWeight: FontWeight.bold),
              ),
              trailing: Text( data[index].value.toString(), style: TextStyle(fontSize: 15, color: Colors.white),),
        )
        )
        );



        },
            ),
          );

  @override
  void initState() {
    super.initState();
    _fetchData();


  }
//
//  List<DropdownMenuItem<String>> getDropDownMenuItems() {
//    List<DropdownMenuItem<String>> items = new List();
//    for (String cat in Categories) {
//      items.add(new DropdownMenuItem(
//          value: cat,
//          child: new Text(cat)
//      ));
//    }
//    return items;
//  }
}

class Stat {
  String key;
  int value;
  Stat(this.key, this.value){

  }
  
}
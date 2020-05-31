
import 'dart:convert';
import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:news_app/CoronaFullStat.dart';


int value=6;


List Categories =
["Global", "Top Countries","Technology"];

class CoronaVirusPage extends StatefulWidget {


  CoronaVirusPage({Key key}) : super(key: key);

  @override
  _CoronaVirusPageState createState() => _CoronaVirusPageState();
}


List<Stat> data= [];
List<Stat> Country_data=[];
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
          IconButton(
      icon: Icon(Icons.search),
        onPressed: () {
          showSearch(
            context: context,
            delegate: DataSearch(),
          );
        })



        ],
    ),
      drawer: Drawer(),

      body: isLoading!=false
          ? Center(
        child: CircularProgressIndicator(),
      )
          : makeBody,


      );

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
class DataSearch extends SearchDelegate<String> {
  final cities = [];
  var recentCities = [];
  static List code=List() ;
  static var  Country_children;
  static Map<String,dynamic > tmp1;

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
          icon: Icon(Icons.clear),
          onPressed: () {
            query = "";
          })
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {

    return IconButton(
        icon: AnimatedIcon(
          icon: AnimatedIcons.menu_arrow,
          progress: transitionAnimation,
        ),
        onPressed: () {
          close(context, null);
        });

  }

  @override
  Widget buildResults(BuildContext context) {
    //query is what was written in the search bar
    String cn;
    Future<String> cc=_getCode(query);
    cc.then((cn){
   
        _getValues(cn.toString());

    });





    return Center(
      child: Container(
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

                      title: Text(Country_data[index].key.toString()
                        // TODO: APIValueKEY
                        ,
                        maxLines: 2,
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
//              trailing: Text( children["total_cases"].toString(), style: TextStyle(fontSize: 15, color: Colors.white),),
                      trailing: Text( Country_data[index].value.toString(), style: TextStyle(fontSize: 15, color: Colors.white),),
                      // subtitle: Text("Intermediate", style: TextStyle(color: Colors.white))
                    )
                )
            );


          },
        ),
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestionList = query.isEmpty
        ? recentCities
        : cities.where((p) => p.startsWith(query)).toList();

    return ListView.builder(
      itemBuilder: (context, index) => ListTile(
        onTap: () {
          showResults(context);
        },
        leading: Icon(Icons.location_city),
        title: RichText(
          text: TextSpan(
            text: suggestionList[index].substring(0, query.length),
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
            children: [
              TextSpan(
                text: suggestionList[index].substring(query.length),
              ),
            ],
          ),
        ),
      ),
      itemCount: suggestionList.length,
    );
  }


  Future<String> _getCode(String name) async{
    String url="https://restcountries.eu/rest/v2/name/"+name;
    final response1 =
    await http.get(url);
    if (response1.statusCode == 200) {
      code = json.decode(response1.body);
      debugPrint(code[0].toString());
      return code[0]['alpha2Code'];


    } else {
      throw Exception('Failed to load photos');
    }

  }
  Future<Void> _getValues(String name) async{

    String api_url_country = "https://api.thevirustracker.com/free-api?countryTotal="+name;
    final response =
    await http.get(api_url_country);
    if (response.statusCode == 200) {

        Country_children = json.decode(response.body)["countrydata"][0];


      tmp1 = Country_children;
      print(tmp1["total_active_cases"]);
      Country_data.add(new Stat("Total Cases",tmp1["total_cases"]));
      Country_data.add(new Stat("Total Active Cases",tmp1["total_active_cases"]));
      Country_data.add(Stat("Total Recovered",tmp1["total_recovered"]));
      Country_data.add(Stat("Total Deaths",tmp1["total_deaths"]));
      Country_data.add(Stat("Total New Cases Today",tmp1["total_new_cases_today"]));
      Country_data.add(Stat("Total New Deaths Today",tmp1["total_new_deaths_today"]));

    }else{
      debugPrint("------ API error");

    }


  }



}



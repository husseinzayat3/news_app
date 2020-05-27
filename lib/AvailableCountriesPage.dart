import 'package:flutter/material.dart';
import 'package:news_app/main.dart';
import 'Database.dart';
import 'dart:convert';
import 'package:news_app/DetailsPage.dart';

import 'package:flutter/cupertino.dart';

var db=new DatabaseHelper();

class CountriesList extends StatefulWidget {


  CountriesList({Key key}) : super(key: key);

  @override
  _CountriesListState createState() => _CountriesListState();
}

class _CountriesListState extends State<CountriesList> {
  _CountriesListState();
  String fav_country;
  List<DropdownMenuItem<String>> _countries;
  List _countriesList = [
    "Italy",
    "Germany",
    "USA",
    "France",
    "China",
    "United Kingdom"
  ];

  @override
  Widget build(BuildContext context) {
    // TODO: implement A widget of a spinner to select a country
    // Selected country should be a added to the database,
    // Main page (main.dart) will read from the local database the list of favorite countries

    return Scaffold(
        appBar: AppBar(
        title: Text("Add Country"),
    ),

    body: Container(
        margin: const EdgeInsets.only(top:60.0),
        alignment: Alignment.center,


    child: Column(

      children: <Widget>[
          DropdownButton(
            value: fav_country,
            items: _countries,

            onChanged: (value){
              setState(() {
                fav_country = value;
              });
            },
          ),
          RaisedButton(
            child: Text("Add Country!"),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
                side: BorderSide(color: Colors.blueAccent)
            ),
            onPressed: (){
              print('countryyyy_____----->'+ fav_country);
              db.insert(0, fav_country);
              Navigator.pop(context);
            },
          )
        ],
    )
    )
    );


  }
  List<DropdownMenuItem<String>> getDropDownMenuItems() {
    List<DropdownMenuItem<String>> items = new List();
    for (String cat in _countriesList) {
      items.add(new DropdownMenuItem(
          value: cat,
          child: new Text(cat)
      ));
    }
    return items;
  }

  @override
  void initState() {
    super.initState();
    _countries = getDropDownMenuItems();
    fav_country = _countries[0].value;

  }


}
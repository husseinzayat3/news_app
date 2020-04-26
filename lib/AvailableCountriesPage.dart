
import 'package:flutter/material.dart';
import 'Database.dart';
import 'dart:convert';
import 'package:news_app/DetailsPage.dart';

import 'package:flutter/cupertino.dart';

class CountriesList extends StatefulWidget {


  CountriesList({Key key}) : super(key: key);

  @override
  _CountriesListState createState() => _CountriesListState();
}

class _CountriesListState extends State<CountriesList> {
  _CountriesListState();

  @override
  Widget build(BuildContext context) {
    // TODO: implement A widget of a spinner to select a country
    // Selected country should be a added to the database,
    // Main page (main.dart) will read from the local database the list of favorite countries
    return null;
  }

}
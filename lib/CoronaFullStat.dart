
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CoronaFullstatPage extends StatefulWidget {


  CoronaFullstatPage({Key key}) : super(key: key);

  @override
  _CoronaFullstatState createState() => _CoronaFullstatState();
}



class _CoronaFullstatState  extends State<CoronaFullstatPage> {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("Coronavirus Full Statistics"),
        actions: <Widget>[



        ],),
//      body: isLoading!=false
//         ? Center(
//        child: CircularProgressIndicator(),
//      )
//          :makeBody,


    );



  }
//
//  var isLoading = false;
//
//  _fetchData() async {
//    setState(() {
//
//      isLoading = true;
//    });
}
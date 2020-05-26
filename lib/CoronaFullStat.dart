
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



        ],
      ),
        body: Container(
            padding: EdgeInsets.symmetric(vertical: 20.0,horizontal: 10.0),
        child: Column(
            children: <Widget>[

              TextField(

                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.blueAccent,
                      ),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    hintText: "Enter Country",

                  )),
              RaisedButton(
                child: Text("Search"),
                onPressed: (){
//
//                  Navigator.push(
//                      context,
//                      MaterialPageRoute(builder: (context) =>
//                          HomeScreen()));
                },
              )


          ]

        )
        )


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
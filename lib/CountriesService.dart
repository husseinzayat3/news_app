import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';

class CountriesService {
  static List code = List();
  static final List<String> cities = [
    'Lebanon',
    'Italy',
    'Germany',
    'USA',
    'France',
    'Spain',
    'England',
    'Russia',
    'China',
    'Iran',
    'India',
    'Turkey',
  ];

  static List<String> getSuggestions(String query) {
    List<String> matches = List();
    matches.addAll(cities);

    matches.retainWhere((s) => s.toLowerCase().contains(query.toLowerCase()));
    return matches;
  }
  static Future<String> getCode(String name) async {
    String url = "https://restcountries.eu/rest/v2/name/" + name;
    final response1 = await http.get(url);
    if (response1.statusCode == 200) {
      code = json.decode(response1.body);
      debugPrint(code[0].toString());
      return code[0]['alpha2Code'];

//      data = children["source"];
//      alpha2Code
//      return code[0]['alpha2Code'];
//      print(children.runtimeType.toString());
//      print(children['data'].toString());

    } else {
      throw Exception('Failed to load photos');
    }
  }

  }
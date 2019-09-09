//import 'dart:convert';
//
//Country clientFromJson(String str) {
//  final jsonData = json.decode(str);
//  return Country.fromJson(jsonData);
//}
//
//String clientToJson(Country data) {
//  final dyn = data.toJson();
//  return json.encode(dyn);
//}
//
//class Country {
//  int id;
//  String country_name;
//  String country_symbol;
//
//  Country({
//    this.id,
//    this.country_name,
//    this.country_symbol,
//  });
//
//  factory Country.fromJson(Map<String, dynamic> json) => new Country(
//    id: json["id"],
//    country_name: json["country_name"],
//    country_symbol: json["country_symbol"],
//  );
//
//  Map<String, dynamic> toJson() => {
//    "id": id,
//    "counrty_name": country_name,
//    "country_symbol": country_symbol,
//  };

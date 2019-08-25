import 'package:flutter/material.dart';

import 'Fetch_data_list.dart';
import 'Tools.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'List of Countries',
      home:
      Scaffold(
        appBar: AppBar(title: Text("Choose Country"),),
        body: getListView(),
      ),
    );
  }


}

List<String> getListElements(){
  var items = ["France","UK","Italy","Germany"];
//  var items=List<String>.generate(1000, (counter)=>"Item $counter");
//  var items=List<String>.generate(1000, (counter)=>"Item $counter");
  return items;
}

Widget getListView(){

  var listItems=getListElements();
  var listview = ListView.builder(
      itemCount: 4,
      itemBuilder: (context,index){
        return ListTile(
          leading: Icon(Icons.arrow_right),
          title: Text(listItems[index]),
          onTap: (){
            Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MainFetchData(text: listItems[index],))
            );
//            debugPrint("tapped"+listItems[index]);
          },
        );
      }
  );
  return listview;

}

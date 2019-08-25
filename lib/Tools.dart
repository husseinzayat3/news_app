class Todo {
  final String title;
  final String description;

  Todo(this.title, this.description);
}




/*


void main() {
  runApp(MaterialApp(
    title: 'Passing Data',
    home: List_country(
      todos: List.generate(
           20,
            (i) => Todo(
          'Italy',
          '/google-news-it-api',
        ),

      ),
    ),
  ));
}



void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

//  final List<Todo> todos;
//
//  MainFetchData({Key key, @required this.todos}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Todos'),
      ),
      body: ListView.builder(
        itemCount: todos.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(todos[index].title),
            // When a user taps the ListTile, navigate to the DetailScreen.
            // Notice that you're not only creating a DetailScreen, you're
            // also passing the current todo through to it.
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MainFetchData(todo: todos[index]),
                ),
              );
            },
          );
        },
      ),
    );
  }





*/

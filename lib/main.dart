import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.orange,
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Awesome HackPSU TODO List'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<String> _listItems = ["Item 1", "Item 2", "Item 3"];
  TextEditingController _controller;

  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  Widget _buildTextInput(BuildContext context) {
    return AlertDialog(
      content: TextField(
        controller: _controller,
      ),
      actions: <Widget>[
        FlatButton(
          child: Text('Add'),
          onPressed: () {
            Navigator.of(context).pop(_controller.value.text);
          },
        )
      ]
    );
  }

  _onDelete(String item) {
    setState(() {
      _listItems.remove(item);
    });
  }

  Future<void> _onAddItem() async {
    final str = await showDialog<String>(
      context: context,
      builder: _buildTextInput
    );

    if (str == null) {
      return;
    }

    setState(() {
      _listItems.add(str);
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: ListView(
          children: _listItems.map((String item) {
        return ListTile(
          key: Key(item),
          title: Text(item),
          trailing: IconButton(icon: Icon(Icons.delete), onPressed: () { _onDelete(item); }),
        );
      }).toList()),
      floatingActionButton: FloatingActionButton(
        onPressed: _onAddItem,
        child: Tooltip(
            message: "Add Item to Awesome TODO List", child: Icon(Icons.add)),
      ),
    );
  }
}

import 'dart:convert' show Encoding, utf8;

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'constants.dart';
import 'xmlmaker.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo',
      theme: new ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or press Run > Flutter Hot Reload in IntelliJ). Notice that the
        // counter didn't reset back to zero; the application is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: new MyHomePage(title: 'test'),
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
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with WidgetsBindingObserver {
  String responseText = "n/a";

  Future _makeRequest() async {
    http.Response response = await http
        .post(Constants.base_url,
            headers: {
              "SOAPAction":
                  "http://tempuri.org/IEquusIService/WCFCheckIfEMailExists",
              "Content-Type": "text/xml;charset=UTF-8"
            },
            body: utf8.encode(
                XmlMaker.checkIfMailExists("grega.jekos@tovarnaidej.si")),
            encoding: Encoding.getByName("UTF-8"))
        .then((onValue) {
      print("Response status: ${onValue.statusCode}");
      print("Response body: ${onValue.body}");
      setState(() {
        responseText = onValue.body;
      });
    });
  }

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);

    print(XmlMaker.checkIfMailExists("grega.jekos@tovarnaidej.si"));
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
  }

  @override
  void deactivate() {
    print("GREGA deactivate");
  }

  @override
  void reassemble() {
    print("GREGA reassemble");
  }

  @override
  bool get mounted {
    print("GREGA mounted");
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    print("GREGA state " + state.toString());
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return new Scaffold(
      appBar: new AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: new Text(widget.title),
      ),
      body: new Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: new Column(
          // Column is also layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug paint" (press "p" in the console where you ran
          // "flutter run", or select "Toggle Debug Paint" from the Flutter tool
          // window in IntelliJ) to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Text(responseText),
          ],
        ),
      ),
      floatingActionButton: new FloatingActionButton(
        onPressed: _makeRequest,
        tooltip: 'Make request',
        child: new Icon(Icons.ac_unit),
        backgroundColor: Colors.amberAccent,
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

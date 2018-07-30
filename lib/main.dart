import 'dart:async';
import 'dart:io';

import 'package:progress_hud/progress_hud.dart';
import 'package:flutter/material.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Internet check',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new MyHomePage(title: 'Internet Check Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var _content = '';

  _submit()async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        setState(() {
          _content = "Connected";
        });
      }
    }on SocketException catch (_) {
      setState(() {
        _content = "Please Check internet connection and try again.";
      });
    }
  }
  _startBar(){
    startTime();
    showDialog(
        context: context,
        child: progress);
  }
  _stopBar(){
    Navigator.pop(context);
  }
  var progress = new ProgressHUD(
    backgroundColor: Colors.black12,
    color: Colors.white,
    containerColor: Colors.blue,
    borderRadius: 5.0,
  );
  startTime() async {
    var _duration = new Duration(seconds:3);
    return new Timer(_duration, _stopBar);
  }
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: new Text("Internet checker"),
      ),
      body: new Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ButtonTheme(
              minWidth:200.0,
              height: 42.0,
              child: Padding(
                padding: EdgeInsets.only(top: 35.0,bottom: 10.0),
                child: RaisedButton(
                  onPressed: _submit,
                  color: Colors.redAccent,
                  textColor: Colors.white,
                  elevation: 2.0,
                  highlightColor: Colors.red,
                  highlightElevation: 8.0,
                  child: new Text('Press to check'),
                ),
              ),
            ),
            new Text(
              '$_content',
              style: Theme.of(context).textTheme.headline,
            ),
            ButtonTheme(
              minWidth:200.0,
              height: 42.0,
              child: Padding(
                padding: EdgeInsets.only(top: 35.0,bottom: 10.0),
                child: RaisedButton(
                  onPressed: _startBar,
                  color: Colors.redAccent,
                  textColor: Colors.white,
                  elevation: 2.0,
                  highlightColor: Colors.red,
                  highlightElevation: 8.0,
                  child: new Text('Start progress Bar'),
                ),
              ),
            ),
            ButtonTheme(
              minWidth:200.0,
              height: 42.0,
              child: Padding(
                padding: EdgeInsets.only(top: 35.0,bottom: 10.0),
                child: RaisedButton(
                  onPressed: _stopBar,
                  color: Colors.redAccent,
                  textColor: Colors.white,
                  elevation: 2.0,
                  highlightColor: Colors.red,
                  highlightElevation: 8.0,
                  child: new Text('Automaticaly Stop Progress Bar after 3 seconds'),
                ),
              ),
            ),
          ],
        ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }


}

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'data.dart';
import 'graph.dart';

void main() {
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(new MyApp());
  });
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Calculator',
      debugShowCheckedModeBanner: false,
      routes: <String, WidgetBuilder>{
        '/data': (BuildContext context) => DataPage(),
        '/graph': (BuildContext context) => GraphPage(),
      },
      home: DataPage(),
    );
  }
}

class Point {
  int x;
  int y;
}



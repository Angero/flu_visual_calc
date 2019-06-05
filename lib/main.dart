import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'data.dart';

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
      title: 'KidsWay',
//      navigatorKey: navigatorKey,
      debugShowCheckedModeBanner: false,
      routes: <String, WidgetBuilder>{
        '/data': (BuildContext context) => DataPage(),
      },
      home: DataPage(),
    );
  }
}




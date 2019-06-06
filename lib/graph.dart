import 'package:flutter/material.dart';
import 'main.dart';
import 'data.dart' as dt;

Graph graph;

class GraphPage extends StatefulWidget {
  @override
  _GraphPageState createState() => new _GraphPageState();
}

class _GraphPageState extends State<GraphPage> {
  @override
  void initState() {
    super.initState();
    graph = Graph();
    graph.init(dt.points);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Graphic'),
      ),
      body: CustomPaint(
        painter: CurvePainter(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: Container(),
              flex: 1,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Text(graph.minY.toString() + ' - ' + graph.maxY.toString()),
              ],
            ),
            Container(
              height: MediaQuery.of(context).size.width,
              width: MediaQuery.of(context).size.width,
              color: Colors.black12,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(graph.minX.toString()),
                Text(graph.maxX.toString()),
              ],
            ),
            Expanded(
              child: Container(),
              flex: 1,
            ),
          ],
        ),
      ),
    );
  }
}

class CurvePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    graph.convert(dt.points, size);

    var paint = Paint();
    paint.color = Colors.amber;
    paint.strokeWidth = 5;

    for (int i = 0; i < graph.dots.length; i++) {
      if (i > 0) {
        canvas.drawLine(
          Offset(graph.dots[i - 1].x * 1.0, graph.dots[i - 1].y * 1.0),
          Offset(graph.dots[i].x * 1.0, graph.dots[i].y * 1.0),
          paint,
        );
      }
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}

class Graph {
  List<Point> dots;
  int minX;
  int maxX;
  int minY;
  int maxY;
  int dX;
  int dY;
  int sh;
  double dw;
  double dh;

  Graph() {
    dots = List();
  }

  init(List<Point> points) {
    for (Point point in points) {
      minX ??= point.x;
      maxX ??= point.x;
      minY ??= point.y;
      maxY ??= point.y;
      if (point.x < minX) minX = point.x;
      if (point.x > maxX) maxX = point.x;
      if (point.y < minY) minY = point.y;
      if (point.y > maxY) maxY = point.y;
    }
  }

  convert(List<Point> points, Size size) {
    dX = maxX - minX;
    dY = maxY - minY;
    dw = size.width / dX;
    dh = size.width / dY; //size.height / dY;
    sh = ((size.height - size.width) / 2).floor();

    dots = List();
    int i = 0;
    for (Point point in points) {
      Point dot = Point();
      dot.x = (i * dw).floor();
      dot.y = ((maxY - point.y) * dh).floor() + sh;
      dots.add(dot);
      print(dot.x.toString() + ' ' + dot.y.toString());
      i++;
    }
  }
}

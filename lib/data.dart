import 'package:flutter/material.dart';
import 'calculator.dart';
import 'main.dart';

List<Point> points;

class DataPage extends StatefulWidget {
  @override
  _DataPageState createState() => new _DataPageState();
}

class _DataPageState extends State<DataPage> {
  final TextEditingController controllerExp = new TextEditingController();
  final TextEditingController controllerFirst = new TextEditingController();
  final TextEditingController controllerLast = new TextEditingController();

  final GlobalKey<ScaffoldState> scaffoldState = new GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    controllerFirst.text = '1';
    controllerLast.text = '10';
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      key: scaffoldState,
      appBar: AppBar(
        title: Text('Data'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: <Widget>[
            TextField(
              autofocus: true,
              keyboardType: TextInputType.text,
              controller: controllerExp,
              decoration: InputDecoration(
                labelText: 'Expression',
                hintText: 'Input expression',
              ),
            ),
            TextField(
              keyboardType: TextInputType.number,
              controller: controllerFirst,
              decoration: InputDecoration(
                labelText: 'First Value',
                hintText: 'Input first value',
              ),
            ),
            TextField(
              keyboardType: TextInputType.number,
              controller: controllerLast,
              decoration: InputDecoration(
                labelText: 'Last Value',
                hintText: 'Input last value',
              ),
            ),
            SizedBox(
              height: 40.0,
            ),
            MaterialButton(
              child: new Text('Calculate'),
              minWidth: 120.0,
              height: 50.0,
              color: Colors.deepOrange,
              textColor: Colors.white,
              onPressed: calculate,
            ),
          ],
        ),
      ),
    );
  }

  void _onShowSnackBar(String value) {
    print(value);
    if (value.isEmpty) return;
    scaffoldState.currentState.showSnackBar(new SnackBar(
      content: Text(value),
    ));
  }

  calculate() {
    if (!checkData()) return;
    String exp = controllerExp.text.replaceAll(' ', '');
    exp = exp.replaceAll(')(', ')*(');
    int f = int.parse(controllerFirst.text);
    int l = int.parse(controllerLast.text);

    points = Calculator.run(exp, f, l);
    if (points == null) {
      _onShowSnackBar(
          'Не удалось рассчитать математическое выражение. Проверьте формулу.');
      return;
    }

    Navigator.of(context).pushNamed('/graph');
  }

  bool checkData() {
    if (!checkEmpty()) {
      _onShowSnackBar('Необходимо ввести все данные');
      return false;
    }
    if (!checkRange()) {
      _onShowSnackBar('Введите корректные данные диапазона значений');
      return false;
    }
    String exp = controllerExp.text.replaceAll(' ', '');
    if (!Calculator.checkChar(exp)) {
      _onShowSnackBar('Некорректно введены символы математического выражения');
    }
    if (!Calculator.checkBrackets(exp)) {
      _onShowSnackBar('Неверное количество скобок в математическом выражении');
    }
    return true;
  }

  bool checkEmpty() {
    if (controllerExp.text == '') return false;
    if (controllerFirst.text == '') return false;
    if (controllerLast.text == '') return false;
    if (controllerFirst.text == '') return false;
    if (controllerLast.text == '') return false;
    return true;
  }

  bool checkRange() {
    if (!Calculator.isInt(controllerFirst.text)) return false;
    if (!Calculator.isInt(controllerLast.text)) return false;
    int f = int.parse(controllerFirst.text);
    int l = int.parse(controllerLast.text);
    if (f > l) return false;
    return true;
  }
}

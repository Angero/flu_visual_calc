import 'package:flutter/material.dart';
import 'calculator.dart';

class DataPage extends StatefulWidget {
  @override
  _DataPageState createState() => new _DataPageState();
}

class _DataPageState extends State<DataPage> {
  final TextEditingController controllerExp = new TextEditingController();
  final TextEditingController controllerFirst = new TextEditingController();
  final TextEditingController controllerLast = new TextEditingController();
  final TextEditingController controllerStep = new TextEditingController();

  final GlobalKey<ScaffoldState> _scaffold_state =
      new GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    controllerFirst.text = '1';
    controllerLast.text = '10';
    controllerStep.text = '1';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffold_state,
      appBar: AppBar(
        title: Text('Data'),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.info_outline), onPressed: null),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: <Widget>[
            TextField(
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
            TextField(
              keyboardType: TextInputType.number,
              controller: controllerStep,
              decoration: InputDecoration(
                labelText: 'Step',
                hintText: 'Input step value',
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
    _scaffold_state.currentState.showSnackBar(new SnackBar(
      content: Text(value),
    ));
  }

  calculate() {
    if (!checkData()) return;
    String exp = controllerExp.text.replaceAll(' ', '');
    exp = exp.replaceAll(')(', ')*(');
    int f = int.parse(controllerFirst.text);
    int l = int.parse(controllerLast.text);
    int s = int.parse(controllerStep.text);

    Map<String, dynamic> map = Calculator.run(exp, f, l, s);
    if (map == null) {
      _onShowSnackBar(
          'Не удалось рассчитать математическое выражение. Проверьте формулу.');
      return;
    }
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
    if (controllerStep.text == '') return false;
    if (controllerFirst.text == '') return false;
    if (controllerLast.text == '') return false;
    if (controllerStep.text == '') return false;
    return true;
  }

  bool checkRange() {
    if (!Calculator.isInt(controllerFirst.text)) return false;
    if (!Calculator.isInt(controllerLast.text)) return false;
    if (!Calculator.isInt(controllerStep.text)) return false;
    int f = int.parse(controllerFirst.text);
    int l = int.parse(controllerLast.text);
    int s = int.parse(controllerStep.text);
    if (f > l) return false;
    if (s <= 0) return false;
    return true;
  }
}

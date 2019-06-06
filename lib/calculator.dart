import 'main.dart';

class Calculator {
  static bool checkChar(String exp) {
    var reg = RegExp(r'[0-9\(\)\+\-\/\*x]+');
    int size = 0;
    reg.allMatches(exp).forEach((Match m) {
      size += m.group(0).length;
    });
    return size == exp.length;
  }

  static bool checkBrackets(String exp) {
    int z = 0;
    for (int i = 0; i < exp.length; i++) {
      if (exp.substring(i, i + 1) == '(') z++;
      if (exp.substring(i, i + 1) == ')') z--;
      if (z < 0) return false;
    }
    if (z != 0) return false;
    return true;
  }

  static List<dynamic> parse(String exp) {
    int sign = 1;
    String n = '';
    List<dynamic> list = List();
    for (int i = 0; i < exp.length; i++) {
      String c = exp.substring(i, i + 1);
      if (isInt(c)) {
        n += c;
      } else {
        if (n != '') {
          list.add(int.parse(n) * sign);
          sign = 1;
          n = '';
        }
        if (c == '-') {
          if (i == 0) {
            sign = -1;
          } else {
            String p = exp.substring(i - 1, i);
            if (!isInt(p) && p != ')') {
              sign = -1;
            } else {
              list.add(c);
            }
          }
        } else {
          list.add(c);
        }
      }
    }
    if (n != '') {
      list.add(int.parse(n) * sign);
      sign = 1;
      n = '';
    }
    return list;
  }

  static List<Point> run(String exp, int x1, int x2) {
    try {
      List<Point> points = List();
      for (int i = x1; i <= x2; i++) {
        String expX = exp.replaceAll('x', i.toString());
        List<dynamic> list = parse(expX);
        while (list.length != 1) {
          List<dynamic> b = brackets(list);
          if (!runIn(list, b: b)) return null;
        }
        Point p = Point();
        p.x = i;
        p.y = list[0];
        points.add(p);
        print(list[0]);
      }
      return points;
    } catch (e) {
      return null;
    }
  }

  static List<dynamic> brackets(List<dynamic> list) {
    int z = 0;
    for (int i = 0; i < list.length; i++) {
      if (list[i] == '(') z = i;
      if (list[i] == ')') return [z, i];
    }
    return null;
  }

  static bool runIn(List<dynamic> list, {List<dynamic> b}) {
    int k = 0;
    int m = list.length;
    if (b != null) {
      if (b[1] - b[0] == 2) {
        list.removeAt(b[1]);
        list.removeAt(b[0]);
        return true;
      }
      k = b[0];
      m = b[1];
    }
    List<String> signs = ['*', '/', '+', '-'];
    for (String sign in signs) {
      for (int i = k; i < m; i++) {
        if (sign == list[i]) {
          if (list[i] == '*') {
            list[i] = list[i - 1] * list[i + 1];
            list.removeAt(i + 1);
            list.removeAt(i - 1);
            return true;
          }
          if (list[i] == '/') {
            if (list[i + 1] == 0) return false;
            list[i] = list[i - 1] / list[i + 1];
            list.removeAt(i + 1);
            list.removeAt(i - 1);
            return true;
          }
          if (list[i] == '+') {
            list[i] = list[i - 1] + list[i + 1];
            list.removeAt(i + 1);
            list.removeAt(i - 1);
            return true;
          }
          if (list[i] == '-') {
            list[i] = list[i - 1] - list[i + 1];
            list.removeAt(i + 1);
            list.removeAt(i - 1);
            return true;
          }
        }
      }
    }
    return false;
  }

  static bool isInt(String s) {
    try {
      int.parse(s);
    } catch (e) {
      return false;
    }
    return true;
  }
}

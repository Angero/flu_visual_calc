import 'package:flutter_test/flutter_test.dart';
import 'package:flu_visual_calc/calculator.dart';

void main() {

  test('other symbols in the expression', () {
    bool r = Calculator.checkChar('()*-/+0123456789 ');
    expect(r, true);
  });

  test('incorrect quantity or positions of the brackets', () {
    bool r = Calculator.checkBrackets('(12+45)-(64*(13-3))');
    expect(r, true);
  });

}
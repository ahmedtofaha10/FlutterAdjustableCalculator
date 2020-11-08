import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:math_expressions/math_expressions.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tofaha_calculator/widegts/CalcBtn.dart';
import 'package:tofaha_calculator/widegts/Settings.dart';
import 'dart:io';
import 'package:number_display/number_display.dart';

void main() {
  runApp(MaterialApp(
    title: 'Tofaha Calculator',
    initialRoute: '/',
    routes: {
      '/': (context) => Calculator(),
      '/settings': (context) => CalculatorSettings(),
    },
  ));
}

class Calculator extends StatefulWidget {
  @override
  _CalculatorState createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  String _history = '';
  String _expression = '';
  Color expressionColor = Colors.blueGrey[900];
  Color numberButtonColor = Colors.blueGrey[900];
  Color symbolButtonColor = Colors.white;
  Color equalButtonColor = Colors.purple[800];
  Color clearButtonColor = Colors.cyan[900];
  Color numberTextColor = Colors.white;
  Color symbolTextColor = Colors.blueGrey[900];
  Color equalTextColor = Colors.white;
  Color clearTextColor = Colors.white;
  double expressionSize = 50;
  FileImage background = null;
  AssetImage main_background = AssetImage("images/02.jpg");
  Future<FileImage> getBackground() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return FileImage(
        File(prefs.getString('background') ?? AssetImage("images/02.jpg")));
  }

  Future<Color> getExpressionColor() async {
    final prefs = await SharedPreferences.getInstance();
    return HexColor.fromHex(
        prefs.getString('expressionColor') ?? Colors.blueGrey[700].toHex());
  }

  Future<Color> getNumberButtonColor() async {
    final prefs = await SharedPreferences.getInstance();
    return HexColor.fromHex(
        prefs.getString('numberButtonColor') ?? Colors.blueGrey[900].toHex());
  }

  Future<Color> getSymbolButtonColor() async {
    final prefs = await SharedPreferences.getInstance();
    return HexColor.fromHex(
        prefs.getString('symbolButtonColor') ?? Colors.white.toHex());
  }

  Future<Color> getEqualButtonColor() async {
    final prefs = await SharedPreferences.getInstance();
    return HexColor.fromHex(
        prefs.getString('equalButtonColor') ?? Colors.purple[800].toHex());
  }

  Future<Color> getClearButtonColor() async {
    final prefs = await SharedPreferences.getInstance();
    return HexColor.fromHex(
        prefs.getString('clearButtonColor') ?? Colors.cyan[900].toHex());
  }

  Future<Color> getNumberTextColor() async {
    final prefs = await SharedPreferences.getInstance();
    return HexColor.fromHex(
        prefs.getString('numberTextColor') ?? Colors.white.toHex());
  }

  Future<Color> getSymbolTextColor() async {
    final prefs = await SharedPreferences.getInstance();
    return HexColor.fromHex(
        prefs.getString('symbolTextColor') ?? Colors.blueGrey[900].toHex());
  }

  Future<Color> getEqualTextColor() async {
    final prefs = await SharedPreferences.getInstance();
    return HexColor.fromHex(
        prefs.getString('equalTextColor') ?? Colors.white.toHex());
  }

  Future<Color> getClearTextColor() async {
    final prefs = await SharedPreferences.getInstance();
    return HexColor.fromHex(
        prefs.getString('clearTextColor') ?? Colors.white.toHex());
  }

  _CalculatorState() {
    getExpressionColor().then((value) => setState(() {
          expressionColor = value;
          print(value);
        }));
    getNumberButtonColor().then((value) => setState(() {
          numberButtonColor = value;
          print(value);
        }));
    getSymbolButtonColor().then((value) => setState(() {
          symbolButtonColor = value;
          print(value);
        }));
    getEqualButtonColor().then((value) => setState(() {
          equalButtonColor = value;
          print(value);
        }));
    getClearButtonColor().then((value) => setState(() {
          clearButtonColor = value;
          print(value);
        }));
    getNumberTextColor().then((value) => setState(() {
          numberTextColor = value;
          print(value);
        }));
    getSymbolTextColor().then((value) => setState(() {
          symbolTextColor = value;
          print(value);
        }));
    getEqualTextColor().then((value) => setState(() {
          equalTextColor = value;
          print(value);
        }));
    getClearTextColor().then((value) => setState(() {
          clearTextColor = value;
          print(value);
        }));
    getBackground().then((value) => setState(() {
          background = value;
          print(value);
        }));
  }
  void numClick(String num) {
    if (_history != '') {
      allClear('');
    }
    setState(() {
      if (_expression.length < 21) {
        _expression += num;
      }
      if (_expression.length > 10) {
        expressionSize = 30;
      }
    });
  }

  void allClear(String num) {
    setState(() {
      _expression = '';
      _history = '';
      expressionSize = 50;
    });
  }

  void clear(String num) {
    setState(() {
      _expression = '';
      expressionSize = 50;
    });
  }

  void eveluate(String num) {
    Parser P = Parser();
    Expression exp = P.parse(_expression);
    ContextModel cm = ContextModel();
    final display = createDisplay(length: 8);
    double eve = exp.evaluate(EvaluationType.REAL, cm);
    setState(() {
      _history = _expression;
      expressionSize = 50;
      _expression = display(eve).toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TofahaCalculator',
      home: Scaffold(
        backgroundColor: Colors.blueGrey[900],
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: background ?? main_background,
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                child: IconButton(
                  icon: Icon(Icons.settings),
                  iconSize: 40,
                  onPressed: () {
                    Navigator.pushNamed(context, '/settings');
                  },
                ),
                alignment: Alignment.topRight,
                padding: EdgeInsets.only(right: 10),
              ),
              Container(
                child: Text(
                  _history,
                  style: GoogleFonts.rubik(
                    textStyle: TextStyle(
                      fontSize: 30,
                      color: expressionColor,
                    ),
                  ),
                ),
                alignment: Alignment.topRight,
                padding: EdgeInsets.only(right: 20),
              ),
              Container(
                child: Text(
                  _expression,
                  style: GoogleFonts.rubik(
                    textStyle: TextStyle(
                      fontSize: expressionSize,
                      color: expressionColor,
                    ),
                  ),
                ),
                alignment: Alignment.topRight,
                padding: EdgeInsets.all(12),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CalcBtn(
                    text: 'AC',
                    callback: allClear,
                    textColor: clearTextColor,
                    fillColor: clearButtonColor,
                  ),
                  CalcBtn(
                    text: 'C',
                    textColor: clearTextColor,
                    fillColor: clearButtonColor,
                    callback: clear,
                  ),
                  CalcBtn(
                    text: '%',
                    textColor: symbolTextColor,
                    callback: numClick,
                    fillColor: symbolButtonColor,
                  ),
                  CalcBtn(
                    text: '/',
                    textColor: symbolTextColor,
                    callback: numClick,
                    fillColor: symbolButtonColor,
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CalcBtn(
                    text: '7',
                    textColor: numberTextColor,
                    fillColor: numberButtonColor,
                    callback: numClick,
                  ),
                  CalcBtn(
                    text: '8',
                    textColor: numberTextColor,
                    fillColor: numberButtonColor,
                    callback: numClick,
                  ),
                  CalcBtn(
                    text: '9',
                    textColor: numberTextColor,
                    fillColor: numberButtonColor,
                    callback: numClick,
                  ),
                  CalcBtn(
                    text: '*',
                    textColor: symbolTextColor,
                    callback: numClick,
                    fillColor: symbolButtonColor,
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CalcBtn(
                    text: '4',
                    textColor: numberTextColor,
                    fillColor: numberButtonColor,
                    callback: numClick,
                  ),
                  CalcBtn(
                    text: '5',
                    textColor: numberTextColor,
                    fillColor: numberButtonColor,
                    callback: numClick,
                  ),
                  CalcBtn(
                    text: '6',
                    textColor: numberTextColor,
                    fillColor: numberButtonColor,
                    callback: numClick,
                  ),
                  CalcBtn(
                    text: '-',
                    textColor: symbolTextColor,
                    callback: numClick,
                    fillColor: symbolButtonColor,
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CalcBtn(
                    text: '1',
                    textColor: numberTextColor,
                    fillColor: numberButtonColor,
                    callback: numClick,
                  ),
                  CalcBtn(
                    text: '2',
                    textColor: numberTextColor,
                    fillColor: numberButtonColor,
                    callback: numClick,
                  ),
                  CalcBtn(
                    text: '3',
                    textColor: numberTextColor,
                    fillColor: numberButtonColor,
                    callback: numClick,
                  ),
                  CalcBtn(
                    text: '+',
                    textColor: symbolTextColor,
                    fillColor: symbolButtonColor,
                    callback: numClick,
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CalcBtn(
                    text: '0',
                    textColor: numberTextColor,
                    fillColor: numberButtonColor,
                    callback: numClick,
                  ),
                  CalcBtn(
                    text: '00',
                    textColor: numberTextColor,
                    fillColor: numberButtonColor,
                    callback: numClick,
                  ),
                  CalcBtn(
                    text: '.',
                    textColor: numberTextColor,
                    fillColor: numberButtonColor,
                    callback: numClick,
                  ),
                  CalcBtn(
                    text: '=',
                    textColor: equalTextColor,
                    fillColor: equalButtonColor,
                    callback: eveluate,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

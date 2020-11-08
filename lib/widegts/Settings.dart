import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';

class CalculatorSettings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

extension HexColor on Color {
  /// String is in the format "aabbcc" or "ffaabbcc" with an optional leading "#".
  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }

  /// Prefixes a hash sign if [leadingHashSign] is set to `true` (default is `true`).
  String toHex({bool leadingHashSign = true}) => '${leadingHashSign ? '#' : ''}'
      '${alpha.toRadixString(16).padLeft(2, '0')}'
      '${red.toRadixString(16).padLeft(2, '0')}'
      '${green.toRadixString(16).padLeft(2, '0')}'
      '${blue.toRadixString(16).padLeft(2, '0')}';
}

class _SettingsState extends State<CalculatorSettings> {
  Color expressionColor = Colors.blueGrey[700];
  Color numberButtonColor = Colors.blueGrey[900];
  Color symbolButtonColor = Colors.white;
  Color equalButtonColor = Colors.purple[800];
  Color clearButtonColor = Colors.cyan[900];
  Color numberTextColor = Colors.white;
  Color symbolTextColor = Colors.blueGrey[900];
  Color equalTextColor = Colors.white;
  Color clearTextColor = Colors.white;
  FileImage background = null;
  AssetImage main_background = AssetImage("images/02.jpg");
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

  _SettingsState() {
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
  void changeEpressionColor(Color color) =>
      setState(() => expressionColor = color);
  void changeNumberColor(Color color) =>
      setState(() => numberButtonColor = color);
  void changeSymbolColor(Color color) =>
      setState(() => symbolButtonColor = color);
  void changeEqualColor(Color color) =>
      setState(() => equalButtonColor = color);
  void changeClearColor(Color color) =>
      setState(() => clearButtonColor = color);
  void changeNumberTextColor(Color color) =>
      setState(() => numberTextColor = color);
  void changeSymbolTextColor(Color color) =>
      setState(() => symbolTextColor = color);
  void changeEqualTextColor(Color color) =>
      setState(() => equalTextColor = color);
  void changeClearTextColor(Color color) =>
      setState(() => clearTextColor = color);
  void saveSettings() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('expressionColor', expressionColor.toHex());
    await prefs.setString('numberButtonColor', numberButtonColor.toHex());
    await prefs.setString('symbolButtonColor', symbolButtonColor.toHex());
    await prefs.setString('equalButtonColor', equalButtonColor.toHex());
    await prefs.setString('clearButtonColor', clearButtonColor.toHex());
    await prefs.setString('numberTextColor', numberTextColor.toHex());
    await prefs.setString('symbolTextColor', symbolTextColor.toHex());
    await prefs.setString('equalTextColor', equalTextColor.toHex());
    await prefs.setString('clearTextColor', clearTextColor.toHex());
    Fluttertoast.showToast(
        msg: "Saved succesfully. please restart <3",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.TOP,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0);
    print('saved');
  }

  final picker = ImagePicker();
  Future<FileImage> getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    Directory appDocDir = await getApplicationDocumentsDirectory();
    String appDocPath = appDocDir.path;
    if (pickedFile != null) {
      File _image = File(pickedFile.path);
      final fileName = basename(_image.path);
      final File localImage = await _image.copy('$appDocPath/$fileName');
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('background', localImage.path);
      return FileImage(localImage);
    } else {
      print('No image selected.');
    }
    return null;
  }

  Future<FileImage> getBackground() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return FileImage(
        File(prefs.getString('background') ?? AssetImage("images/02.jpg")));
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Settings',
      home: Scaffold(
        backgroundColor: Colors.blue[900],
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: background ?? main_background,
              fit: BoxFit.cover,
            ),
          ),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(.7),
            ),
            padding: EdgeInsets.fromLTRB(10, 40, 10, 40),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Container(
                      margin: EdgeInsets.all(5),
                      padding: EdgeInsets.all(10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Expression & Result Color',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                            ),
                          ),
                          SizedBox(
                            width: 60,
                            height: 20,
                            child: RaisedButton(
                              elevation: 3.0,
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: Text('Select a color'),
                                      content: SingleChildScrollView(
                                        child: MaterialPicker(
                                          pickerColor: expressionColor,
                                          onColorChanged: changeEpressionColor,
                                        ),
                                      ),
                                    );
                                  },
                                );
                              },
                              child: const Text(''),
                              color: expressionColor,
                              textColor: useWhiteForeground(expressionColor)
                                  ? const Color(0xffffffff)
                                  : const Color(0xff000000),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.all(5),
                      padding: EdgeInsets.all(10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Number Buttons Color',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                            ),
                          ),
                          SizedBox(
                            width: 60,
                            height: 20,
                            child: RaisedButton(
                              elevation: 3.0,
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: Text('Select a color'),
                                      content: SingleChildScrollView(
                                        child: MaterialPicker(
                                          pickerColor: numberButtonColor,
                                          onColorChanged: changeNumberColor,
                                        ),
                                      ),
                                    );
                                  },
                                );
                              },
                              child: const Text(''),
                              color: numberButtonColor,
                              textColor: useWhiteForeground(numberButtonColor)
                                  ? const Color(0xffffffff)
                                  : const Color(0xff000000),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.all(5),
                      padding: EdgeInsets.all(10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Symbol Buttons Color',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                            ),
                          ),
                          SizedBox(
                            width: 60,
                            height: 20,
                            child: RaisedButton(
                              elevation: 3.0,
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: Text('Select a color'),
                                      content: SingleChildScrollView(
                                        child: MaterialPicker(
                                          pickerColor: symbolButtonColor,
                                          onColorChanged: changeSymbolColor,
                                        ),
                                      ),
                                    );
                                  },
                                );
                              },
                              child: const Text(''),
                              color: symbolButtonColor,
                              textColor: useWhiteForeground(symbolButtonColor)
                                  ? const Color(0xffffffff)
                                  : const Color(0xff000000),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.all(5),
                      padding: EdgeInsets.all(10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Clear Buttons Color',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                            ),
                          ),
                          SizedBox(
                            width: 60,
                            height: 20,
                            child: RaisedButton(
                              elevation: 3.0,
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: Text('Select a color'),
                                      content: SingleChildScrollView(
                                        child: MaterialPicker(
                                          pickerColor: clearButtonColor,
                                          onColorChanged: changeClearColor,
                                        ),
                                      ),
                                    );
                                  },
                                );
                              },
                              child: const Text(''),
                              color: clearButtonColor,
                              textColor: useWhiteForeground(clearButtonColor)
                                  ? const Color(0xffffffff)
                                  : const Color(0xff000000),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.all(5),
                      padding: EdgeInsets.all(10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Equal Button Color',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                            ),
                          ),
                          SizedBox(
                            width: 60,
                            height: 20,
                            child: RaisedButton(
                              elevation: 3.0,
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: Text('Select a color'),
                                      content: SingleChildScrollView(
                                        child: MaterialPicker(
                                          pickerColor: equalButtonColor,
                                          onColorChanged: changeEqualColor,
                                        ),
                                      ),
                                    );
                                  },
                                );
                              },
                              child: const Text(''),
                              color: equalButtonColor,
                              textColor: useWhiteForeground(equalButtonColor)
                                  ? const Color(0xffffffff)
                                  : const Color(0xff000000),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.all(5),
                      padding: EdgeInsets.all(10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Number Text Color',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                            ),
                          ),
                          SizedBox(
                            width: 60,
                            height: 20,
                            child: RaisedButton(
                              elevation: 3.0,
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: Text('Select a color'),
                                      content: SingleChildScrollView(
                                        child: MaterialPicker(
                                          pickerColor: numberTextColor,
                                          onColorChanged: changeNumberTextColor,
                                        ),
                                      ),
                                    );
                                  },
                                );
                              },
                              child: const Text(''),
                              color: numberTextColor,
                              textColor: useWhiteForeground(numberTextColor)
                                  ? const Color(0xffffffff)
                                  : const Color(0xff000000),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.all(5),
                      padding: EdgeInsets.all(10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Symbol Buttons Color',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                            ),
                          ),
                          SizedBox(
                            width: 60,
                            height: 20,
                            child: RaisedButton(
                              elevation: 3.0,
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: Text('Select a color'),
                                      content: SingleChildScrollView(
                                        child: MaterialPicker(
                                          pickerColor: symbolTextColor,
                                          onColorChanged: changeSymbolTextColor,
                                        ),
                                      ),
                                    );
                                  },
                                );
                              },
                              child: const Text(''),
                              color: symbolTextColor,
                              textColor: useWhiteForeground(symbolTextColor)
                                  ? const Color(0xffffffff)
                                  : const Color(0xff000000),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.all(5),
                      padding: EdgeInsets.all(10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Clear Buttons Color',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                            ),
                          ),
                          SizedBox(
                            width: 60,
                            height: 20,
                            child: RaisedButton(
                              elevation: 3.0,
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: Text('Select a color'),
                                      content: SingleChildScrollView(
                                        child: MaterialPicker(
                                          pickerColor: clearTextColor,
                                          onColorChanged: changeClearTextColor,
                                        ),
                                      ),
                                    );
                                  },
                                );
                              },
                              child: const Text(''),
                              color: clearTextColor,
                              textColor: useWhiteForeground(clearTextColor)
                                  ? const Color(0xffffffff)
                                  : const Color(0xff000000),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.all(5),
                      padding: EdgeInsets.all(10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Equal Button Color',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                            ),
                          ),
                          SizedBox(
                            width: 60,
                            height: 20,
                            child: RaisedButton(
                              elevation: 3.0,
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: Text('Select a color'),
                                      content: SingleChildScrollView(
                                        child: MaterialPicker(
                                          pickerColor: equalTextColor,
                                          onColorChanged: changeEqualTextColor,
                                        ),
                                      ),
                                    );
                                  },
                                );
                              },
                              child: const Text(''),
                              color: equalTextColor,
                              textColor: useWhiteForeground(equalTextColor)
                                  ? const Color(0xffffffff)
                                  : const Color(0xff000000),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.all(5),
                      padding: EdgeInsets.all(10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Background Image',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                            ),
                          ),
                          SizedBox(
                            width: 150,
                            height: 30,
                            child: RaisedButton(
                              elevation: 3.0,
                              onPressed: getImage,
                              child: const Text('choose image'),
                              color: Colors.white,
                              textColor: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Center(
                  child: Container(
                    child: FloatingActionButton(
                      child: Text('save'),
                      onPressed: saveSettings,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

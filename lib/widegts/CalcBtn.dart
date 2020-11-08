import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tofaha_calculator/main.dart';

class CalcBtn extends StatelessWidget {
  final String text;
  final Color textColor;
  final Color fillColor;
  final Function callback;
  CalcBtn({Key key, this.text, this.textColor, this.fillColor, this.callback})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(5),
      child: SizedBox(
        width: 50,
        height: 50,
        child: FloatingActionButton(
          heroTag: text,
          child: Text(text,
              style: GoogleFonts.rubik(
                  textStyle: TextStyle(
                fontSize: 24,
                color: textColor,
              ))),
          onPressed: () {
            callback(text);
          },
          elevation: 0,
          backgroundColor: fillColor,
        ),
      ),
    );
  }
}

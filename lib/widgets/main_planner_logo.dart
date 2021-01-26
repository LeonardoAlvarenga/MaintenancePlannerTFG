import 'package:flutter/material.dart';

class MainPlannerLogo extends StatelessWidget {
  final Color primaryColor;
  final Color secundaryColor;
  final Color toolColor;
  final bool border;
  final String fontFamilyString;

  MainPlannerLogo({
    this.fontFamilyString,
    this.primaryColor = Colors.black,
    this.secundaryColor = Colors.blueGrey,
    this.toolColor = Colors.black,
    this.border = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.transparent,
        border: border ? Border.all() : null,
      ),
      height: 150,
      width: 200,
      child: Stack(
        children: <Widget>[
//
// >> MAIN <<
//
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              height: 100,
              width: 200,
              child: FittedBox(
                child: ShaderMask(
                  shaderCallback: (bounds) => LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        secundaryColor,
                        primaryColor,
                        primaryColor,
                        secundaryColor,
                        primaryColor,
                        primaryColor,
                        secundaryColor,
                      ]).createShader(bounds),
                  child: Text(
                    'MAIN',
                    style: TextStyle(
                      fontFamily: fontFamilyString,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.justify,
                  ),
                ),
              ),
            ),
          ),
//
// >> PLANNER <<
//
          Positioned(
            top: 75,
            left: 0,
            right: 0,
            child: Container(
              height: 60,
              width: 200,
              child: FittedBox(
                child: ShaderMask(
                  shaderCallback: (bounds) => LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        primaryColor,
                        primaryColor,
                        primaryColor,
                        secundaryColor,
                        primaryColor,
                        secundaryColor,
                        primaryColor,
                        primaryColor,
                        secundaryColor,
                        primaryColor,
                        primaryColor,
                        primaryColor,
                        primaryColor,
                        secundaryColor,
                        primaryColor,
                      ]).createShader(bounds),
                  child: Text(
                    'PLANNER',
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                      fontFamily: fontFamilyString,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

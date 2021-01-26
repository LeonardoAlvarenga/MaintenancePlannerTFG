import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'package:tfg_app/widgets/main_planner_logo.dart';

class LoadingScreen extends StatelessWidget {
  final String loadingMessage;

  LoadingScreen({this.loadingMessage = 'Carregando...'});

  static const routeName = '/loading-screen';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 25),
              SpinKitFoldingCube(
                size: 60,
                itemBuilder: (context, index) {
                  return DecoratedBox(
                    decoration: BoxDecoration(
                      color: index.isEven
                          ? Theme.of(context).primaryColorDark
                          : Theme.of(context).accentColor,
                    ),
                  );
                },
              ),
              SizedBox(height: 30),
              Text(loadingMessage, style: TextStyle(fontSize: 18)),
            ],
          ),
          Positioned(
            right: 10,
            bottom: 10,
            child: Container(
              width: 80,
              child: FittedBox(
                child: MainPlannerLogo(
                  primaryColor: Theme.of(context).primaryColorDark,
                  secundaryColor: Colors.black,
                  fontFamilyString: 'Audiowide',
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

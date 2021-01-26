import 'package:flutter/material.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';


import 'package:tfg_app/tests/screens/tester_quantitativeListTile.dart';

class TesterScreen extends StatelessWidget {
  static const routeName = '/tester-screen';

  final List<Widget> _listOfScreens = [
    TesterQuantitativeListTile(),

  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: _listOfScreens.length,
      child: Scaffold(
        appBar: AppBar(title: Text('Testando!!')),
        body: TabBarView(children: _listOfScreens),
        bottomNavigationBar: ConvexAppBar(
          color: Colors.grey,
          backgroundColor: Theme.of(context).primaryColorDark,
          initialActiveIndex: 0,
          items: [
            TabItem(
              icon: Icon(
                Icons.view_agenda,
              ),
              title: 'ListTile',
            ),
            TabItem(
              icon: Icon(
                Icons.device_unknown,
              ),
              title: 'None',
            ),
          ],
        ),
      ),
    );
  }
}

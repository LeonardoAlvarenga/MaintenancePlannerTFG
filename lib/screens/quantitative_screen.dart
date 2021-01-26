import 'package:flutter/material.dart';

import '../models/quantitative.dart';
import '../widgets/quantitative_item.dart';

class QuantitativeScreen extends StatefulWidget {
  @override
  _QuantitativeScreenState createState() => _QuantitativeScreenState();
}

class _QuantitativeScreenState extends State<QuantitativeScreen> {
  final List<Quantitative> _quantitativeList = [
    Quantitative(
      id: DateTime.now(),
      parameterName: 'Temperatura',
      minValue: 100,
      maxValue: 200,
      unitName: 'Ozadia',
    ),
    Quantitative(
      id: DateTime.now(),
      parameterName: 'Pressão',
      minValue: 100,
      maxValue: 200,
      unitName: 'Ozadia',
    ),
    Quantitative(
      id: DateTime.now(),
      parameterName: 'Temperatura',
      minValue: 100,
      maxValue: 200,
      unitName: 'Ozadia',
    ),
    Quantitative(
      id: DateTime.now(),
      parameterName: 'Pressão',
      minValue: 100,
      maxValue: 200,
      unitName: 'Ozadia',
    ),
    Quantitative(
      id: DateTime.now(),
      parameterName: 'Temperatura',
      minValue: 100,
      maxValue: 200,
      unitName: 'Ozadia',
    ),
    Quantitative(
      id: DateTime.now(),
      parameterName: 'Pressão',
      minValue: 100,
      maxValue: 200,
      unitName: 'Ozadia',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        padding: const EdgeInsets.only(top: 10),
        itemCount: _quantitativeList.length,
        itemBuilder: (ctx, index) {
          return QuantitativeItem(_quantitativeList[index]);
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        label: Text('Quantitativo'),
        icon: Icon(Icons.add),
        backgroundColor: Theme.of(context).accentColor.withOpacity(.85),
      ),
    );
  }
}

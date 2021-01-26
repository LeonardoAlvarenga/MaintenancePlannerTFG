import 'package:flutter/material.dart';

import 'package:tfg_app/widgets/qualitative_item.dart';

import '../models/qualitative.dart';

class QualitativeScreen extends StatefulWidget {
  @override
  _QualitativeScreenState createState() => _QualitativeScreenState();
}

class _QualitativeScreenState extends State<QualitativeScreen> {
  final List<Qualitative> _qualitativeList = [
    Qualitative(
        parameterName: 'Furo Pneu',
        parameterDescription: 'Observar se o Pneu está furado.',
        id: DateTime.now()),
    Qualitative(
        parameterName: 'Partículas Magnéticas',
        parameterDescription:
            'A descrição pode ser BASTANTE extensa, o que talvez se faça útil a utilização de uma SingleChildScrollView para visualizá-la... Dentro, é claro, de seu item... A descrição pode ser BASTANTE extensa, o que talvez se faça útil a utilização de uma SingleChildScrollView para visualizá-la... Dentro, é claro, de seu item... A descrição pode ser BASTANTE extensa, o que talvez se faça útil a utilização de uma SingleChildScrollView para visualizá-la... Dentro, é claro, de seu item... A descrição pode ser BASTANTE extensa, o que talvez se faça útil a utilização de uma SingleChildScrollView para visualizá-la... Dentro, é claro, de seu item...',
        id: DateTime.now()),
    Qualitative(
        parameterName: 'Líquidos Penetrantes',
        parameterDescription: 'Nada.',
        id: DateTime.now()),
    Qualitative(
        parameterName: 'Líquidos Penetrantes',
        parameterDescription: 'Nada.',
        id: DateTime.now()),
    Qualitative(
        parameterName: 'Líquidos Penetrantes',
        parameterDescription: 'Nada.',
        id: DateTime.now()),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        padding: const EdgeInsets.only(top: 10),
        itemCount: _qualitativeList.length,
        itemBuilder: (ctx, index) {
          return QualitativeItem(_qualitativeList[index]);
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        label: Text('Qualitativo'),
        icon: Icon(Icons.add),
        backgroundColor: Theme.of(context).accentColor.withOpacity(.85),
      ),
    );
  }
}

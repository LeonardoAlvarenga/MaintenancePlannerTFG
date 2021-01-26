/* 
  Card para Input de usuário. QUALITATIVO.
  Função _addParameter usada para chamar o ponteiro recebido via main.dart...
  A função apontada pelo selectHandler(dentro de _addParameter) irá solocitar uma nova instância de QUALITATIVO para os
  valores por nós informados e, então, irá chamar setState.
*/

import 'package:flutter/material.dart';

class AddQualitative extends StatefulWidget {
  final Function selectHandler;

  AddQualitative({@required this.selectHandler});

  @override
  _AddQualitativeState createState() => _AddQualitativeState();
}

class _AddQualitativeState extends State<AddQualitative> {
  final parameterNameController = TextEditingController();
  final parameterDescriptionController = TextEditingController();

  void _addParameter() {
    final nameParameter = parameterNameController.text;
    final descriptionParameter = parameterDescriptionController.text;

    if (nameParameter.isNotEmpty && descriptionParameter.isNotEmpty) {
      widget.selectHandler(
        nameParameter,
        descriptionParameter,
      );
    } else {
      return;
    }

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            Container(
              child: Text(
                'Parâmetros Qualitativos',
                style: Theme.of(context).textTheme.headline3,
                textAlign: TextAlign.center,
              ),
              width: double.infinity,
            ),
// User Parameter Name
            TextField(
              style: Theme.of(context).textTheme.bodyText1,
              controller: parameterNameController,
              decoration: InputDecoration(
                labelText: 'Nome Parâmetro (Ex.: Furo Pneu)',
                labelStyle: Theme.of(context).textTheme.bodyText2,
              ),
              onSubmitted: (_) {
                _addParameter();
              },
            ),
// User Description
            TextField(
              style: Theme.of(context).textTheme.bodyText1,
              controller: parameterDescriptionController,
              decoration: InputDecoration(
                labelText: 'Descrição',
                labelStyle: Theme.of(context).textTheme.bodyText2,
              ),
              onSubmitted: (_) {
                _addParameter();
              },
            ),
// User Confirm Button
            FlatButton(
              color: Theme.of(context).buttonColor,
              child: Text("Confirmar Parâmetro"),
              onPressed: _addParameter,
            ),
          ],
        ),
      ),
    );
  }
}

/* 
  Card para Input de usuário. QUANTITATIVO.
  Função _addParameter usada para chamar o ponteiro recebido via main.dart...
  A função apontada pelo selectHandler(dentro de _addParameter) irá solocitar uma nova instância de QUANTITATIVO para os
  valores por nós informados e, então, irá chamar setState.
*/

import 'package:flutter/material.dart';

class AddQuantitative extends StatefulWidget {
  final Function selectHandler;

  AddQuantitative({@required this.selectHandler});

  @override
  _AddQuantitativeState createState() => _AddQuantitativeState();
}

class _AddQuantitativeState extends State<AddQuantitative> {
  final parameterNameController = TextEditingController();
  final minValueController = TextEditingController();
  final maxValueController = TextEditingController();
  final unitController = TextEditingController();

  void _addParameter() {
    final parameterText = parameterNameController.text;
    final minValueText = minValueController.text;
    final maxValueText = maxValueController.text;
    final unitText = unitController.text;

    if (parameterText.isNotEmpty &&
        minValueText.isNotEmpty &&
        maxValueText.isNotEmpty &&
        unitText.isNotEmpty) {
      final minValue = double.parse(minValueText);
      final maxValue = double.parse(maxValueText);
      if (minValue < maxValue) {
        widget.selectHandler(
          parameterText,
          minValue,
          maxValue,
          unitText,
        );
      } else {
        return;
      }
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
                'Parâmetros Quantitativos',
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
                labelText: 'Parâmetro (Ex.: Pressão, Temperatura, Vibração...)',
                labelStyle: Theme.of(context).textTheme.bodyText2,
              ),
              onSubmitted: (_) {
                _addParameter();
              },
            ),
// User Minimum Value Declaration
            Row(
              children: <Widget>[
                Container(
                  width: 150,
                  child: TextField(
                    style: Theme.of(context).textTheme.bodyText1,
                    controller: minValueController,
                    keyboardType:
                        TextInputType.numberWithOptions(decimal: true),
                    decoration: InputDecoration(
                      labelText: 'Valor Mínimo',
                      labelStyle: Theme.of(context).textTheme.bodyText2,
                    ),
                    onSubmitted: (_) {
                      _addParameter();
                    },
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                Container(
                  width: 150,
                  child: TextField(
                    style: Theme.of(context).textTheme.bodyText1,
                    controller: maxValueController,
                    keyboardType:
                        TextInputType.numberWithOptions(decimal: true),
                    decoration: InputDecoration(
                      labelText: 'Valor Máximo',
                      labelStyle: Theme.of(context).textTheme.bodyText2,
                    ),
                    onSubmitted: (_) {
                      _addParameter();
                    },
                  ),
                ),
              ],
            ),
// User Maximum Value Declaration
            TextField(
              style: Theme.of(context).textTheme.bodyText1,
              controller: unitController,
              decoration: InputDecoration(
                labelText: 'Unidade de Medida',
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

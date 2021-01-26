import 'package:flutter/material.dart';

class ErrorAlertDialog extends StatelessWidget {
  final Function setParentState;

  ErrorAlertDialog({@required this.setParentState});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Erro'),
      content: Text('Não foi possível se comunicar com o servidor.'),
      actions: [
        FlatButton(
          onPressed: () {
            setParentState();
            Navigator.of(context).pop();
          },
          child: Text('Ok'),
        )
      ],
    );
  }
}

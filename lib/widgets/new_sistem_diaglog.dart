import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';

import 'package:tfg_app/screens/equipment_register/03_0_selected_system_screen.dart';
import 'package:tfg_app/providers/services/database.dart';

class NewSystemDialog extends StatefulWidget {
  final DocumentReference reference;
  // final DatabaseServices databaseServices;

  const NewSystemDialog({
    @required this.reference,
    // @required this.databaseServices,
  });

  @override
  _NewSystemDialogState createState() => _NewSystemDialogState();
}

class _NewSystemDialogState extends State<NewSystemDialog> {
  bool _isLoading = false;
  final _formStateKey = GlobalKey<FormState>();
  String _systemName;

  Future<void> _addNewSystem() async {
    setState(() {
      _isLoading = true;
    });
    if (_formStateKey.currentState.validate()) {
      try {
        final _systemReference =
            await Provider.of<DatabaseServices>(context, listen: false)
                .addNewSystem(systemName: _systemName);

        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => SelectedSystem(
                systemName: _systemName, systemReference: _systemReference),
          ),
        );
      } catch (error) {
        print(error);
        Navigator.of(context).pop();
      }
    }
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      title: Text('Adicionar novo sistema'),
      contentPadding: const EdgeInsets.all(15),
      children: [
        Form(
          key: _formStateKey,
          child: TextFormField(
            validator: (value) =>
                value == null ? 'Informe um nome para o sistema.' : null,
            onChanged: (value) => _systemName = value,
            decoration: InputDecoration(
              labelText: 'Nome do Sistema',
              border: OutlineInputBorder(),
            ),
          ),
        ),
        SizedBox(height: 10),
        _isLoading
            ? Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(
                      Theme.of(context).primaryColorDark,
                    ),
                  ),
                ],
              )
            : RaisedButton(
                onPressed: _addNewSystem,
                child: Text('Confirmar'),
              ),
      ],
    );
  }
}

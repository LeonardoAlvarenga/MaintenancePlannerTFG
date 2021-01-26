import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:tfg_app/providers/equipment_provider.dart';
import 'package:tfg_app/widgets/date_picker_and_preview_widget.dart';

class AddNewMaintenanceSheet extends StatefulWidget {
  final DocumentReference documentReference;

  AddNewMaintenanceSheet({
    @required this.documentReference,
  });

  @override
  _AddNewMaintenanceSheetState createState() => _AddNewMaintenanceSheetState();
}

class _AddNewMaintenanceSheetState extends State<AddNewMaintenanceSheet> {
  final _formStateKey = GlobalKey<FormState>();
  final _dateControllerPreview = TextEditingController();
  final _dateControllerIso = TextEditingController();

  bool _isLoading = false;
  String _maintenancePlanName;
  int _frequencyInDays;
  String _lastInspectionDateIso;

  @override
  void dispose() {
    _dateControllerPreview.dispose();
    _dateControllerIso.dispose();
    super.dispose();
  }

  void confirm() {
    if (_formStateKey.currentState.validate()) {
      try {
        _formStateKey.currentState.save();
        _lastInspectionDateIso = _dateControllerIso.text;
        final newPlan = MaintenancePlanModel(
          id: DateTime.now().toString(),
          name: _maintenancePlanName,
          listOfQualitatives: [],
          listOfQuantitatives: [],
          frequencyInDays: _frequencyInDays,
          lastInspectionDateIso: _lastInspectionDateIso,
        );
        Navigator.of(context).pop(newPlan);
      } catch (error) {
        print(error);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      title: Text('Adicionar Novo Plano de Manutenção'),
      contentPadding: const EdgeInsets.all(15),
      children: [
        Form(
          key: _formStateKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 25),
                TextFormField(
                  validator: (value) => value == null
                      ? 'Informe um nome para o plano de manutenção.'
                      : null,
                  onChanged: (value) => _maintenancePlanName = value,
                  decoration: InputDecoration(
                    labelText: 'Nome do Plano',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 25),
                FittedBox(
                  child: DatePickerAndPreviewWidget(
                    dateControllerPreview: _dateControllerPreview,
                    dateControllerIso: _dateControllerIso,
                    errorMessage:
                        'Informe o dia da última vez que essa inspeção foi realizada.',
                    dateLabel: 'Útilma inspeção',
                  ),
                ),
                SizedBox(height: 25),
                TextFormField(
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null) {
                      return 'Informe a frequência da manutenção(Em dias).';
                    } else {
                      return null;
                    }
                  },
                  onSaved: (value) => _frequencyInDays = int.parse(value),
                  decoration: InputDecoration(
                    labelText: 'Frequência da Manutenção (Dias)',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 10),
              ],
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
                onPressed: () {
                  confirm();
                },
                child: Text('Confirmar'),
              ),
      ],
    );
  }
}

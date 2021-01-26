import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

import 'package:tfg_app/widgets/date_picker_and_preview_widget.dart';
import 'package:tfg_app/screens/equipment_register/02_0_systems_screen.dart';
import 'package:tfg_app/providers/equipment_provider.dart';
import 'package:tfg_app/providers/services/database.dart';
import 'package:tfg_app/screens/loading_screen.dart';

class EquipmentRegisterScreen extends StatefulWidget {
  static const routeName = '/equipment-register-screen';

  @override
  _EquipmentRegisterScreenState createState() =>
      _EquipmentRegisterScreenState();
}

class _EquipmentRegisterScreenState extends State<EquipmentRegisterScreen> {
  bool _isLoading = false;
  bool _isInit = false;
  final _generalFormKey = GlobalKey<FormState>();

  // FocusNode
  final _equipNameFocus = FocusNode();
  final _dateFocus = FocusNode();
  final _locationFocus = FocusNode();

  // input variables
  List<bool> _selections = List.generate(5, (_) => false);
  String _equipName = '';
  String _selectedInitialDate = '';
  String _location = '';
  int _criticity;
  final _dateControllerPreview = TextEditingController();
  final _dateControllerIso = TextEditingController();
  var _databaseServices;

  @override
  void initState() {
    _equipNameFocus.addListener(() {
      if (!_equipNameFocus.hasFocus) _updateValues();
    });
    _dateFocus.addListener(() {
      if (!_dateFocus.hasFocus) _updateValues();
    });
    _locationFocus.addListener(() {
      if (!_locationFocus.hasFocus) _updateValues();
    });
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (!_isInit) {
      final existingValues =
          Provider.of<GeneralEquipmentProvider>(context, listen: false)
              .existingValues;
      _equipName = existingValues.name;
      _selectedInitialDate = existingValues.acquisitionDateIsoString;
      _location = existingValues.location;
      _criticity = existingValues.equipCriticity;
      _selections[_criticity - 1] = true;

      _databaseServices = Provider.of<DatabaseServices>(context, listen: false);

      if (existingValues.acquisitionDateIsoString != '') {
        final initDate =
            DateTime.parse(existingValues.acquisitionDateIsoString);
        _dateControllerPreview.text = DateFormat('dd/MM/yyyy').format(initDate);
      }
      _isInit = true;
    }

    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _equipNameFocus.dispose();
    _dateFocus.dispose();
    _locationFocus.dispose();
    _dateControllerPreview.dispose();
    _dateControllerIso.dispose();
    super.dispose();
  }

  void _updateValues() {
    Provider.of<GeneralEquipmentProvider>(context, listen: false)
        .changeGeneralData(
      EquipmentGeneralData(
        name: _equipName,
        acquisitionDateIsoString: _selectedInitialDate,
        location: _location,
        equipCriticity: _criticity,
      ),
    );
  }

  Future<void> _addNewEquipment() async {
    if (_generalFormKey.currentState.validate()) {
      setState(() {
        _isLoading = true;
      });
      try {
        final newEquip = EquipmentGeneralData(
          name: _equipName,
          acquisitionDateIsoString: _dateControllerIso.text,
          location: _location,
          equipCriticity: _criticity,
        );
        final _equipmentReference =
            await _databaseServices.addNewEquipment(newEquip);

        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) =>
                SystemsScreen(_equipmentReference, _equipName),
          ),
        );
      } catch (error) {
        await showDialog(
          context: context,
          builder: (ctx) {
            return AlertDialog(
              title: Text('Erro'),
              content: Text('Não foi possível se comunicar com o servidor.'),
              actions: [
                FlatButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    setState(() {
                      _isLoading = false;
                    });
                  },
                  child: Text('Ok'),
                )
              ],
            );
          },
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? LoadingScreen(
            loadingMessage: 'Contatando o sevidor...',
          )
        : Scaffold(
            appBar: AppBar(title: Text('Dados Gerais')),
            body: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () {
                FocusScope.of(context).requestFocus(new FocusNode());
              },
              child: Container(
                padding: EdgeInsets.all(15),
                child: Form(
                  key: _generalFormKey,
                  child: SingleChildScrollView(
                    child: Column(
                      children: <Widget>[
                        SizedBox(height: 10),

                        // Nome do Equipamento
                        TextFormField(
                          validator: (value) {
                            if (value == null || value == '') {
                              return 'Informe o nome do equipamento.';
                            } else {
                              return null;
                            }
                          },
                          onFieldSubmitted: (_) {
                            _dateFocus.requestFocus();
                          },
                          textInputAction: TextInputAction.next,
                          focusNode: _equipNameFocus,
                          initialValue: _equipName,
                          onChanged: (value) {
                            _equipName = value;
                          },
                          decoration: InputDecoration(
                            labelText: 'Nome do Equipamento',
                            border: OutlineInputBorder(),
                          ),
                        ),
                        SizedBox(height: 25),

                        // DatePicker - Início do Funcionamento
                        DatePickerAndPreviewWidget(
                          dateControllerPreview: _dateControllerPreview,
                          dateControllerIso: _dateControllerIso,
                          dateLabel: 'Início do Funcionamento',
                          errorMessage:
                              'Informe a data de compra do equipamento.',
                        ),

                        SizedBox(height: 25),

                        // Localização do Equipamento
                        TextFormField(
                          validator: (value) {
                            if (value == null || value == '') {
                              return 'Informe a localização do equipamento.';
                            } else {
                              return null;
                            }
                          },
                          focusNode: _locationFocus,
                          initialValue: _location,
                          onChanged: (value) {
                            _location = value;
                          },
                          decoration: InputDecoration(
                            labelText: 'Localização',
                            border: OutlineInputBorder(),
                          ),
                        ),
                        SizedBox(height: 25),

                        // Criticidade
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          margin: EdgeInsets.symmetric(horizontal: 30),
                          padding: EdgeInsets.all(15),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text('Criticidade do Equipamento'),
                              SizedBox(height: 10),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(
                                    'Menor',
                                    style: TextStyle(
                                        color: Colors.grey[600], fontSize: 12),
                                  ),
                                  Text(
                                    'Maior',
                                    style: TextStyle(
                                        color: Colors.grey[600], fontSize: 12),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              ToggleButtons(
                                fillColor: Theme.of(context).appBarTheme.color,
                                selectedColor: Colors.white,
                                children: [
                                  Text('1'),
                                  Text('2'),
                                  Text('3'),
                                  Text('4'),
                                  Text('5')
                                ],
                                isSelected: _selections,
                                onPressed: (index) {
                                  setState(() {
                                    _criticity = index + 1;
                                    for (int buttonIndex = 0;
                                        buttonIndex < _selections.length;
                                        buttonIndex++) {
                                      if (buttonIndex == index) {
                                        _selections[buttonIndex] = true;
                                      } else {
                                        _selections[buttonIndex] = false;
                                      }
                                    }
                                    _updateValues();
                                  });
                                },
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 60),
                        RaisedButton(
                          child: Text('Salvar e Continuar'),
                          onPressed: _addNewEquipment,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
  }
}

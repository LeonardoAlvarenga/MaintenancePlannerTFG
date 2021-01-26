import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:intl/intl.dart';
import 'package:tfg_app/providers/new_equipment_provider.dart';

class GeneralFormScreen extends StatefulWidget {
  final double disponibleHeight;

  GeneralFormScreen(this.disponibleHeight);

  @override
  _GeneralFormScreenState createState() => _GeneralFormScreenState();
}

class _GeneralFormScreenState extends State<GeneralFormScreen> {
  final _generalFormKey = GlobalKey<FormState>();
  bool _isInit = false;

  // FocusNode
  final _equipNameFocus = FocusNode();
  final _dateFocus = FocusNode();
  final _locationFocus = FocusNode();
  final _systemFocus = FocusNode();
  final _subSystemFocus = FocusNode();
  final _componenteFocus = FocusNode();

  // input variables
  List<bool> _selections = List.generate(5, (_) => false);
  String _equipName = '';
  String _selectedInitialDate = '';
  String _location = '';
  String _system = '';
  String _subSystem = '';
  String _componente = '';
  int _criticity;
  final _dateController = TextEditingController();

  @override
  void initState() {
    _equipNameFocus.addListener(() {
      if (!_equipNameFocus.hasFocus) updateValues();
    });
    _dateFocus.addListener(() {
      if (!_dateFocus.hasFocus) updateValues();
    });
    _systemFocus.addListener(() {
      if (!_systemFocus.hasFocus) updateValues();
    });
    _subSystemFocus.addListener(() {
      if (!_subSystemFocus.hasFocus) updateValues();
    });
    _componenteFocus.addListener(() {
      if (!_componenteFocus.hasFocus) updateValues();
    });
    _locationFocus.addListener(() {
      if (!_locationFocus.hasFocus) updateValues();
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
      _location = existingValues.localization;
      _system = existingValues.system;
      _subSystem = existingValues.subSystem;
      _componente = existingValues.componente;
      _criticity = existingValues.equipCriticity;
      _selections[_criticity - 1] = true;

      if (existingValues.acquisitionDateIsoString != '') {
        final initDate =
            DateTime.parse(existingValues.acquisitionDateIsoString);
        _dateController.text = DateFormat('dd/MM/yyyy').format(initDate);
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
    _systemFocus.dispose();
    _subSystemFocus.dispose();
    _componenteFocus.dispose();
    _dateController.dispose();
    super.dispose();
  }

  void updateValues() {
    Provider.of<GeneralEquipmentProvider>(context, listen: false)
        .changeGeneralData(EquipmentGeneralData(
      name: _equipName,
      acquisitionDateIsoString: _selectedInitialDate,
      localization: _location,
      system: _system,
      subSystem: _subSystem,
      componente: _componente,
      equipCriticity: _criticity,
    ));
  }

  Future<void> _showDatePicker() async {
    try {
      final response = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1980),
        lastDate: DateTime.now(),
      );
      _dateController.text = DateFormat('dd/MM/yyyy').format(response);
      _selectedInitialDate = response.toIso8601String();
      updateValues();
      _locationFocus.requestFocus();
    } catch (error) {
      print(error);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        FocusScope.of(context).requestFocus(new FocusNode());
      },
      child: Container(
        padding: EdgeInsets.all(15),
        height: widget.disponibleHeight,
        child: Form(
          key: _generalFormKey,
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                SizedBox(height: 10),

                // Nome do Equipamento
                TextFormField(
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Container(
                      width: MediaQuery.of(context).size.width * .6,
                      child: TextFormField(
                        readOnly: true,
                        focusNode: _dateFocus,
                        textAlign: TextAlign.end,
                        controller: _dateController,
                        decoration: InputDecoration(
                          labelText: 'Início do Funcionamento',
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                    SizedBox(width: 15),
                    Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Theme.of(context).appBarTheme.color,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black,
                            blurRadius: 2.5,
                            spreadRadius: 0.2,
                            offset: Offset(
                              1.0,
                              2.5,
                            ), // shadow direction: bottom right
                          )
                        ],
                      ),
                      child: IconButton(
                        icon: Icon(
                          Icons.calendar_today,
                          color: Colors.white,
                        ),
                        onPressed: _showDatePicker,
                      ),
                    ),
                    SizedBox(width: 5),
                  ],
                ),
                SizedBox(height: 25),

                // Localização do Equipamento
                TextFormField(
                  focusNode: _locationFocus,
                  onFieldSubmitted: (value) {
                    _systemFocus.requestFocus();
                  },
                  textInputAction: TextInputAction.next,
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

                // Conjunto/Sistema
                TextFormField(
                  focusNode: _systemFocus,
                  onFieldSubmitted: (_) {
                    _subSystemFocus.requestFocus();
                  },
                  textInputAction: TextInputAction.next,
                  initialValue: _system,
                  onChanged: (value) {
                    _system = value;
                  },
                  decoration: InputDecoration(
                    labelText: 'Conjunto/Sistema',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 25),

                // SubConjunto/SubSistema
                TextFormField(
                  focusNode: _subSystemFocus,
                  onFieldSubmitted: (_) {
                    _componenteFocus.requestFocus();
                  },
                  textInputAction: TextInputAction.next,
                  initialValue: _subSystem,
                  onChanged: (value) {
                    _subSystem = value;
                  },
                  decoration: InputDecoration(
                    labelText: 'Subconjunto/Subsistema',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 25),

                // Componente
                TextFormField(
                  focusNode: _componenteFocus,
                  initialValue: _componente,
                  onChanged: (value) {
                    _componente = value;
                  },
                  onFieldSubmitted: (_) {
                    updateValues();
                  },
                  decoration: InputDecoration(
                    labelText: 'Componente',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 25),

                // Criticidade
                Container(
                  decoration: BoxDecoration(
                      border: Border.all(),
                      borderRadius: BorderRadius.circular(15)),
                  margin: EdgeInsets.symmetric(horizontal: 30),
                  padding: EdgeInsets.all(15),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text('Criticidade do Equipamento'),
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                            updateValues();
                          });
                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 60),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

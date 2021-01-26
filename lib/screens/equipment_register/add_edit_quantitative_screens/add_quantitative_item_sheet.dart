import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:tfg_app/models/units_models.dart';
import 'package:tfg_app/providers/equipment_provider.dart';

class AddItemBottomSheet extends StatefulWidget {
  @override
  _AddItemBottomSheetState createState() => _AddItemBottomSheetState();
}

class _AddItemBottomSheetState extends State<AddItemBottomSheet> {
  final _formKey = GlobalKey<FormState>();

  String _inspectionName = '';
  String _measureEquipName = '';
  String _description = '';
  String _greatnessName = '';
  String _selectedUnitName = '';
  String _minValue = '';
  String _maxValue = '';

  double _minValueNum;

  bool _isSelectedGreatness = false;
  final _allUnitsData = AllUnitsTypes.allUnitsTypes;

  void addNewQuantitativeItem() {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      final newQuantitative = QuantitativeModel(
        id: DateTime.now().toString(),
        description: _description,
        inspectionName: _inspectionName,
        measureEquipment: _measureEquipName,
        greatness: _greatnessName,
        chosenUnit: _selectedUnitName,
        minValue: _minValue,
        maxValue: _maxValue,
      );
      Provider.of<QuantitativeListProvider>(context, listen: false)
          .addNewQuantitative(newQuantitative);
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final _allUnitsTypes = _allUnitsData.keys.toList();

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Container(
        color: Theme.of(context).scaffoldBackgroundColor,
        padding:
            const EdgeInsets.only(right: 15, left: 15, bottom: 25, top: 10),
        height: MediaQuery.of(context).size.height * .9,
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                SizedBox(height: 5),
                TextFormField(
                  onSaved: (value) {
                    _inspectionName = value;
                  },
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Insira um nome, por favor.';
                    } else {
                      return null;
                    }
                  },
                  decoration: InputDecoration(
                    labelText: 'Nome da Inspeção',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(
                  height: 25,
                ),
                TextFormField(
                  onSaved: (value) {
                    _measureEquipName = value;
                  },
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Insira o nome do Equipamento de Medição, por favor.';
                    } else {
                      return null;
                    }
                  },
                  decoration: InputDecoration(
                    labelText: 'Equipamento de Medição',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(
                  height: 25,
                ),
                TextFormField(
                  onSaved: (value) {
                    if (value.isNotEmpty) {
                      _description = value;
                    } else {
                      _description = '';
                    }
                  },
                  maxLines: 5,
                  decoration: InputDecoration(
                    labelText: 'Descrição (Opcional)',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(
                  height: 25,
                ),
                DropdownButtonFormField(
                  validator: (_) {
                    if (!_isSelectedGreatness) {
                      return 'Selecione uma grandeza, por favor.';
                    } else {
                      return null;
                    }
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Grandeza',
                  ),
                  items: _allUnitsTypes
                      .map(
                        (measureName) => DropdownMenuItem(
                          child: Text(measureName),
                          value: measureName,
                        ),
                      )
                      .toList(),
                  onChanged: (measureName) {
                    setState(() {
                      _greatnessName = measureName;
                      _isSelectedGreatness = true;
                    });
                  },
                  onTap: () => setState(() {
                    _isSelectedGreatness = false;
                  }),
                ),
                if (_isSelectedGreatness)
                  SizedBox(
                    height: 15,
                  ),
                if (_isSelectedGreatness && _greatnessName != 'Outra...')
                  DropdownButtonFormField(
                    onSaved: (value) {},
                    validator: (value) {
                      if (!_isSelectedGreatness) {
                        return null;
                      }
                      if (value == null) {
                        return 'Selecione uma unidade, por favor.';
                      } else {
                        return null;
                      }
                    },
                    decoration: InputDecoration(
                        border: OutlineInputBorder(), labelText: 'Unidade'),
                    items: _allUnitsData[_greatnessName]
                        .keys
                        .map(
                          (unitName) => DropdownMenuItem(
                            child: Text(unitName),
                            value: unitName,
                          ),
                        )
                        .toList(),
                    onChanged: (unitName) {
                      setState(() {
                        _selectedUnitName = unitName;
                      });
                    },
                  ),
                if (_isSelectedGreatness && _greatnessName == 'Outra...')
                  TextFormField(
                    onSaved: (value) {
                      if (value == '' || value == null) {
                        return 'Informe uma unidade.';
                      }
                      return null;
                    },
                    onChanged: (value) => _selectedUnitName = value,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Unidade',
                    ),
                  ),
                SizedBox(
                  height: 25,
                ),
                Row(
                  children: <Widget>[
                    Container(
                      width: MediaQuery.of(context).size.width * .6,
                      child: TextFormField(
                        onSaved: (value) {
                          _minValue = value;
                        },
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Insira um valor mínimo, por favor.';
                          } else {
                            _minValueNum = double.parse(value);
                            return null;
                          }
                        },
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: 'Valor Mínimo',
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                    Spacer(),
                    Chip(
                      label: Text(_selectedUnitName),
                    ),
                    Spacer(),
                  ],
                ),
                SizedBox(height: 15),
                Row(
                  children: <Widget>[
                    Container(
                      width: MediaQuery.of(context).size.width * .6,
                      child: TextFormField(
                        onSaved: (value) {
                          _maxValue = value;
                        },
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Insira um valor máximo, por favor.';
                          }
                          if (_minValueNum != null) {
                            if (_minValueNum >= double.parse(value)) {
                              return 'O valor MAX deve ser maior que o MIN.';
                            } else {
                              return null;
                            }
                          } else {
                            return null;
                          }
                        },
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: 'Valor Máximo',
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: Chip(
                        label: Text(_selectedUnitName),
                      ),
                    ),
                    SizedBox(width: 10),
                  ],
                ),
                SizedBox(
                  height: 40,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    FlatButton.icon(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        icon: Icon(Icons.delete),
                        label: Text('Cancelar')),
                    RaisedButton.icon(
                      icon: Icon(
                        Icons.save_alt,
                        color: Colors.white,
                      ),
                      color: Theme.of(context).appBarTheme.color,
                      label: Text(
                        'Salvar Inspeção',
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () {
                        addNewQuantitativeItem();
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:tfg_app/providers/equipment_provider.dart';

class AddQualitativeItemSheet extends StatefulWidget {
  const AddQualitativeItemSheet({
    Key key,
  }) : super(key: key);

  @override
  _AddQualitativeItemSheetState createState() =>
      _AddQualitativeItemSheetState();
}

class _AddQualitativeItemSheetState extends State<AddQualitativeItemSheet> {
  final _formKey = GlobalKey<FormState>();

  String _inspectionName = '';
  String _description = '';
  String _answer1 = '';
  String _answer2 = '';
  String _answer3 = '';
  String _answer4 = '';
  String _answer5 = '';

  int _i = 0;

  void _addQualitativeItem() {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();

      final _listOfAnswers = [
        _answer1,
        _answer2,
        _answer3,
        _answer4,
        _answer5,
      ];

      final newItem = QualitativeModel(
        id: DateTime.now().toString(),
        inspectionName: _inspectionName,
        description: _description,
        answers: _listOfAnswers,
      );

      Provider.of<QualitativeListProvider>(context, listen: false)
          .addNewQualitative(newItem);
    }
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * .9,
      padding: const EdgeInsets.all(10),
      child: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              SizedBox(height: 25),
              TextFormField(
                validator: (value) {
                  if (value == null) {
                    return 'Informe o Nome da Inspeção, por favor.';
                  } else {
                    return null;
                  }
                },
                onSaved: (value) {
                  _inspectionName = value;
                },
                decoration: InputDecoration(
                  labelText: 'Nome da Inspeção',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 15),
              TextFormField(
                validator: (value) {
                  if (value == null) {
                    return 'Informe a Descrição, por favor.';
                  } else {
                    return null;
                  }
                },
                onSaved: (value) {
                  _description = value;
                },
                maxLines: 6,
                decoration: InputDecoration(
                  labelText: 'Descrição',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 25),
              if (_i < 3)
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    InkWell(
                      onTap: () {
                        setState(() {
                          _i = _i + 1;
                        });
                      },
                      child: Chip(
                        label: Text('Resposta'),
                        avatar: Icon(
                          Icons.exposure_plus_1,
                          size: 19,
                        ),
                      ),
                    ),
                    SizedBox(width: 10),
                  ],
                ),
              Container(
                height:
                    MediaQuery.of(context).size.height * .5 * ((_i + 2) / 5),
                child: SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      TextFormField(
                        validator: (value) {
                          if (value == null) {
                            return 'Informe a Primeira Opção de Resposta, por favor.';
                          } else {
                            return null;
                          }
                        },
                        onSaved: (value) {
                          _answer1 = value;
                        },
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.edit),
                          labelText: '1ª Opção de Resposta (Obrigatório)',
                        ),
                      ),
                      TextFormField(
                        validator: (value) {
                          if (value == null) {
                            return 'Informe a Segunda Opção de Resposta, por favor.';
                          } else {
                            return null;
                          }
                        },
                        onSaved: (value) {
                          _answer2 = value;
                        },
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.edit),
                          labelText: '2ª Opção de Resposta (Obrigatório)',
                        ),
                      ),
                      if (_i >= 1)
                        TextFormField(
                          validator: (value) {
                            if (value == null) {
                              _answer3 = '';
                              return null;
                            } else {
                              return null;
                            }
                          },
                          onChanged: (val) => _answer3 = val,
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.edit),
                            labelText: '3ª Opção de Resposta',
                          ),
                        ),
                      if (_i >= 2)
                        TextFormField(
                          validator: (value) {
                            if (value == null) {
                              _answer4 = '';
                              return null;
                            } else {
                              return null;
                            }
                          },
                          onChanged: (val) => _answer4 = val,
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.edit),
                            labelText: '4ª Opção de Resposta',
                          ),
                        ),
                      if (_i >= 3)
                        TextFormField(
                          validator: (value) {
                            if (value == null) {
                              _answer5 = '';
                              return null;
                            } else {
                              return null;
                            }
                          },
                          onChanged: (val) => _answer5 = val,
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.edit),
                            labelText: '5ª Opção de Resposta',
                          ),
                        ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 40),
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
                    onPressed: _addQualitativeItem,
                  ),
                ],
              ),
              SizedBox(height: 35),
            ],
          ),
        ),
      ),
    );
  }
}

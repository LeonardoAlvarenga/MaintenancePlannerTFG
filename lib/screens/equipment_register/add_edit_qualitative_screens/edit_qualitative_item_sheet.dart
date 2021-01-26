import 'package:flutter/material.dart';

import 'package:tfg_app/providers/equipment_provider.dart';

class EditQualitativeItemSheet extends StatefulWidget {
  final QualitativeModel _qualitativeModel;

  EditQualitativeItemSheet(this._qualitativeModel);

  @override
  _EditQualitativeItemSheetState createState() =>
      _EditQualitativeItemSheetState();
}

class _EditQualitativeItemSheetState extends State<EditQualitativeItemSheet> {
  final _formKey = GlobalKey<FormState>();
  String _id;
  String _inspectionName = '';
  String _description = '';
  String _answer1 = '';
  String _answer2 = '';
  String _answer3 = '';
  String _answer4 = '';
  String _answer5 = '';

  int _i = 0;

  @override
  void initState() {
    _id = widget._qualitativeModel.id;
    _inspectionName = widget._qualitativeModel.inspectionName;
    _description = widget._qualitativeModel.description;
    _answer1 = widget._qualitativeModel.answers[0];
    _answer2 = widget._qualitativeModel.answers[1];
    _answer3 = widget._qualitativeModel.answers[2];
    _answer4 = widget._qualitativeModel.answers[3];
    _answer5 = widget._qualitativeModel.answers[4];

    if (_answer5 != '') {
      _i = 3;
    }
    if (_answer4 != '') {
      _i = 2;
    }
    if (_answer3 != '') {
      _i = 1;
    }

    super.initState();
  }

  void _updateQualitativeItem() {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();

      final _listOfAnswers = [
        _answer1,
        _answer2,
        _answer3,
        _answer4,
        _answer5,
      ];

      final updatedItem = QualitativeModel(
        id: _id,
        inspectionName: _inspectionName,
        description: _description,
        answers: _listOfAnswers,
      );
      Navigator.of(context).pop(updatedItem);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          height: MediaQuery.of(context).size.height * .9,
          padding: const EdgeInsets.all(10),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  SizedBox(height: 10),
                  TextFormField(
                    initialValue: _inspectionName,
                    validator: (value) {
                      if (value == null) {
                        return 'Informe o Nome da Inspeção, por favor.';
                      } else {
                        return null;
                      }
                    },
                    onSaved: (value) {
                      _description = value;
                    },
                    decoration: InputDecoration(
                      labelText: 'Nome da Inspeção',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 15),
                  TextFormField(
                    initialValue: _description,
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
                    height: MediaQuery.of(context).size.height * .5,
                    child: SingleChildScrollView(
                      child: Column(
                        children: <Widget>[
                          TextFormField(
                            initialValue: _answer1,
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
                            initialValue: _answer2,
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
                              initialValue: _answer3,
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
                              initialValue: _answer4,
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
                              initialValue: _answer5,
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
                  SizedBox(height: 35),
                ],
              ),
            ),
          ),
        ),
        Positioned(
          bottom: 10,
          right: 100,
          left: 100,
          child: RaisedButton.icon(
            icon: Icon(
              Icons.save_alt,
              color: Colors.white,
            ),
            color: Theme.of(context).appBarTheme.color,
            label: Text(
              'Salvar Alteração',
              style: TextStyle(color: Colors.white),
            ),
            onPressed: _updateQualitativeItem,
          ),
        ),
      ],
    );
  }
}

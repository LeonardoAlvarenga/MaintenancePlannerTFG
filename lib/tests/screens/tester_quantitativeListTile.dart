import 'package:flutter/material.dart';

class TesterQuantitativeListTile extends StatefulWidget {
  @override
  _TesterQuantitativeListTileState createState() =>
      _TesterQuantitativeListTileState();
}

class _TesterQuantitativeListTileState
    extends State<TesterQuantitativeListTile> {
  int _i = 0;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          height: MediaQuery.of(context).size.height * .9,
          padding: const EdgeInsets.all(10),
          child: Form(
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  SizedBox(height: 10),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Nome da Inspeção',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 15),
                  TextFormField(
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
                            decoration: InputDecoration(
                              prefixIcon: Icon(Icons.edit),
                              labelText: '1ª Opção de Resposta (Obrigatório)',
                            ),
                          ),
                          TextFormField(
                            decoration: InputDecoration(
                              prefixIcon: Icon(Icons.edit),
                              labelText: '2ª Opção de Resposta (Obrigatório)',
                            ),
                          ),
                          if (_i >= 1)
                            TextFormField(
                              decoration: InputDecoration(
                                prefixIcon: Icon(Icons.edit),
                                labelText: '3ª Opção de Resposta',
                              ),
                            ),
                          if (_i >= 2)
                            TextFormField(
                              decoration: InputDecoration(
                                prefixIcon: Icon(Icons.edit),
                                labelText: '4ª Opção de Resposta',
                              ),
                            ),
                          if (_i >= 3)
                            TextFormField(
                              decoration: InputDecoration(
                                prefixIcon: Icon(Icons.edit),
                                labelText: '5ª Opção de Resposta',
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 25),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      SizedBox(width: 10),
                    ],
                  ),
                  SizedBox(height: 15),
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
              'Salvar Inspeção',
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () {},
          ),
        ),
      ],
    );
  }
}

/* 
  Arquivo do App responsável por ler os elementos da LISTA DE QUANTITATIVOS e criar instâncias de ListTile contendo seus valores(id, nome, valores mínimo e máximo).
  Além disso, organiza-os em uma ListView para então retornar ao body de Scaffold, em MyHomePage.
  Também cria um botão de "delete instância de ListTile", com base no id e no nome da mesma.
*/

import 'package:flutter/material.dart';

import '../models/quantitative.dart';

class QuantitativeList extends StatelessWidget {
  final List<Quantitative> listOfQuantitatives;
  final Function deleteQuantitative;

  QuantitativeList(
      {@required this.listOfQuantitatives, @required this.deleteQuantitative});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10),
      height: 300,
      child: listOfQuantitatives.isEmpty
          ? Column(
              children: <Widget>[
                Text(
                  'Aguardando Parâmetros Quantitativos',
                  style: Theme.of(context).textTheme.headline3,
                ),
                SizedBox(height: 25),
                Container(
                  height: 180,
                  child: Image.asset(
                    'assets/images/waiting.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            )
          : ListView.builder(
              itemCount: listOfQuantitatives.length,
              itemBuilder: (ctx, index) {
                return Card(
                  child: ListTile(
                    leading: CircleAvatar(
                      radius: 35,
                      child: Container(
                        padding: EdgeInsets.all(10),
                        child: FittedBox(
                          child: Text(
                            listOfQuantitatives[index].unitName,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ),
                    ),
                    trailing: IconButton(
                      icon: Icon(
                        Icons.delete_outline,
                        color: Theme.of(context).errorColor,
                      ),
                      onPressed: () => deleteQuantitative(
                          listOfQuantitatives[index].parameterName, listOfQuantitatives[index].id),
                    ),
                    title: Text(
                      listOfQuantitatives[index].parameterName,
                      style: Theme.of(context).textTheme.headline4,
                    ),
                    subtitle: Row(
                      children: <Widget>[
                        Text(
                          'Min: ${listOfQuantitatives[index].minValue}',
                          style: Theme.of(context).textTheme.headline5,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          'Max: ${listOfQuantitatives[index].maxValue}',
                          style: Theme.of(context).textTheme.headline5,
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}

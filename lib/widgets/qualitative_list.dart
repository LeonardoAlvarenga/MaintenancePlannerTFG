/* 
  Arquivo do App responsável por ler os elementos da LISTA DE QUALITATIVOS e criar instâncias de ListTile contendo seus valores(id, nome, descrição).
  Além disso, organiza-os em uma ListView para então retornar ao body de Scaffold, em MyHomePage.
  Também cria um botão de "delete instância de ListTile", com base no id e no nome da mesma.
*/

import 'package:flutter/material.dart';

import '../models/qualitative.dart';

class QualitativeList extends StatelessWidget {
  final List<Qualitative> listOfQualitatives;
  final Function deleteQualitative;

  QualitativeList(
      {@required this.listOfQualitatives, @required this.deleteQualitative});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      padding: EdgeInsets.symmetric(vertical: 10),
      child: listOfQualitatives.isEmpty
          ? Column(
              children: <Widget>[
                Text(
                  'Aguardando Parâmetros Qualitativos',
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
              itemCount: listOfQualitatives.length,
              itemBuilder: (ctx, index) {
                return Card(
                  child: ListTile(
                    leading: CircleAvatar(
                        radius: 30,
                        child: FittedBox(
                          child: Text(
                            '${index + 1}',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                        )),
                    title: Text(
                      listOfQualitatives[index].parameterName,
                      style: Theme.of(context).textTheme.headline4,
                    ),
                    subtitle: Text(
                      listOfQualitatives[index].parameterDescription,
                      style: Theme.of(context).textTheme.headline5,
                    ),
                    trailing: IconButton(
                      icon: Icon(Icons.delete_outline),
                      onPressed: () => deleteQualitative(
                          listOfQualitatives[index].parameterName, listOfQualitatives[index].id),
                      color: Theme.of(context).errorColor,
                    ),
                  ),
                );
              },
            ),
    );
  }
}

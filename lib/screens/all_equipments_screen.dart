import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

import '../providers/equipments_provider.dart';
import '../models/equipment_model.dart';
import './equipment_details_screen.dart';

class AllEquipmentsScreen extends StatelessWidget {
  static const routeName = '/all-equipments-screen';

  @override
  Widget build(BuildContext context) {
    final equipsData = Provider.of<Equipments>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Controle de Ativos'),
      ),
      body: ListView.builder(
        itemCount: equipsData.listOfEquipments.length,
        itemBuilder: (ctx, index) {
          return EquipmentItem(equipsData.listOfEquipments[index]);
        },
      ),
    );
  }
}

class EquipmentItem extends StatefulWidget {
  final EquipmentModel equipment;

  EquipmentItem(this.equipment);

  @override
  _EquipmentItemState createState() => _EquipmentItemState();
}

class _EquipmentItemState extends State<EquipmentItem> {
  bool _expanded = false;

  String equipCriticity(EquipCriticity equipCrit) {
    if (equipCrit == EquipCriticity.LessImportant) {
      return 'Pouco Importante';
    }
    if (equipCrit == EquipCriticity.Normal) {
      return 'Importante';
    }
    if (equipCrit == EquipCriticity.HighlyImportant) {
      return 'Muito Importante';
    } else {
      return 'Não Declarado';
    }
  }

  Widget _infoCardBuilder(String parameter, String answer) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 4.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(parameter),
            if (answer != null) Text(answer),
            if (answer == null) Text('Não Declarado')
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Divider(
          color: Theme.of(context).primaryColorDark,
        ),
        Container(
          color: Theme.of(context).primaryColorDark,
          child: ListTile(
            leading: ClipRect(
              child: Container(
                width: MediaQuery.of(context).size.width * .25,
                child: Image.network(
                  widget.equipment.equipImageUrl,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            title: Text(
              widget.equipment.equipName,
              style: TextStyle(
                  color: Colors.grey[100],
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
            ),
            subtitle: Text(
              widget.equipment.equipLocalization,
              style: TextStyle(color: Colors.grey),
            ),
            trailing: IconButton(
              icon: Icon(
                _expanded ? Icons.expand_less : Icons.expand_more,
                color: Theme.of(context).accentColor,
              ),
              onPressed: () {
                setState(() {
                  _expanded = !_expanded;
                });
              },
            ),
          ),
        ),
        if (_expanded)
          Container(
            color: Theme.of(context).primaryColorDark,
            child: Column(
              children: <Widget>[
                Divider(
                  height: 0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Chip(
                      label: Text('ID: ${widget.equipment.equipID}',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold)),
                      backgroundColor: Theme.of(context).accentColor,
                    ),
                    SizedBox(
                      width: 20,
                    ),
                  ],
                ),
                Container(
                  height: MediaQuery.of(context).size.height * .2,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      width: 1,
                    ),
                  ),
                  margin: EdgeInsets.all(10),
                  child: ListView(
                    itemExtent: 45,
                    padding: EdgeInsets.symmetric(
                      horizontal: 5,
                      vertical: 10,
                    ),
                    children: <Widget>[
                      _infoCardBuilder('Criticidade:',
                          equipCriticity(widget.equipment.equipCriticity)),
                      _infoCardBuilder('Sistema:', null),
                      _infoCardBuilder('Subsistema:', null),
                      _infoCardBuilder('Componente:', null),
                      _infoCardBuilder(
                        'Inicio da Operação: ',
                        DateFormat('dd/MM/yyyy').format(
                          DateTime.now(),
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    RaisedButton.icon(
                      splashColor: Colors.teal,
                      // color: Theme.of(context).appBarTheme.color,
                      elevation: 5,
                      onPressed: () {
                        Navigator.of(context).pushNamed(
                            ViewEquipScreen.routeName,
                            arguments: widget.equipment.equipID);
                      },
                      icon: Icon(
                        Icons.search,
                      ),
                      label: Text(
                        'Mais Detalhes',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(width: 10),
                  ],
                ),
                Divider(),
              ],
            ),
          ),
      ],
    );
  }
}
